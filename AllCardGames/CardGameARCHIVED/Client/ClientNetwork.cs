using Godot;
using System;
using Configuration;
using Debug;

namespace CardGame.Client
{

    public class ClientNetwork : Node
    {
        [Export(PropertyHint.ResourceType)] private NetworkConfiguration NetworkConfig { get; set; }
        [Export(PropertyHint.ResourceType)] private Logger Logger { get; set; }

        public ClientNetwork()
        {
            CustomMultiplayer = new MultiplayerAPI();
            CustomMultiplayer.RootNode = this;
        }

        public override void _Ready()
        {
            base._Ready();
            Join();
        }

        public override void _Process(float delta)
        {
            base._Process(delta);
            if(CustomMultiplayer.HasNetworkPeer()) {CustomMultiplayer.Poll();}
        }

        public void Join()
        {
            Logger.Log("Joining");
            var peer = new NetworkedMultiplayerENet();
            CustomMultiplayer.Connect("connected_to_server", this, nameof(OnConnectedToServer));
            peer.Connect("connection_failed", this, nameof(OnConnectionFailed));
            peer.Connect("server_disconnected", this, nameof(OnServerDisconnected));
            var err = peer.CreateClient(NetworkConfig.IpAddress, NetworkConfig.Port);
            if (err != Error.Ok)
            {
                Logger.Log(err.ToString());
                GD.PushError(err.ToString());
            }
            CustomMultiplayer.NetworkPeer = peer;
        }

        public void OnConnectedToServer()
        {
            Logger.Log($"{CustomMultiplayer.GetNetworkUniqueId().ToString()} : Connected to the Server");
        }

        public void OnConnectionFailed()
        {
            Logger.Log($"{CustomMultiplayer.GetNetworkUniqueId().ToString()} : Failed to connection to the Server");
        }

        public void OnServerDisconnected()
        {
            Logger.Log($"{CustomMultiplayer.GetNetworkUniqueId().ToString()} : The Server has disconnected");
        }

        [Puppet]
        public void CreateRoom(string name)
        {
            Logger.Log($"{CustomMultiplayer.GetNetworkUniqueId()} : Created Room {name}");
            var room = ClientRoom.CreateInstance();
            room.Name = name;
            room.CustomMultiplayer = CustomMultiplayer;
            AddChild(room);
        }
    }
}