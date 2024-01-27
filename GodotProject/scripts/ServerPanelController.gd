class_name ServerPanelController
extends Node

@export
var GameplayScene : PackedScene
@export
var ServerPanel : Panel
@export
var PlayerCountLabel : Label

func StartGameClicked():
	print("Start game button clicked!");
	get_tree().root.add_child(GameplayScene.instantiate());
	ServerPanel.hide();
	return;
	
func UpdatePlayerCount(newCount : int):
	print("Player count updated to " + str(newCount));
	PlayerCountLabel.text = str(newCount);

