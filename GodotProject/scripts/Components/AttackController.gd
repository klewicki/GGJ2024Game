extends Node

enum AttackType {Melee, Range}

@export var Damage: float = 10;
@export var Type: AttackType;

var enemiesOnTheLeft: Array[Node2D];
var enemiesOnTheRight: Array[Node2D];
var enemiesAbove: Array[Node2D];
var enemiesBelow: Array[Node2D];

@onready var attackBoxRight = $AttackBoxRight
@onready var attackBoxLeft = $AttackBoxLeft
@onready var attackBoxUp = $AttackBoxUp
@onready var attackBoxDown = $AttackBoxDown

@onready var swooshRight = $SwooshRight

func _ready():
#
	attackBoxRight.body_entered.connect(OnAttackBoxRightEnter);
	attackBoxRight.body_exited.connect(OnAttackBoxRightExit);
	
	attackBoxLeft.body_entered.connect(OnAttackBoxLeftEnter);
	attackBoxLeft.body_exited.connect(OnAttackBoxLeftExit);
	
	attackBoxUp.body_entered.connect(OnAttackBoxUpEnter);
	attackBoxUp.body_exited.connect(OnAttackBoxUpExit);
	
	attackBoxDown.body_entered.connect(OnAttackBoxDownEnter);
	attackBoxDown.body_exited.connect(OnAttackBoxDownExit);
	
	swooshRight.animation_finished.connect(OnAnimationFinished);
#

func _process(_delta):
#
	for i in enemiesOnTheRight.size():
		print("Right: " + enemiesOnTheRight[i].name);

	for i in enemiesOnTheLeft.size():
		print("Left: " + enemiesOnTheLeft[i].name);
		
	for i in enemiesAbove.size():
		print("Up: " + enemiesAbove[i].name);
		
	for i in enemiesBelow.size():
		print("Down: " + enemiesBelow[i].name);
	pass
#

func Attack(direction: Vector2):
#
	print("Attack");

	match(Type):
	#
		AttackType.Melee:
			MeleeAttack(direction);
		AttackType.Range:		
			RangeAttack(direction);
	#
#

func OnAnimationFinished():
#
	swooshRight.animation = "NoSwoosh";
	swooshRight.stop();
#

func MeleeAttack(direction: Vector2):
#
	if(direction.x > 0):
	#
		DealDamageToEnemies(enemiesOnTheRight);
		
		swooshRight.animation = "Swoosh";
		swooshRight.play();
	#
	elif(direction.x < 0):
	#
		DealDamageToEnemies(enemiesOnTheLeft);
	#
	elif(direction.y < 0):
	#
		DealDamageToEnemies(enemiesAbove);
	#
	elif(direction.y > 0):
	#
		DealDamageToEnemies(enemiesBelow);
	#
#

func DealDamageToEnemies(enemies: Array[Node2D]):
#
	for i in enemies.size():
	#
		var enemyHealth = enemies[i].get_node("./HealthController");
		
		if(enemyHealth != null):
		#
			enemyHealth.SubtractHealth(Damage);
		#
	#
#

func RangeAttack(direction: Vector2):
# 
	pass
#

func AddEnemyToList(enemy: Node2D, enemyList: Array[Node2D]):
#
	enemyList.append(enemy);
#

func RemoveEnemyFromList(enemy: Node2D, enemyList: Array[Node2D]):
#
	var indexToRemove = -1;
	
	for i in enemyList.size():
	#
		if(enemyList[i] == enemy):
		#
			indexToRemove = i;
			break;
		#
	#
	
	enemyList.remove_at(indexToRemove);
#

func OnAttackBoxRightEnter(body: Node2D):
#
	AddEnemyToList(body, enemiesOnTheRight);
#

func OnAttackBoxRightExit(body: Node2D):
#
	RemoveEnemyFromList(body, enemiesOnTheRight);
#

func OnAttackBoxLeftEnter(body: Node2D):
#
	AddEnemyToList(body, enemiesOnTheLeft);
#

func OnAttackBoxLeftExit(body: Node2D):
#
	RemoveEnemyFromList(body, enemiesOnTheLeft);
#

func OnAttackBoxUpEnter(body: Node2D):
#
	AddEnemyToList(body, enemiesAbove);
#

func OnAttackBoxUpExit(body: Node2D):
#
	RemoveEnemyFromList(body, enemiesAbove);
#

func OnAttackBoxDownEnter(body: Node2D):
#
	AddEnemyToList(body, enemiesBelow);
#

func OnAttackBoxDownExit(body: Node2D):
#
	RemoveEnemyFromList(body, enemiesBelow);
#