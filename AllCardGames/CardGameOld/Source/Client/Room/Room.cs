using CardGame.Client.Match.Input.Events;
using CardGame.Client.Match.Events;
using CardGame.Client.Match.InputControllers;
using CardGame.Client.Resources;
using CardGame.Client.Screens;
using CardGame.Network;
using CardGame.Network.Events;

namespace CardGame.Client.Match
{
	[GodotScene]
	public class Room : Spatial, IScreen, IGameBoard
	{
		private event EventHandler<EventArgs> GameEvent;
		private NetworkMessenger NetworkMessenger { get; } = new();
		private PlayerController Input { get; } = new();
		private CommandQueue CommandQueue { get; } = new();
		private Multiplayer Network { get; } = new();
		public Participant Player { get; private set; }
		public Participant Rival { get; private set; }
		public Table Table { get; private set; }
		public Effects Effects { get; } = new();
		public Cards Cards { get; } = new();
		public User User { get; set; }

		protected Room()
		{
			Network.RootNode = this;
			CustomMultiplayer = Network;
			NetworkMessenger.CustomMultiplayer = Network;
			
			Network.ConnectedToServer += OnConnectedToServer;
			Network.ConnectionFailed += OnConnectionFailed;
			Network.ServerDisconnected += OnServerDisconnected;
			NetworkMessenger.EventQueued += OnCommandQueued;
			NetworkMessenger.Updated += OnGameUpdated;
			Cards.CardCreated += OnCardCreated;
			Input.UnitDeployed += OnUnitDeployed;
			Input.CardSetFaceDown += OnCardSetFaceDown;
			Input.AttackedUnit += OnUnitAttacked;
			
			AddChild(NetworkMessenger);
			AddChild(Effects);
			AddChild(Cards);
		}
		
		public override void _Ready()
		{
			Player = GetNode<Participant>("Player");
			Rival = GetNode<Participant>("Rival");
			Table = GetNode<Table>("Table");
			Table.PassPlayPressed += OnPassPlayPressed;
		}

		private void OnPassPlayPressed(object sender, EventArgs e = null)
		{
			if (Player.State == States.IdleTurnPlayer) { NetworkMessenger.RpcId(1, "EndTurn"); }
			else if (Player.State == States.Active) { NetworkMessenger.RpcId(1, "PassPlay"); }
			else { return; }
			Table.SetAsInActive();
		}

		public override void _Process(float delta)
		{
			Network.Update();
		}

		public override void _ExitTree()
		{
			Network.Shutdown();
		}
		
		[Puppet]
		public void CreateRoom(string number)
		{
			// TODO: Initialize / Clean Room
			Console.WriteLine($"Creating Room {number}");
			NetworkMessenger.Name = number;
			NetworkMessenger.RpcId(1, "OnClientReady");
		}

		private void Join()
		{
			Network.Join("127.0.0.1", 5000);
		}

		private void Leave()
		{
			Network.Shutdown();
		}
		
		private void OnConnectedToServer(object sender, ConnectedToServer e)
		{
			Console.WriteLine("Connected To Server");
			RpcId(1, "RegisterPlayer", User.CurrentDeck.Contents);
		}

		private void OnConnectionFailed(object sender, ConnectionFailed e)
		{
			Console.WriteLine("Connection Failed");
		}

		private void OnServerDisconnected(object sender, ServerDisconnected e)
		{
			Console.WriteLine("Disconnected from Server");
		}
		
		private void OnCardCreated(object sender, CreatedCard e)
		{
			e.Card.CardPressed += Input.OnCardPressed;
			GameEvent?.Invoke(sender, e);
		}

		private void OnUnitDeployed(object sender, DeployedUnit e)
		{
			NetworkMessenger.RpcId(1, "Deploy", e.Card.Id);
			GameEvent?.Invoke(sender, e);
		}

		private void OnCardSetFaceDown(object sender, SetFaceDown e)
		{
			NetworkMessenger.RpcId(1, "SetFaceDown", e.Card.Id);
			GameEvent?.Invoke(sender, e);
		}

		private void OnUnitAttacked(object sender, UnitAttacked e)
		{
			NetworkMessenger.RpcId(1, "AttackUnit", e.Attacker.Id, e.Defender.Id);
			GameEvent?.Invoke(sender, e);
		}
		
		public void Display()
		{
			Join();
			Show();
		}

		public void StopDisplaying()
		{
			Leave();
			Hide();
		}

		private void OnGameUpdated(object sender, EventArgs e = null)
		{
		   CommandQueue.Update(this);
		   GameEvent?.Invoke(sender, e);
		}

		private void OnCommandQueued(object sender, QueuedEvent e)
		{
			CommandQueue.Enqueue(e.CommandId, e.Args);
			GameEvent?.Invoke(sender, e);
		}
	}
}
