extends RigidBody2D

var viewportRect = Vector2.ZERO;
var direction = Vector2.ZERO;
var lastDirection = Vector2.ZERO;

@onready var moveController = $MoveController 
@onready var attackController = $AttackController
@onready var animatedSprite = $AnimatedSprite2D
@onready var inputController = $InputController
@onready var healthController = $HealthController

var receivingDamage: bool = false;
var wasStopped: bool = false;

func _ready():
#
	lastDirection = Vector2.DOWN;

	healthController.HealthSubtracted.connect(OnDamageReceived);
	healthController.HealthDepleted.connect(OnHealthDepleted);
#

func _process(_delta):
#
	UpdateDirectionInput();
	HandleAttack();
	
	animatedSprite.PlayAnimation(lastDirection);
# _process()	

func _integrate_forces(state: PhysicsDirectBodyState2D):
#
	if(receivingDamage && !wasStopped):
	#
		wasStopped = true;
		state.linear_velocity = Vector2.ZERO;
	#
	
	if(!receivingDamage):
	#
		wasStopped = false;
		state.linear_velocity = moveController.GetVelocityForDirection(direction);
	#
# _integrate_forces

func UpdateDirectionInput():
#
	direction = inputController.GetDirectionInput();
		
	if(direction.x != 0 || direction.y != 0):
		lastDirection = direction;
	
# UpdateDirectionInput()

func GetAttackInput() -> bool:
	return inputController.GetAttackInputPressed();

	
func HandleAttack():
#
	if(GetAttackInput()):
		attackController.Attack(lastDirection);
		
# HandleAttack()

func OnHealthDepleted():
#
	#Game Over
	
	queue_free();
#

func OnDamageReceived():
#
	print("Damage received!")
	
	receivingDamage = true;
	animatedSprite.modulate = Color(1, 0, 0, 1);
	
	await get_tree().create_timer(0.2).timeout
	
	receivingDamage = false;
	animatedSprite.modulate = Color(1, 1, 1, 1);
#

