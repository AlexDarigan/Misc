namespace CardGame.Network.Events
{
    public class ConnectedToServer : EventArgs { };
    public class ConnectionFailed : EventArgs { };
    public class ServerConnected : EventArgs { };
    public class ServerDisconnected : EventArgs { };

    public class NetworkPeerConnected : EventArgs
    {
        public int PeerId { get; }

        public NetworkPeerConnected(int id) { PeerId = id; }
    }

    public class NetworkPeerDisconnected : EventArgs
    {
        public int PeerId { get; }

        public NetworkPeerDisconnected(int id) { PeerId = id; }
    }
}