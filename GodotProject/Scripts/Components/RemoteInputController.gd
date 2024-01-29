extends BaseInputController

var direction: Vector2
var attackInputJustPressed: bool 


func GetDirectionInput() -> Vector2:
#
	#This needs to return 
	
	#Vector2(0,0) when player is not holding any movement keys
	#Vector2(1, 0) when player holds move right
	#Vector2(-1, 0) when player holds move left
	#Vector2(0, -1) when player holds move up
	#Vector2(0, 1) when player holds move down
	#Vector2(1, 1) when player holds both move right and down
	#etc...
	
	return Vector2.ZERO;
#

func GetAttackInputPressed() -> bool:
#
	#return true when the player has JUST pressed the attack button (Unity's OnButtonDown)

	return false;
#
