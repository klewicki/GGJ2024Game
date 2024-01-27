class_name Server
extends Node

var PanelController : ServerPanelController;

const PORT : int =  50000;
const MAX_CLIENTS : int = 5;
var Peer : ENetMultiplayerPeer;
var PlayerCount : int = 0;

func _ready():
	print("starting up server on port " + str(PORT));
	Peer = ENetMultiplayerPeer.new(); 
	var error = Peer.create_server(PORT, MAX_CLIENTS)
	if(error):
		print("Error creating server");
	multiplayer.multiplayer_peer = Peer;
	multiplayer.peer_connected.connect(OnPlayerConnected)
	
func OnPlayerConnected(playerId : int):
		print("player with id " + str(playerId) + " connected!");
		PlayerCount += 1;
		if(PanelController != null):
			PanelController.UpdatePlayerCount(PlayerCount);
		else:
			print("Panel controller is null in Server!");
		#TODO: implement logic
