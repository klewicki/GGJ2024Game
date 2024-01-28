extends Node

enum AttackType {Melee, Range}

@export var Damage: float = 10;
@export var PushForce: float = 10;
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
@onready var swooshLeft = $SwooshLeft
@onready var swooshUp = $SwooshUp
@onready var swooshDown = $SwooshDown

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
	swooshLeft.animation_finished.connect(OnAnimationFinished);
	swooshUp.animation_finished.connect(OnAnimationFinished);
	swooshDown.animation_finished.connect(OnAnimationFinished);
#

func Attack(direction: Vector2):
#
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
	var noSwooshAnim = "NoSwoosh";

	swooshRight.animation = noSwooshAnim;
	swooshRight.stop();
	
	swooshLeft.animation = noSwooshAnim;
	swooshLeft.stop();
	
	swooshUp.animation = noSwooshAnim;
	swooshUp.stop();
	
	swooshDown.animation = noSwooshAnim;
	swooshDown.stop();
#

func PlaySwoosh(swoosh: AnimatedSprite2D):
#
	swoosh.animation = "Swoosh";
	swoosh.play();
#

func MeleeAttack(direction: Vector2):
#
	if(direction.x > 0):
	#
		DealDamageToEnemies(enemiesOnTheRight, direction);
		
		PlaySwoosh(swooshRight);
	#
	elif(direction.x < 0):
	#
		DealDamageToEnemies(enemiesOnTheLeft, direction);
		
		PlaySwoosh(swooshLeft);
	#
	elif(direction.y < 0):
	#
		DealDamageToEnemies(enemiesAbove, direction);
		
		PlaySwoosh(swooshUp);
	#
	elif(direction.y > 0):
	#
		DealDamageToEnemies(enemiesBelow, direction);
		
		PlaySwoosh(swooshDown);
	#
#

func DealDamageToEnemies(enemies: Array[Node2D], direction: Vector2):
#
	for i in enemies.size():
	#
		var enemy = enemies[i];
		var enemyHealth = enemies[i].get_node("./HealthController");
	
		if(enemy is RigidBody2D):
		#
			print(direction * PushForce);0
			enemy.apply_force(direction * PushForce);
		#
		
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
