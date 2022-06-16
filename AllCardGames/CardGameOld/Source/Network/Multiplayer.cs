using CardGame.Network.Events;

namespace CardGame.Network
{
    public class Multiplayer : Godot.MultiplayerAPI
    {
        // Wrapper class around Multiplayer to change Signals to Events
        public event EventHandler<ConnectedToServer> ConnectedToServer;
        public event EventHandler<ConnectionFailed> ConnectionFailed;
        public event EventHandler<NetworkPeerConnected> NetworkPeerConnected;
        public event EventHandler<NetworkPeerDisconnected> NetworkPeerDisconnected;
        public event EventHandler<ServerConnected> ServerConnected;
        public event EventHandler<ServerDisconnected> ServerDisconnected;

        public Multiplayer()
        {
            Subscribe("connected_to_server", nameof(OnConnectedToServer));
            Subscribe("connection_failed", nameof(OnConnectionFailed));
            Subscribe("network_peer_connected", nameof(OnNetworkPeerConnected));
            Subscribe("network_peer_disconnected", nameof(OnNetworkPeerDisconnected));
            Subscribe("server_disconnected", nameof(OnServerDisconnected));

            void Subscribe(string signal, string method)
            {
                Connect(signal, this, method);
            }
        }

        public void Host(int port = 5000)
        {
            Console.WriteLine("Server Ready!");
            NetworkedMultiplayerENet peer = new();
            Error error = peer.CreateServer(port);
            if (error != Error.Ok)
            {
                GD.PushError(error.ToString());
            }

            NetworkPeer = peer;
            Console.WriteLine(NetworkPeer.GetConnectionStatus());
            if (NetworkPeer.GetConnectionStatus() == NetworkedMultiplayerPeer.ConnectionStatus.Connected)
            {
                Console.WriteLine("Server Is Live");
                ServerConnected?.Invoke(this, new ServerConnected());
            }
        }

        public void Join(string address, int port)
        {
            Console.WriteLine("Joining Server");
            NetworkedMultiplayerENet peer = new();
            Error error = peer.CreateClient(address, port);
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

        public void OnConnectedToServer()
        {
            ConnectedToServer?.Invoke(this, new ConnectedToServer());
        }

        private void OnConnectionFailed()
        {
            ConnectionFailed?.Invoke(this, new ConnectionFailed());
        }

        private void OnServerDisconnected()
        {
            ServerDisconnected?.Invoke(this, new ServerDisconnected());
        }
        
        private void OnNetworkPeerConnected(int id)
        {
            NetworkPeerConnected?.Invoke(this, new NetworkPeerConnected(id));
        }
        
        private void OnNetworkPeerDisconnected(int id)
        {
            NetworkPeerDisconnected?.Invoke(this, new NetworkPeerDisconnected(id));
        }


    }
}