using CardGame.Common.Constants;
using CardGame.Server.Events;
namespace CardGame.Server.Game;

public delegate void Enqueue(int id, CommandId command, params object[] args);

public class Room: Node 
{
	private Match Match { get; }
	private Room() { /* Required By Godot Engine Callbacks */  }
	
	public Room(Match match)
	{
		Match = match;
		Match.PublishEvent += OnGameEvent;
		AddChild(Match);
	}

	[Master]
	public void OnClientReady()
	{
		Match.Players[Multiplayer.GetRpcSenderId()].IsReady = true;
		if (!Match.Players[Multiplayer.GetRpcSenderId()].IsReady) { return; }
		Match.StartGame();
		Update();
	}

	[Master]
	public void Deploy(int id)
	{
		Match.Deploy(CustomMultiplayer.GetRpcSenderId(), id);
		Update();
	}

	[Master]
	public void SetFaceDown(int id)
	{
		Match.SetFaceDown(CustomMultiplayer.GetRpcSenderId(), id);
		Update();
	}

	[Master]
	public void AttackUnit(int attackerId, int defenderId)
	{
		Match.AttackUnit(CustomMultiplayer.GetRpcSenderId(), attackerId, defenderId);
		Update();
	}

	[Master]
	public void AttackPlayer(int id)
	{
		Match.AttackPlayer(CustomMultiplayer.GetRpcSenderId(), id);
		Update();
	}

	[Master]
	public void Activate(int id)
	{
		Match.Activate(CustomMultiplayer.GetRpcSenderId(), id);
		Update();
	}

	[Master]
	public void PassPlay()
	{
		Match.PassPlay(CustomMultiplayer.GetRpcSenderId());
		Update();
	}
	
	private void OnGameEvent(GameEventArgs args)
	{
		GD.Print(args);
		args.QueueOnClients(Queue);
	}

	private void Update()
	{
		Match.Update(Queue);
		foreach (var (id, player) in Match.Players)
		{
			Update(id);
		}
	}

	private void Queue(int id, CommandId commandId, params object[] args)
	{
		RpcId(id, "Queue", commandId, args);
	}

	private void Update(int id)
	{
		RpcId(id, "Update");
	}
}
