extends RigidBody2D

@export var PlayerSpeed = 400;

var viewportRect = Vector2.ZERO;
var direction = Vector2.ZERO;


# Called when the node enters the scene tree for the first time.
func _ready():
	viewportRect = get_viewport_rect().size;
	position.x = viewportRect.x / 2;
	position.y = viewportRect.y / 2;

func UpdateDirectionInput():
	direction = Vector2.ZERO;

	if(Input.is_action_pressed("MoveUp")):
		direction.y -= 1;
		
	if(Input.is_action_pressed("MoveDown")):
		direction.y += 1;
	
	if(Input.is_action_pressed("MoveLeft")):
		direction.x -= 1;
	
	if(Input.is_action_pressed("MoveRight")):
		direction.x += 1;

func GetAttackInput() -> bool:
	return Input.is_action_just_pressed("Attack")

func HandleMovement(delta: float):
	var normalizedDirection = direction.normalized();
	
	position += normalizedDirection * PlayerSpeed * delta;
	
func HandleAttack():
	if(GetAttackInput()):
		print("Attack")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	UpdateDirectionInput();
	HandleMovement(delta);
	HandleAttack();
	

