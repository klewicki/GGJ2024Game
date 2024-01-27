class_name Client
extends Node

var Peer : ENetMultiplayerPeer;
var ClientId : int;

func _ready():
	print("starting up client");
	Peer = ENetMultiplayerPeer.new(); 
	multiplayer.connected_to_server.connect(ConnectedToServer);
	
	var error = Peer.create_client("192.168.0.1", Server.PORT);
	if(error):
		print("Error creating client");
	multiplayer.multiplayer_peer = Peer;

func ConnectedToServer():
	print("Connected to server!");
	
func ConnectionFailed():
	print("Connection failed!");
	
func ServerDisconnected():
	print("Server disconnected!");
