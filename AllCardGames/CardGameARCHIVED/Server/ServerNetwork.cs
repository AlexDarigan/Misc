using Godot;
using System;
using System.Collections.Generic;
using Configuration;
using Debug;

namespace CardGame.Server
{
    public class ServerNetwork : Node
    {
        [Export(PropertyHint.ResourceType)] private NetworkConfiguration NetworkConfig { get; set; }
        [Export(PropertyHint.ResourceType)] private Logger Logger { get; set; }
        
        // TODO: Create Lobby System And Events
        // TODO: Create Multiplayer?
        private List<ServerRoom> Rooms { get; set; }= new();
        private List<Player> Players { get; set; } = new();
        private int RoomCount { get; set; }= 0;
        
        public ServerNetwork()
        {
            CustomMultiplayer = new MultiplayerAPI();
            CustomMultiplayer.RootNode = this;
        }

        public override void _Ready()
        {
            base._Ready();
            Host();
        }

        public void Host()
        {
            Logger.Log("Hosting");
            var peer = new NetworkedMultiplayerENet();
            peer.Connect("peer_connected", this, nameof(OnNetworkPeerConnected));
            peer.Connect("peer_disconnected", this, nameof(OnNetworkPeerDisconnected));
            var err = peer.CreateServer(NetworkConfig.Port);
            if (err != Error.Ok)
            {
                Logger.Log(err.ToString());
                GD.PushError(err.ToString());
            }

            CustomMultiplayer.NetworkPeer = peer;
        }

        public void OnNetworkPeerConnected(int peerId)
        {
            Logger.Log($"{peerId} connected");
            Players.Add(new Player(peerId));
        }

        public void OnNetworkPeerDisconnected(int peerId)
        {
            Logger.Log($"{peerId} disconnected");
        }

        public override void _Process(float delta)
        {
            base._Process(delta);
            if (CustomMultiplayer.HasNetworkPeer()) { CustomMultiplayer.Poll(); }
            if (Players.Count >= 2) { CreateRoom(); }
        }

        public void CreateRoom()
        {
            var p1 = Players[^1];
            Players.Remove(p1);
            var p2 = Players[^1];
            Players.Remove(p2);
            var room = ServerRoom.CreateInstance(p1, p2);
            room.CustomMultiplayer = CustomMultiplayer;
            AddChild(room);
            room.Name = RoomCount.ToString();
            RpcId(p1.Id, "CreateRoom", room.Name);
            RpcId(p2.Id, "CreateRoom", room.Name);
            RoomCount++;
        }
    }
}