class_name ServerClientSelector
extends Node

@export
var ClientServerPrefab : PackedScene;

@export
var ClientServerSelectionPanel : Panel;
@export
var ClientPanel : Panel;
@export
var ServerPanel : Panel;

func ServerButtonClicked():
	print("server button clicked!");
	var clientServerInstance = ClientServerPrefab.instantiate();
	get_tree().root.add_child(clientServerInstance);
	var clientServer = clientServerInstance as ClientServer;
	var serverPanelController = ServerPanel as ServerPanelController;
	clientServer.ServerPanel = serverPanelController;
	ServerPanel.set_process(true);
	ServerPanel.show();
	clientServer.StartServer();
	
	ClientServerSelectionPanel.set_process(false);
	ClientServerSelectionPanel.hide();
	return;
	
func ClientButtonClicked():
	print("client button clicked!");
	var clientServerInstance = ClientServerPrefab.instantiate();
	get_tree().root.add_child(clientServerInstance);
	var clientServer = clientServerInstance as ClientServer;
	var clientPanelController = ClientPanel as ClientPanelController;
	clientServer.ClientPanel = clientPanelController;
	clientPanelController.ClientServerInstance = clientServerInstance;
	ClientPanel.set_process(true);
	ClientPanel.show();
	clientServer.StartClient();
	
	ClientServerSelectionPanel.set_process(false);
	ClientServerSelectionPanel.hide();
	return;
