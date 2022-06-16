using System.Collections.Generic;
using CardGame.Common;
namespace CardGame.Server;

public class Network: Node
{

    [Export(PropertyHint.ResourceType)] private NetworkConfig NetworkConfig { get; set; }
    [Export(PropertyHint.ResourceType)] private Logger Logger { get; set; }
    [Export(PropertyHint.ResourceType)] private TableFactory TableFactory { get; set; }
    private const int MinimumPlayers = 2;
    private IList<int> Players { get; } = new List<int>();
    private int RoomCount { get; set; }= 0;

    public Network()
    {
        CustomMultiplayer = new MultiplayerAPI();
        CustomMultiplayer.RootNode = this;
        CustomMultiplayer.Connect("network_peer_connected", this, nameof(OnNetworkPeerConnected));
        CustomMultiplayer.Connect("network_peer_disconnected", this, nameof(OnNetworkPeerDisconnected));
    }
    
    public override void _Ready()
    {
        base._Ready();
        Host();
    }

    public void Host()
    {
        var peer = new NetworkedMultiplayerENet();
        var error = peer.CreateServer(NetworkConfig.Port);
        if (error != Error.Ok)
        {
            GD.PushError(error.ToString());
            Logger.Log(this, error.ToString());
        }
        CustomMultiplayer.NetworkPeer = peer;
    }
    
    private void PairPlayers()
    {
        var p1 = Players[^1];
        var p2 = Players[^2];
        Players.Remove(p1);
        Players.Remove(p2);
        var table = TableFactory.CreateInstance(p1, p2);
        table.Name = RoomCount.ToString();
        table.CustomMultiplayer = CustomMultiplayer;
        AddChild(table);
        RoomCount++;
        RpcId(p1, "Sit", table.Name);
        RpcId(p2, "Sit", table.Name);
    }
    
    public override void _Process(float delta)
    {
        base._Process(delta);
        if (CustomMultiplayer.HasNetworkPeer())
        {
            CustomMultiplayer.Poll();
        }
        if (Players.Count >= MinimumPlayers)
        {
            PairPlayers();
        }
    }

    public void OnNetworkPeerConnected(int peerId)
    {
        Logger.Log(this, $"{peerId} has connected");
        Players.Add(peerId);
    }

    public void OnNetworkPeerDisconnected(int peerId)
    {
        Logger.Log(this, $"{peerId} has disconnected");
        Players.Remove(peerId);
    }
}