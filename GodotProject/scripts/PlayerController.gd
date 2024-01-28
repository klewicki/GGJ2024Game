extends RigidBody2D

var viewportRect = Vector2.ZERO;
var direction = Vector2.ZERO;
var lastDirection = Vector2.ZERO;

@onready var moveController = $MoveController 
@onready var attackController = $AttackController
@onready var animatedSprite = $AnimatedSprite2D

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
	direction = Vector2.ZERO;

	if(Input.is_action_pressed("MoveUp")):
		direction.y -= 1;
		
	if(Input.is_action_pressed("MoveDown")):
		direction.y += 1;
	
	if(Input.is_action_pressed("MoveLeft")):
		direction.x -= 1;
	
	if(Input.is_action_pressed("MoveRight")):
		direction.x += 1;
		
	if(direction.x != 0 || direction.y != 0):
		lastDirection = direction;
	
# UpdateDirectionInput()

func GetAttackInput() -> bool:
	return Input.is_action_just_pressed("Attack")

	
func HandleAttack():
#
	if(GetAttackInput()):
		attackController.Attack(lastDirection);
		
# HandleAttack()