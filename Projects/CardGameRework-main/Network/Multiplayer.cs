using CardGame.Common.Constants;

namespace CardGame.Network;

public class Multiplayer : MultiplayerAPI
{
    public Multiplayer() { }

    public void Host(int port = 5000)
    {
        Console.WriteLine("Server Ready!");
        NetworkedMultiplayerENet peer = new();
        var error = peer.CreateServer(port);
        if (error != Error.Ok)
        {
            GD.PushError(error.ToString());
        }

        NetworkPeer = peer;
        Console.WriteLine(NetworkPeer.GetConnectionStatus());
        if (NetworkPeer.GetConnectionStatus() == NetworkedMultiplayerPeer.ConnectionStatus.Connected)
        {
            Console.WriteLine("Server Is Live");
        }
    }

    public void Join(string address, int port)
    {
        Console.WriteLine("Joining Server");
        NetworkedMultiplayerENet peer = new();
        var error = peer.CreateClient(address, port);
        if (error != Error.Ok)
        {
            GD.PushError(error.ToString());
        }

        NetworkPeer = peer;
    }

    public void Update() { if (HasNetworkPeer()) { Poll(); } }
    public void Shutdown(uint uSecWait = 100)
    {
        // TODO: Test This
        if (NetworkPeer?.GetConnectionStatus() == NetworkedMultiplayerPeer.ConnectionStatus.Connected
            && NetworkPeer is NetworkedMultiplayerENet eNet)
        {
            eNet.CloseConnection(uSecWait);
        }
    }
}