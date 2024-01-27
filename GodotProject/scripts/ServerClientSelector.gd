extends Node

@export
var ServerPrefab : PackedScene;

@export
var ClientServerSelectionPanel : Panel;

@export
var ServerPanel : Panel;

func ServerButtonClicked():
	print("server button clicked!");
	get_tree().root.add_child(ServerPrefab.instantiate());
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
