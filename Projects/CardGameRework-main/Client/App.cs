using System.Collections.Generic;
using CardGame.Client.Screens;
using CardGame.Client.Screens.Title;
using CardGame.Common.Constants;
using CardGame.Network;

namespace CardGame.Client;

public class App : Control
{
	private readonly string _displayName;
	[Export] public List<string> Deck { get; set; }
	private TitleScreen TitleScreen { get; set; }
	private IScreen DeckEditor { get; set; }
	private IScreen UserProfile { get; set; }
	private IScreen Settings { get; set; }
	private IScreen CurrentScreen { get; set; }
	private Room Room { get; set; }
	private Multiplayer Network { get; } = new Multiplayer();
	
	private App()
	{
		GD.Print("Begin");
		var args = OS.GetCmdlineArgs();
		if (args.Length <= 1 || Engine.EditorHint) { return;}
		
		_displayName = args[0];
		OS.SetWindowTitle(args[0]);
		OS.CurrentScreen = Convert.ToInt32(args[1]);
		OS.WindowFullscreen = true;
	}


	public override async void _Ready()
	{
		GetNode<Label>("DisplayName").Text = _displayName;

		// Get Nodes
		Room = GetNode<Room>("Room");
		TitleScreen = GetNode<TitleScreen>("TitleScreen");
		
		// Set Up Network
		Network.RootNode = this;
		CustomMultiplayer = Network;
		Room.CustomMultiplayer = Network;
		Network.Connect(Signals.ConnectedToServer, this, nameof(OnConnectedToServer));
		Network.Connect(Signals.ConnectionFailed, this, nameof(OnConnectionFailed));
		Network.Connect(Signals.ServerDisconnected, this, nameof(OnServerDisconnected));
		
		// Set up Events
		TitleScreen.PlayPressed += OnPlayPressed;
		TitleScreen.ExitPressed += OnQuitPressed;
		
		DisplayScreen(TitleScreen);
	}

	public void OnConnectedToServer()
	{
		GD.Print("Connected");
		RpcId(1, "RegisterPlayer", Deck);
	}

	public void OnConnectionFailed()
	{
		GD.Print("OnConnectionFailed");
	}

	public void OnServerDisconnected()
	{
		GD.Print("Server Disconnected");
	}

	[Puppet]
	public void CreateRoom(string name)
	{
		Room.ReadyRoom(name);
		GD.Print("Created Room");
	}

	public override void _Process(float delta)
	{
		Network.Update();
	}

	public override void _ExitTree()
	{
		Network.Shutdown();
	}

	public void Display() { Show(); }
	public void StopDisplaying() { Hide(); }
	
	private void DisplayScreen(IScreen newScreen)
	{
		CurrentScreen?.StopDisplaying();
		CurrentScreen = newScreen;
		CurrentScreen.Display();
	}

	private void OnPlayPressed()
	{
		DisplayScreen(Room);
	}
	
	private void OnQuitPressed() { GetTree().Quit(); }
}
