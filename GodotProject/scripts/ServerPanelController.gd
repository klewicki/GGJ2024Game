extends Node

@export
var GameplayScene : PackedScene
@export
var ServerPanel : Panel

func StartGameClicked():
	print("Start game button clicked!");
	get_tree().root.add_child(GameplayScene.instantiate());
	ServerPanel.hide();
	return;
	
