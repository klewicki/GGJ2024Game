class_name ClientPanelController
extends Panel

@export
var DebugLabel : Label;

func DisplayDebugMessage(message : String):
	DebugLabel.text += message + "\n";
