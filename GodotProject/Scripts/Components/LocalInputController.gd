extends BaseInputController

var direction: Vector2
var attackInputJustPressed: bool 

func _process(delta):
#
	UpdateDirectionInput();
	
	attackInputJustPressed = Input.is_action_just_pressed("Attack");
#

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
#

func GetDirectionInput() -> Vector2:
#
	return direction;
#

func GetAttackInputPressed() -> bool:
#
	return attackInputJustPressed;
#
