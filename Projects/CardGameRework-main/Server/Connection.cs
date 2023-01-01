using System.Collections.Generic;
using CardGame.Common.Constants;
using CardGame.Network;
using CardGame.Server.Game;
using CardGame.Server.Game.Players;

namespace CardGame.Server;

public class Connection : Node
{
	private Multiplayer Network { get; } = new();
	private Queue<Player> Players { get; } = new();
	private List<Game.Room> Rooms { get; } = new();

	public Connection()
	{
		Network.Connect(Signals.NetworkPeerConnected, this, nameof(OnNetworkPeerConnected));
		Network.Connect(Signals.NetworkPeerDisconnected, this, nameof(OnNetworkPeerDisconnected));
		Network.RootNode = this;
		CustomMultiplayer = Network;
	}
		
	public override void _Ready() { Network.Host(); }
		
	public override void _Process(float delta)
	{
		Network.Update();
		if (Players.Count > 1) { CreateRoom(); }
	}
		
	private void CreateRoom()
	{
		GD.Print("Creating Room");
		var (p1, p2) = (Players.Dequeue(), Players.Dequeue());
		(p1.Opponent, p2.Opponent) = (p2, p1);
		var room = new Game.Room(new Match { Players = new Dictionary<int, Player> { { p1.Id, p1 }, { p2.Id, p2 } }});
		room.CustomMultiplayer = CustomMultiplayer;
		room.Name = Rooms.Count.ToString();
		Rooms.Add(room);
		AddChild(room, true);
		RpcId(p1.Id, "CreateRoom", room.Name); 
		RpcId(p2.Id, "CreateRoom", room.Name);
	}

	public override void _ExitTree() { Network.Shutdown(); }

	private void OnNetworkPeerConnected(int peer)
	{
		Console.WriteLine(peer + " has connected");
	}

	private void OnNetworkPeerDisconnected(int peer)
	{
		Console.WriteLine(peer + " has disconnected");
	}
		
	[Master]
	public void RegisterPlayer(IEnumerable<string> deckList)
	{
		Console.WriteLine(Network.GetRpcSenderId() + " has registered with deck of " + deckList);
		Players.Enqueue(new Player(Network.GetRpcSenderId(), deckList));
	}
		
}
