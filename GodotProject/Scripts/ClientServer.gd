class_name ClientServer
extends Node

const PORT : int =  5555;
const MAX_CLIENTS : int = 5;

#common stuff
var Peer : ENetMultiplayerPeer;

#client side stuff
var ClientPanel : ClientPanelController;
var ClientId : int;
var ServerIPAddress: String;

#server side stuff
var ServerPanel : ServerPanelController;
var PlayerCount : int = 0;
var PlayerIds : Array;

signal PowerUsed(playerIndex : int, powerId : int);

#client code
func StartClient():
	print("starting up client");
	Peer = ENetMultiplayerPeer.new(); 
	multiplayer.connected_to_server.connect(ConnectedToServer);
	multiplayer.connection_failed.connect(ConnectionFailed);
	multiplayer.server_disconnected.connect(ServerDisconnected);
	
	var error = Peer.create_client(ServerIPAddress, PORT);
	if(error):
		print("Error creating client");
		DisplayDebugMessage("Error creating client");
	else:
		print("Client created successfully");
		DisplayDebugMessage("Client created successfully");
	multiplayer.multiplayer_peer = Peer;
	
func ConnectedToServer():
	print("Connected to server!");
	DisplayDebugMessage("Connected to server!");
	
func ConnectionFailed():
	print("Connection failed!");
	DisplayDebugMessage("Connection failed!");
	
func ServerDisconnected():
	print("Server disconnected!");
	DisplayDebugMessage("Server disconnected!");
	
func DisplayDebugMessage(message : String):
	if(ClientPanel != null):
		ClientPanel.DisplayDebugMessage(message);
	else:
		print("PanelController is null in Client!");
		
func UsePower(powerId : int):
	print("Power activated! Id " + str(powerId));
	UsePowerRPC.rpc_id(1, powerId); #the server is always id 1
	print("RPC sent for power use!");
	return;
		
@rpc()
func EnablePower(powerId : int):
	#TODO: logic
	print("Power enabled! Id " + str(powerId));
	return;
	
@rpc()
func DiablePower(powerId : int):
	print("Power disabled! Id " + str(powerId));
	return;
	
#server code
func StartServer():
	print("starting up server on port " + str(PORT));
	Peer = ENetMultiplayerPeer.new(); 
	var error = Peer.create_server(PORT, MAX_CLIENTS)
	if(error):
		print("Error creating server");
	multiplayer.multiplayer_peer = Peer;
	multiplayer.peer_connected.connect(OnPlayerConnected);
	
func OnPlayerConnected(playerId : int):
		print("player with id " + str(playerId) + " connected!");
		PlayerCount += 1;
		PlayerIds.append(playerId);
		if(ServerPanel != null):
			ServerPanel.UpdatePlayerCount(PlayerCount);
		else:
			print("Panel controller is null in Server!");

		
func GetPlayerIndex(playerId : int) -> int :
	for i in PlayerIds.size():
		if(PlayerIds[i] == playerId):
			return i;
	print("No player with Id " + str(playerId) + " found!");
	return -1;
		
@rpc("any_peer")
func UsePowerRPC(powerId : int):
	var playerId = multiplayer.get_remote_sender_id();
	print("Power " + str(powerId) + " used by player " + str(playerId));
	var playerIndex = GetPlayerIndex(playerId);
	PowerUsed.emit(playerIndex, powerId);


