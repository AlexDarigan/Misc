using System.Collections.Generic;
using System.Linq;
using CardGame.Network;
using CardGame.Network.Events;
using CardGame.Server.MatchMaking;
using CardGame.Server.MatchMaking.Events;

namespace CardGame.Server
{
	public class Connection : Node
	{
		private Multiplayer Network { get; } = new();
		private Matchmaker Matchmaker { get; } = new();

		public Connection()
		{
			Matchmaker.MatchMade += OnMatchMade;
			Network.NetworkPeerConnected += OnNetworkPeerConnected;
			Network.NetworkPeerDisconnected += OnNetworkPeerDisconnected;
			Network.RootNode = this;
			CustomMultiplayer = Network;
		}
		
		public override void _Ready() { Network.Host(); }
		
		public override void _Process(float delta)
		{
			Network.Update();
			Matchmaker.Update();
		}

		public override void _ExitTree() { Network.Shutdown(); }

		private void OnNetworkPeerConnected(object sender, NetworkPeerConnected peerConnected)
		{
			Console.WriteLine(peerConnected.PeerId + " has connected");
		}

		private void OnNetworkPeerDisconnected(object sender, NetworkPeerDisconnected peerDisconnected)
		{
			Console.WriteLine(peerDisconnected.PeerId + " has disconnected");
		}

		private void OnMatchMade(object sender, MatchMade matchMade)
		{
			matchMade.Room.CustomMultiplayer = Network;
			AddChild(matchMade.Room);
			foreach (Player player in matchMade.Players) { RpcId(player.Id, "CreateRoom", matchMade.Room.Name); }
		}
		

		[Master]
		public void RegisterPlayer(IEnumerable<string> deckList)
		{
			Console.WriteLine(Network.GetRpcSenderId() + " has registered with deck of " + deckList);
			Matchmaker.AddPlayerToQueue(new Player(Network.GetRpcSenderId(), deckList));
		}
		
	}
}
