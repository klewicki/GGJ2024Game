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
