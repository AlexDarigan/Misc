using Godot;
using System;

public class Server : Node
{

    public override void _Ready()
    {
        Console.WriteLine("Hello World (Server)");
        Host();
    }

    public void Host()
    {
        
        this.CustomMultiplayer = new MultiplayerAPI();
        this.CustomMultiplayer.RootNode = this;
        NetworkedMultiplayerENet peer = new NetworkedMultiplayerENet();
        peer.Connect("peer_connected", this, nameof(OnNetworkPeerConnected));
        peer.Connect("peer_disconnected", this, nameof(OnNetworkPeerDisconnected));
        var err = peer.CreateServer(5555);
        if(err != Error.Ok) {
            GD.PushError(err.ToString());
        }
        Console.WriteLine(peer.GetConnectionStatus());
        this.CustomMultiplayer.NetworkPeer = peer;

    }

    public override void _Process(float delta)
    {
        base._Process(delta);
        if(CustomMultiplayer.HasNetworkPeer()) {
            CustomMultiplayer.Poll();
        }
    }
   
    public void OnNetworkPeerConnected(int id)
    {
        Console.WriteLine("Hello from network peer", id);
    }

    public void OnNetworkPeerDisconnected(int id)
    {
        Console.WriteLine("Goodbye from Network peer", id);
    }

}
