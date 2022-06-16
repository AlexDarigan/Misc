using System.Threading.Tasks;

namespace CardGame.Tests;

public class Connection: WAT.Test
{
    [Test()]
    public void ServerIsLive()
    {
        var server = GD.Load<PackedScene>("res://Server/Network.tscn").Instance();
        AddChild(server);
        Assert.IsTrue(server.CustomMultiplayer.NetworkPeer.GetConnectionStatus() == 
                      NetworkedMultiplayerPeer.ConnectionStatus.Connected, "Server is live");
        RemoveChild(server);
        ((NetworkedMultiplayerENet) server.CustomMultiplayer.NetworkPeer).CloseConnection();
    }

    [Test()]
    public async Task ClientIsConnected()
    {
        var server = GD.Load<PackedScene>("res://Server/Network.tscn").Instance();
        var client = GD.Load<PackedScene>("res://Client/Network.tscn").Instance();
        AddChild(server);
        AddChild(client);
        await UntilSignal(client.CustomMultiplayer, "connected_to_server", 0.5f);
        Assert.IsTrue(client.CustomMultiplayer.NetworkPeer.GetConnectionStatus() == 
                      NetworkedMultiplayerPeer.ConnectionStatus.Connected, "Client is connected");
        ((NetworkedMultiplayerENet) server.CustomMultiplayer.NetworkPeer).CloseConnection();
    }

    [Test()]
    public async Task TableIsCreatedWhenTwoClientsConnect()
    {
        var server = GD.Load<PackedScene>("res://Server/Network.tscn").Instance();
        var client = GD.Load<PackedScene>("res://Client/Network.tscn").Instance();
        var client2 = GD.Load<PackedScene>("res://Client/Network.tscn").Instance();
        AddChild(server);
        AddChild(client);
        AddChild(client2);
        await UntilSignal(server, "child_entered_tree", 0.5f);
        Assert.IsType<Server.Room.Table>(server.GetNode("0"), "Table created on Server");
        Assert.IsTrue(true, "t");
        ((NetworkedMultiplayerENet) server.CustomMultiplayer.NetworkPeer).CloseConnection();
    }
    
}