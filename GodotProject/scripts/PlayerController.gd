extends RigidBody2D

var viewportRect = Vector2.ZERO;
var direction = Vector2.ZERO;

@onready var moveController = $MoveController 

func _process(_delta):
#
	UpdateDirectionInput();
	HandleAttack();
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
# UpdateDirectionInput()

func GetAttackInput() -> bool:
	return Input.is_action_just_pressed("Attack")

	
func HandleAttack():
#
	if(GetAttackInput()):
		print("Attack");
# HandleAttack()