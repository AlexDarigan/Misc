namespace Server
{
    public class Network : Node
    {
        private Network () {/* Godot Reflection */}
        private NetworkedMultiplayerENet Peer { get; } = new NetworkedMultiplayerENet();

        public override void _Ready()
        {
            Console.WriteLine("Server Ready!");
            Error error = Peer.CreateServer(5000);
            if(error != Error.Ok) { GD.PushError(error.ToString());}
            
            CustomMultiplayer = new MultiplayerAPI()
            {
                RootNode = this, NetworkPeer = Peer
            };
            
            CustomMultiplayer.Connect("network_peer_connected",
                this, nameof(OnNetworkPeerConnected));
            CustomMultiplayer.Connect("network_peer_disconnected",
                this, nameof(OnNetworkPeerDisconnected));
        }

        public override void _Process(float delta)
        {
            if(CustomMultiplayer.HasNetworkPeer() ) { CustomMultiplayer.Poll(); }
        }

        public void OnNetworkPeerConnected(int id)
        {
            Console.Write($"\n{id} has connected", id);
        }

        public void OnNetworkPeerDisconnected(int id)
        {
            Console.WriteLine($"\n{id} has disconnected");
        }

    }
}