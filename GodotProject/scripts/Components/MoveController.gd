extends Node

@export var Speed: float = 100;
@export var NormalizeDirection: bool = true;

func GetVelocityForDirection(direction: Vector2) -> Vector2:
#
	var dir = direction;
	
	if(NormalizeDirection):
		dir = dir.normalized();
		
	var velocity = dir * Speed;

	return velocity;	
# GetVelocityForDirection()
