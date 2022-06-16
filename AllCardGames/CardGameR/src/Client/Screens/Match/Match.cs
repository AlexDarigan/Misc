namespace Client.Match
{
    public class Match : Control, IScreen
    {
        private Match() { /* Godot Engine Reflection */ }

        public void Display()
        {
            Join();
            Show();
        }

        public void StopDisplaying()
        {
            Peer?.CloseConnection();
            Hide();
        }
        
        private NetworkedMultiplayerENet Peer { get; } = new NetworkedMultiplayerENet();
        
        public override void _Ready()
        {
            CustomMultiplayer = new MultiplayerAPI() { RootNode = this };
            CustomMultiplayer.Connect("connected_to_server", this, nameof(OnConnectedToServer));
        }
        
        public override void _Process(float delta)
        { 
            if(CustomMultiplayer.HasNetworkPeer() ) { CustomMultiplayer.Poll(); }
        }

        private void Join()
        {
            // Using Local Address For Testing Purposes
            Console.WriteLine("Joining Server");
            Error error = Peer.CreateClient("127.0.0.1", 5000);
            if(error != Error.Ok) { GD.PushError(error.ToString());}
            CustomMultiplayer.NetworkPeer = Peer;
        }
        
        private void OnConnectedToServer()
        {
            Console.WriteLine("Connected To Server");
        }
    }
}