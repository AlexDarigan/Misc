using CardGame.Common;
namespace CardGame.Client;

public class Network: Node
{
	
	[Export(PropertyHint.ResourceType)] private NetworkConfig NetworkConfig { get; set; }
	[Export(PropertyHint.ResourceType)] private Logger Logger { get; set; }
	[Export(PropertyHint.ResourceType)] private PackedScene Table { get; set; }
	
	public Network()
	{
		CustomMultiplayer = new MultiplayerAPI();
		CustomMultiplayer.RootNode = this;
		CustomMultiplayer.Connect("connected_to_server", this, nameof(OnConnectedToServer));
		CustomMultiplayer.Connect("connection_failed", this, nameof(OnConnectionFailed));
		CustomMultiplayer.Connect("server_disconnected", this, nameof(OnServerDisconnected));
	}

	public override void _Ready()
	{
		base._Ready();
		Join();
	}

	public void Join()
	{
		var peer = new NetworkedMultiplayerENet();
		var error = peer.CreateClient(NetworkConfig.IpAddress, NetworkConfig.Port);
		if (error != Error.Ok)
		{
			GD.PushError(error.ToString());
			Logger.Log(this, error.ToString());
		}
		CustomMultiplayer.NetworkPeer = peer;
		Name = CustomMultiplayer.GetNetworkUniqueId().ToString();
	}

	[Puppet]
	public void Sit(string tableNumber)
	{
		var table = Table.Instance();
		table.Name = tableNumber;
		table.CustomMultiplayer = CustomMultiplayer;
		AddChild(table);
	}

	public override void _Process(float delta)
	{
		base._Process(delta);
		if(CustomMultiplayer.HasNetworkPeer()) { CustomMultiplayer.Poll();}
	}

	public void OnConnectedToServer()
	{
		Logger.Log(this, "Connected to Server");
	}

	public void OnConnectionFailed()
	{
		Logger.Log(this, "Disconnected from Server");
	}

	public void OnServerDisconnected()
	{
		Logger.Log(this, "Server disconnected");
	}
}
