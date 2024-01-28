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
	var serverPanelController = ServerPanel as ServerPanelController;
	server.PanelController = serverPanelController;
	ServerPanel.set_process(true);
	ServerPanel.show();
	server.Start()
	
	ClientServerSelectionPanel.set_process(false);
	ClientServerSelectionPanel.hide();
	return;
	
func ClientButtonClicked():
	print("client button clicked!");
	var clientInstance = ClientPrefab.instantiate();
	get_tree().root.add_child(clientInstance);
	var client = clientInstance as Client;
	var clientPanelController = ClientPanel as ClientPanelController;
	client.PanelController = clientPanelController;
	clientPanelController.ClientInstance = client;
	ClientPanel.set_process(true);
	ClientPanel.show();
	client.Start();
	
	ClientServerSelectionPanel.set_process(false);
	ClientServerSelectionPanel.hide();
	return;
