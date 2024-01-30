class_name ClientPanelController
extends Panel

@export
var DebugLabel : Label;

@export
var Power0Button : Button;
@export
var Power1Button : Button;
@export
var Power2Button : Button;

var ClientServerInstance : ClientServer;

func DisplayDebugMessage(message : String):
	DebugLabel.text += message + "\n";
	
func UsePower(powerId : int):
	ClientServerInstance.UsePower(powerId);
	return;
	
func SetPowerButtonEnabled(button : int, enabled : bool):
	if(button == 0):
		Power0Button.disabled = !enabled;
	elif(button == 1):
		Power1Button.disabled = !enabled;
	elif(button == 2):
		Power2Button.disabled = !enabled;
	else:
		DisplayDebugMessage("Illegal button number used in SetBowerButtonEnabled: " + str(button));
	return;


func _on_up_texture_button_button_up():
	print("Up up!");
	ClientServerInstance.SetClientButtonPressedState(ClientServer.EClientButtons.UP, false);


func _on_down_texture_button_button_up():
	print("Down up!");
	ClientServerInstance.SetClientButtonPressedState(ClientServer.EClientButtons.DOWN, false);


func _on_left_texture_button_button_up():
	print("Left up!");
	ClientServerInstance.SetClientButtonPressedState(ClientServer.EClientButtons.LEFT, false);


func _on_right_texture_button_button_up():
	print("Right up!");
	ClientServerInstance.SetClientButtonPressedState(ClientServer.EClientButtons.RIGHT, false)


func _on_attack_texture_button_button_up():
	print("Attack up!");
	ClientServerInstance.SetClientButtonPressedState(ClientServer.EClientButtons.ATTACK, false)


func _on_up_texture_button_pressed():
	pass # Replace with function body.


func _on_down_texture_button_pressed():
	pass # Replace with function body.


func _on_left_texture_button_pressed():
	pass # Replace with function body.


func _on_right_texture_button_pressed():
	pass # Replace with function body.


func _on_attack_texture_button_pressed():
	pass # Replace with function body.


func _on_up_texture_button_button_down():
	print("Up down!");
	ClientServerInstance.SetClientButtonPressedState(ClientServer.EClientButtons.UP, true);


func _on_down_texture_button_button_down():
	print("Down down!");
	ClientServerInstance.SetClientButtonPressedState(ClientServer.EClientButtons.DOWN, true);


func _on_left_texture_button_button_down():
	print("Left down!");
	ClientServerInstance.SetClientButtonPressedState(ClientServer.EClientButtons.LEFT, true);


func _on_right_texture_button_button_down():
	print("Right down!");
	ClientServerInstance.SetClientButtonPressedState(ClientServer.EClientButtons.RIGHT, true);


func _on_attack_texture_button_button_down():
	print("Attack down!");
	ClientServerInstance.SetClientButtonPressedState(ClientServer.EClientButtons.ATTACK, true);
