class_name Client
extends Node

var PanelController : ClientPanelController;
var Peer : ENetMultiplayerPeer;
var ClientId : int;

func _ready():
	print("starting up client");
	Peer = ENetMultiplayerPeer.new(); 
	multiplayer.connected_to_server.connect(ConnectedToServer);
	
	var error = Peer.create_client("192.168.0.1", Server.PORT);
	if(error):
		print("Error creating client");
		PanelController.DisplayDebugMessage("Error creating client");
	else:
		print("Client created successfully");
		PanelController.DisplayDebugMessage("Client created successfully");
	multiplayer.multiplayer_peer = Peer;

func ConnectedToServer():
	print("Connected to server!");
	PanelController.DisplayDebugMessage("Connected to server!");
	
func ConnectionFailed():
	print("Connection failed!");
	PanelController.DisplayDebugMessage("Connection failed!");
	
func ServerDisconnected():
	print("Server disconnected!");
	PanelController.DisplayDebugMessage("Server disconnected!");
