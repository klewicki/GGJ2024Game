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
var isAttacking: bool = false;

enum AnimationType {Idle, Movement, Attack}

func _ready():
#
	lastDirection = Vector2.DOWN;

	healthController.HealthSubtracted.connect(OnDamageReceived);
	healthController.HealthDepleted.connect(OnHealthDepleted);
	attackController.AttackStarted.connect(OnAttackStarted);
	attackController.AttackFinished.connect(OnAttackFinished);
#

func _process(_delta):
#
	UpdateDirectionInput();
	HandleAttack();
	
	HandleAnimation();
	
# _process()	


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

func HandleAnimation():
#
	if(isAttacking):
		return;
		
	if(direction != Vector2.ZERO):
		animatedSprite.PlayAnimation(direction, AnimationType.Movement);
	else:
		animatedSprite.PlayAnimation(lastDirection, AnimationType.Idle);
#

func _integrate_forces(state: PhysicsDirectBodyState2D):
#
	if((receivingDamage || isAttacking) && !wasStopped):
	#
		wasStopped = true;
		state.linear_velocity = Vector2.ZERO;
	#
	
	if(!receivingDamage && !isAttacking):
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
	if(receivingDamage):
		return;
		
	if(GetAttackInput()):
	#
		attackController.Attack(lastDirection);
	#	
# HandleAttack()

func OnAttackStarted():
#
	isAttacking = true;
	
	animatedSprite.PlayAnimationOnce(lastDirection, AnimationType.Attack);
#

func OnAttackFinished():
#
	print("Finished")
	isAttacking = false;
#


func OnHealthDepleted():
#
	#Game Over
	
	queue_free();
#

func OnDamageReceived():
#	
	receivingDamage = true;
	animatedSprite.modulate = Color(1, 0, 0, 1);
	
	await get_tree().create_timer(0.2).timeout
	
	receivingDamage = false;
	animatedSprite.modulate = Color(1, 1, 1, 1);
#

