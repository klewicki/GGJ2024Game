extends Node

const PORT : int =  50000;
const MAX_CLIENTS : int = 5;
var Peer : ENetMultiplayerPeer

func _ready():
	print("starting up server on port " + str(PORT));
	Peer = ENetMultiplayerPeer.new(); 
	var error = Peer.create_server(PORT, MAX_CLIENTS)
	multiplayer.multiplayer_peer = Peer;
	multiplayer.peer_connected.connect(OnPlayerConnected)
	
func OnPlayerConnected(playerId : int):
		print("player with id " + str(playerId) + " connected!");
		#TODO: implement logic
