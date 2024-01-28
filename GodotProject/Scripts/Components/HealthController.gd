extends Node

signal HealthDepleted

@export var MaxHealth: float = 100;

var CurrentHealth: float;

func _ready():
	CurrentHealth = MaxHealth;

func SubtractHealth(amount: float):
#
	if(CurrentHealth <= 0):
		return;

	CurrentHealth -= amount;

	print("Subtracting Health! Current Health: " + str(CurrentHealth));
		
	if(CurrentHealth <= 0):
	#
		HealthDepleted.emit();
		return;
	#
#

func AddHealth(amount: float):
#
	CurrentHealth += amount;

	if(CurrentHealth > MaxHealth):
		CurrentHealth = MaxHealth
#
