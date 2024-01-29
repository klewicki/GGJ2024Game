extends RigidBody2D

enum EnemyState {None, Idle, Chasing, Attacking, Hurt, Dead}
enum EnemyType {Melee, Range}

@export var debugStates: bool

@export var AttackRate: int
@export var Damage: float

@export var chasingRange: float
@export var attackRange: float

@onready var moveController = $MoveController 
@onready var attackTimer = $AttackTimer # get_node("/AttackTimer")
@onready var healthController = $HealthController
@onready var animatedSprite = $AnimatedSprite2D
@onready var attackController = $AttackController

var player: Node2D
var currentState: EnemyState 
var wasStopped = false
var isAttacking = false;
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
#
	HandleState();
	
	pass
#

func _physics_process(delta):
#
	#Godot Fucking Sucks That Why I Use This Line,
	#Basically... the Godot docs states that I should not be manipulating RB velocity outside of _integrate_forces method
	#But!
	#Integrate forces method is only invoked when there is a physics change on the object. Sooooo...
	#In order to be able to only add velocity when the player is being chased, I need to invoke the _integrate_forces manually by doing some miniscule physics change on the object constantly. 
	#making it  basically a glorified _physics_process method in which I can manipulate velocity safely with the Physics2D Engine
	#Probably there is a better way of doing this, but it's my third  day in Godot, so fuck it.  
	apply_force(Vector2(0.000000000000000001, 0));
#

func _integrate_forces(state: PhysicsDirectBodyState2D):
#
	if(currentState == EnemyState.Hurt && !wasStopped):
	#
		wasStopped = true;
		state.linear_velocity = Vector2(0,0);
	#
	
	if(currentState != EnemyState.Hurt):
	#
		wasStopped = false;
		
		if(currentState == EnemyState.Chasing):
			state.linear_velocity = moveController.GetVelocityForDirection(direction);
			
	#
# _integrate_forces
	
func GetPlayerPosition() -> Vector2:
#
	if(player == null):
	#
		var playerGroupNodes = get_tree().get_nodes_in_group("Player");
	
		if(playerGroupNodes.size() == 0):
			return Vector2.ZERO;
			
		player = playerGroupNodes[0];
	#
	
	if(player == null):
		return Vector2.ZERO;
	
	return player.global_position;
#

func GetDirectionTowardsPlayer() -> Vector2:
#
	var playerPosition = GetPlayerPosition();
	
	return (playerPosition - position).normalized();
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
			LookingForPlayer();
		EnemyState.Chasing:
			Debug("Enemy State: Chasing");
			Chasing();
		EnemyState.Attacking:
			Debug("Enemy State: Attacking");
			Attacking();
		EnemyState.Dead:
			Debug("Enemy State: Dead");
	#
# HandleState() 
			
func LookingForPlayer():
#
	if(IsPlayerInChasingRange()):
	#
		Debug("Enemy: Player Found");
		currentState = EnemyState.Chasing;
	# 
	
# LookingForPlayer() 
	
func Chasing():
#
	if (IsPlayerInAttackRange()):
	#
		currentState = EnemyState.Attacking;
	#
	elif (!IsPlayerInChasingRange()):
	#
		currentState = EnemyState.Idle;
	#
	else:	
	#
		direction = GetDirectionTowardsPlayer();
	#
# Chasing() 

func Attacking():
#
	if(!isAttacking):
		StartAttacking();

	if (!IsPlayerInChasingRange()):
	#
		StopAttacking();
		currentState = EnemyState.Chasing;
	#
#	

func IsPlayerInChasingRange() -> bool:
#
	var playerPosition = GetPlayerPosition();
	var distanceToPlayer = playerPosition.distance_to(position);
	
	return distanceToPlayer <= chasingRange;
#

func IsPlayerInAttackRange() -> bool:
#
	var playerPosition = GetPlayerPosition();
	var distanceToPlayer = playerPosition.distance_to(position);
	
	return distanceToPlayer <= attackRange;
#
	
func StartAttacking():
#
	isAttacking = true;
	attackTimer.start();
#	

func StopAttacking():
#
	isAttacking = false;
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
	var previousState = currentState;
	currentState = EnemyState.Hurt;
	
	animatedSprite.modulate = Color(1, 0, 0, 1);
	
	await get_tree().create_timer(0.2).timeout
	
	animatedSprite.modulate = Color(1, 1, 1, 1);
	currentState = previousState;
#
