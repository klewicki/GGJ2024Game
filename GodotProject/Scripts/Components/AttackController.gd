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

func _ready():
#
	attackBoxRight.body_entered.connect(OnAttackBoxRightEnter);
	attackBoxRight.body_exited.connect(OnAttackBoxRightExit);
#

func _process(_delta):
#
	pass
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

func MeleeAttack(direction: Vector2):
#
	pass
#

func RangeAttack(direction: Vector2):
# 
	pass
#

func OnAttackBoxRightEnter(body: Node2D):
#
	enemiesAbove.append(body);
#

func OnAttackBoxRightExit(body: Node2D):
#
	var indexToRemove = -1;
	
	for i in enemiesAbove.size():
	#
		if(enemiesAbove[i] == body):
		#
			indexToRemove = i;
			break;
		#
	#
	
	enemiesAbove.remove_at(indexToRemove);
#
