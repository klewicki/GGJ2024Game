class_name ServerClientSelector
extends Node

@export
var ServerPrefab : PackedScene;
@export
var ClientPrefab : PackedScene;

@export
var ClientServerSelectionPanel : Panel;
@export
var ClientPanel : Panel;
@export
var ServerPanel : Panel;

func ServerButtonClicked():
	print("server button clicked!");
	var serverInstance = ServerPrefab.instantiate();
	get_tree().root.add_child(serverInstance);
	var server = serverInstance as Server;
	server.PanelController = ServerPanel.get_script() as ServerPanelController
	ServerPanel.set_process(true);
	ServerPanel.show();
	
	ClientServerSelectionPanel.set_process(false);
	ClientServerSelectionPanel.hide();
	return;
	
func ClientButtonClicked():
	print("client button clicked!");
	var clientInstance = ClientPrefab.instantiate();
	get_tree().root.add_child(clientInstance);
	var client = clientInstance as Client;
	client.PanelController = ClientPanel.get_script() as ClientPanelController
	ClientPanel.set_process(true);
	ClientPanel.show();
	client.Start();
	
	ClientServerSelectionPanel.set_process(false);
	ClientServerSelectionPanel.hide();
	return;
