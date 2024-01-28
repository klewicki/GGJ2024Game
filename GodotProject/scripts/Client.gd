class_name Client
extends Node

var PanelController : ClientPanelController;
var Peer : ENetMultiplayerPeer;
var ClientId : int;

func Start():
	print("starting up client");
	Peer = ENetMultiplayerPeer.new(); 
	multiplayer.connected_to_server.connect(ConnectedToServer);
	multiplayer.connection_failed.connect(ConnectionFailed);
	multiplayer.server_disconnected.connect(ServerDisconnected);
	
	var error = Peer.create_client("127.0.0.1", Server.PORT);
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
	if(PanelController != null):
		PanelController.DisplayDebugMessage(message);
	else:
		print("PanelController is null in Client!");
		
func UsePower(powerId : int):
	print("Power activated! Id " + str(powerId));
	#does not work because this needs non static reference
	#Server.UsePower(powerId).rpc_id(1); #the server is always id 1
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
