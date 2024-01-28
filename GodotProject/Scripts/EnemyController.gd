extends RigidBody2D

enum EnemyState {None, Idle, Chasing, Attacking, Dead}
enum EnemyType {Melee, Range}

@export var debugStates: bool

@export var Health: float
@export var Speed: float

@export var currentState: EnemyState 
@export var enemyType: EnemyType

@export var canSeePlayer: bool

@export var chasingRange: float
@export var attackRange: float

var direction = Vector2.RIGHT
@onready var moveController = $MoveController 

func _ready():
	currentState = EnemyState.Idle;

func _process(delta):
	HandleState();
	pass

func _integrate_forces(state: PhysicsDirectBodyState2D):
	state.linear_velocity = moveController.GetVelocityForDirection(direction);
	
func HandleState():
#
	match currentState:
		EnemyState.Idle:
			Debug("Enemy State: Idle");
		EnemyState.Chasing:
			Debug("Enemy State: Chasing");
		EnemyState.Attacking:
			Debug("Enemy State: Attacking");
		EnemyState.Dead:
			Debug("Enemy State: Dead");
# HandleState() 
			
func LookingForPlayer():
#
	Debug("Enemy: Looking For Player");
	
	if(IsPlayerInChasingRange()):
		Debug("Enemy: Player Found");
		currentState = EnemyState.Chasing;
# LookingForPlayer() 
	
func Chasing():
#
	if(IsPlayerInAttackRange()):
		Debug("Enemy: No Player in ChasingRange");
		currentState = EnemyState.Attacking;
	else:	
		Debug("Enemy: No Player in ChasingRange");
# Chasing() 

func IsPlayerInChasingRange() -> bool:
	return false;

func IsPlayerInAttackRange() -> bool:
	return false;
	
func Debug(text: String):
#
	if(debugStates):
		print(text);
# Debug() 

