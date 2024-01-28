extends RigidBody2D

var viewportRect = Vector2.ZERO;
var direction = Vector2.ZERO;
var lastDirection = Vector2.ZERO;

@onready var moveController = $MoveController 
@onready var attackController = $AttackController
@onready var animatedSprite = $AnimatedSprite2D
@onready var inputController = $InputController

func _ready():
	lastDirection = Vector2.DOWN;

func _process(_delta):
#
	UpdateDirectionInput();
	HandleAttack();
	
	animatedSprite.PlayAnimation(lastDirection);
# _process()	

func _integrate_forces(state: PhysicsDirectBodyState2D):
#
	state.linear_velocity = moveController.GetVelocityForDirection(direction);
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
