extends Node

@export
var ClientServerSelectionPanel : Panel

@export
var ServerPanel : Panel

func ServerButtonClicked():
	print("server button clicked!");
	#TODO: do logic
	ServerPanel.set_process(true);
	ServerPanel.show();
	
	ClientServerSelectionPanel.set_process(false);
	ClientServerSelectionPanel.hide();
	return;
	
func ClientButtonClicked():
	print("client button clicked!");
	#TODO: do logic
	ClientServerSelectionPanel.set_process(false);
	ClientServerSelectionPanel.hide();
	return;
