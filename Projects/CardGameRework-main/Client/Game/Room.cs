using CardGame.Client.Game;
using CardGame.Client.Screens;
using CardGame.Common.Constants;
using CardGame.Network;

namespace CardGame.Client.Network;

public delegate void Declaration(string play, params object[] args);
	
[GodotScene]
public class Room: Node, IScreen
{
	[Export] private string Address { get; set; } = "localhost";
	[Export] private int Port { get; set; } = 5000;
	private Match Match { get; set; }
	private Multiplayer Network
	{
		get { return CustomMultiplayer as Multiplayer; }
		set { CustomMultiplayer = value; }
	}

	public void ReadyRoom(string name)
	{ 
		Name = name;
		RpcId(1, "OnClientReady");
	}
	
	public override void _Ready()
	{
		Match = GetNode<Match>("Match");
		Match.Declare += PlayCard;
	}

	[Puppet]
	public void Queue(CommandId commandId, object[] args)
	{
		// EventQueued?.Invoke(commandId, args);
		GD.Print("Queing ", commandId.ToString());
		Match.OnCommandQueued(commandId, args);
	}

	[Puppet]
	public void Update()
	{
		GD.Print("Updating game");
		Match.OnGameUpdated();
	}

	private void PlayCard(string play, params object[] args)
	{
		GD.Print($"Room.Play: {play} {args}");
		RpcId(1, play, args);
	}

	public void Display()
	{
		((Multiplayer) CustomMultiplayer).Join(Address, Port);
		Match.Visible = true;
	}

	public void StopDisplaying()
	{
		GetChild<Spatial>(0).Visible = false;
		((Multiplayer) CustomMultiplayer).Shutdown();
	}
}