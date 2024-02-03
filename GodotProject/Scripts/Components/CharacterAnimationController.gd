extends AnimatedSprite2D

enum AnimationType {Idle, Movement, Attack}

var playOnceOverrides: bool = false;

func PlayAnimation(direction: Vector2, animationType: AnimationType = AnimationType.Idle):
#
	if(playOnceOverrides):
		return;

	animation = GetAnimation(animationType, direction);
	play();
#

func PlayAnimationOnce(direction: Vector2, animationType: AnimationType, returnAnimationType: AnimationType = AnimationType.Idle):
#
	animation = GetAnimation(animationType, direction);
	play();
	playOnceOverrides = true;
	
	await animation_finished;
	
	animation = GetAnimation(returnAnimationType, direction);
	play();
	playOnceOverrides = false;
#

func GetAnimation(animationType: AnimationType, direction: Vector2) -> String:
#
	if(direction.x > 0):
	#
		match animationType:
			AnimationType.Idle:
				return "Idle_Right";
			AnimationType.Movement:
				return "Walk_Right";
			AnimationType.Attack:
				return "Attack_Right";
	#
	elif(direction.x < 0):
	#
		match animationType:
			AnimationType.Idle:
				return "Idle_Left";
			AnimationType.Movement:
				return "Walk_Left";
			AnimationType.Attack:
				return "Attack_Left";
	#
	elif(direction.y < 0):
	#
		match animationType:
			AnimationType.Idle:
				return "Idle_Up";
			AnimationType.Movement:
				return "Walk_Up";
			AnimationType.Attack:
				return "Attack_Up";
	#
	elif(direction.y > 0):
	#
		match animationType:
			AnimationType.Idle:
				return "Idle_Down";
			AnimationType.Movement:
				return "Walk_Down";
			AnimationType.Attack:
				return "Attack_Down";
	#
	
	return "";
#
