extends AnimatedSprite2D

enum AnimationType {Idle, Movement, Attack}

func PlayAnimation(direction: Vector2, animationType: AnimationType = AnimationType.Idle):
#
	animation = GetAnimation(animationType, direction);
	play();
#

func GetAnimation(animationType: AnimationType, direction: Vector2) -> String:
#
	if(direction.x > 0):
	#
		return "Idle_Right";
	#
	elif(direction.x < 0):
	#
		return "Idle_Left";
	#
	elif(direction.y < 0):
	#
		return "Idle_Up";
	#
	elif(direction.y > 0):
	#
		return "Idle_Down";
	#
	
	return "";
#
