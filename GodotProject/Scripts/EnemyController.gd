extends RigidBody2D

enum EnemyState {None, Idle, Chasing, Attacking, Hurt, Dead}
enum EnemyType {Melee, Range}

@export var debugStates: bool

@export var AttackRate: int
@export var Damage: float

@export var currentState: EnemyState 
@export var enemyType: EnemyType

@export var canSeePlayer: bool

@export var chasingRange: float
@export var attackRange: float

@onready var moveController = $MoveController 
@onready var attackTimer = $AttackTimer # get_node("/AttackTimer")
@onready var healthController = $HealthController
@onready var animatedSprite = $AnimatedSprite2D

var wasStopped = false

var direction = Vector2.ZERO

func _ready():
#
	attackTimer.wait_time = AttackRate;
	attackTimer.timeout.connect(Attack);
	currentState = EnemyState.Idle;
	
	healthController.HealthSubtracted.connect(OnDamageReceived);
	healthController.HealthDepleted.connect(OnHealthDepleted);
	
# _ready()

func _process(delta):
	HandleState();
	pass

func _integrate_forces(state: PhysicsDirectBodyState2D):
	if(currentState == EnemyState.Hurt && !wasStopped):
	#
		wasStopped = true;
		state.linear_velocity = Vector2(0,0);
	#
	
	if(currentState != EnemyState.Hurt):
	#
		wasStopped = false;
		state.linear_velocity = moveController.GetVelocityForDirection(direction);
	#
	
func HandleState():
#
	if(healthController.CurrentHealth <= 0):
		currentState = EnemyState.Dead;

	if(currentState != EnemyState.Attacking):
		StopAttacking();

	match currentState:
	#
		EnemyState.Idle:
			Debug("Enemy State: Idle");
		EnemyState.Chasing:
			Debug("Enemy State: Chasing");
		EnemyState.Attacking:
			Debug("Enemy State: Attacking");
		EnemyState.Dead:
			Debug("Enemy State: Dead");
	#
# HandleState() 
			
func LookingForPlayer():
#
	Debug("Enemy: Looking For Player");
	
	if(IsPlayerInChasingRange()):
	#
		Debug("Enemy: Player Found");
		currentState = EnemyState.Chasing;
	# 
	
# LookingForPlayer() 
	
func Chasing():
#
	if(IsPlayerInAttackRange()):
	#
		Debug("Enemy: No Player in ChasingRange");
		currentState = EnemyState.Attacking;
	#
	else:	
	#
		Debug("Enemy: No Player in ChasingRange");
	#
# Chasing() 

func IsPlayerInChasingRange() -> bool:
	return false;

func IsPlayerInAttackRange() -> bool:
	return false;
	
func StartAttacking():
#
	attackTimer.start();
#	

func StopAttacking():
#
	attackTimer.stop();
#

func Attack() -> void:
#
	if(currentState != EnemyState.Attacking):
		return;

	Debug("Attack!");
#
	
func Debug(text: String):
#
	if(debugStates):
		print(text);
# Debug() 

func OnHealthDepleted():
#
	currentState = EnemyState.Dead;
	
	queue_free();
#

func OnDamageReceived():
#
	print("Damage received!")

	var previousState = currentState;
	currentState = EnemyState.Hurt;
	
	animatedSprite.modulate = Color(1, 0, 0, 1);
	
	await get_tree().create_timer(0.2).timeout
	
	animatedSprite.modulate = Color(1, 1, 1, 1);
	currentState = previousState;
#