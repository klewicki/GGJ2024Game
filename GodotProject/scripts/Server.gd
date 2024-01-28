class_name Server
extends Node

var PanelController : ServerPanelController;

const PORT : int =  50000;
const MAX_CLIENTS : int = 5;
var Peer : ENetMultiplayerPeer;
var PlayerCount : int = 0;
var PlayerIds : Array;

signal PowerUsed(playerIndex : int, powerId : int);

func Start():
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
		PlayerIds.append(playerId);
		if(PanelController != null):
			PanelController.UpdatePlayerCount(PlayerCount);
		else:
			print("Panel controller is null in Server!");
		#TODO: implement logic
		
func GetPlayerIndex(playerId : int) -> int :
	for i in PlayerIds.size():
		if(PlayerIds[i] == playerId):
			return i;
	print("No player with Id " + str(playerId) + " found!");
	return -1;
		
@rpc("any_peer")
func UsePower(powerId : int):
	var playerId = multiplayer.get_remote_sender_id();
	print("Power " + str(powerId) + " used by player " + playerId);
	var playerIndex = GetPlayerIndex(playerId);
	PowerUsed.emit(playerIndex, powerId);
