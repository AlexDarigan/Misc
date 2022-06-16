using Godot;
using System;

public class Client : Node
{
    
    public override void _Ready()
    {
        Console.WriteLine("Hello World (Client)");
        Join();
    }

    public void Join()
    {
        
        Console.WriteLine("Joining");
        this.CustomMultiplayer = new MultiplayerAPI();
        this.CustomMultiplayer.RootNode = this;
        NetworkedMultiplayerENet peer = new NetworkedMultiplayerENet();
        peer.Connect("connection_succeeded", this, nameof(OnConnectionSucceeded)); 
        peer.Connect("connection_failed", this, nameof(OnConnectionFailed));
        peer.Connect("server_disconnected", this, nameof(OnServerDisconnected));
        var err = peer.CreateClient("127.0.0.1", 5555);
        if(err != Error.Ok) {
            GD.PushError(err.ToString());
        }
        this.CustomMultiplayer.NetworkPeer = peer;
        Console.WriteLine("Join Func Done");

    }

    public override void _Process(float delta)
    {
        base._Process(delta);
        if(CustomMultiplayer.HasNetworkPeer()) {
            CustomMultiplayer.Poll();
        }
    }
  
    public void OnConnectionSucceeded()
    {
        Console.WriteLine("Conn succeeded");
    }

    public void OnConnectionFailed()
    {
        Console.WriteLine("Conn failed");
    }

   public void OnServerDisconnected()
   {
       Console.WriteLine("Server disconnected");
   }

}
