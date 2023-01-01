using System.Collections.Generic;
using CardGame.Client.Game.Cards;
using CardGame.Client.Game.CommandQueue.Commands;
using CardGame.Client.Resources;
using CardGame.Common.Constants;
using Godot.Collections;

namespace CardGame.Client.Game.CommandQueue;

[GodotScene]
public class Queue : Node
{
	private Queue() { /* Godot Engine Callback */}
	private Queue<Command> Q { get; } = new();
	private Node Queued { get; set; }

	public override void _Ready()
	{
		base._Ready();
		Queued = GetNode<Node>("Queued");
	}

	public void TryEnqueue(CommandId command, object[] args)
	{
		try
		{
			Enqueue(command, args);
		}
		catch (Exception exception)
		{
			Console.WriteLine($"{command.ToString()} Prototype Node Not Found\n{exception.Message}");
		}
	}

	private void Enqueue(CommandId command, object[] args) 
	{
		var c = GetNode<Command>($"Commands/{command.ToString()}").GetInstance(args);
		if (c is null) { return; }
		Q.Enqueue(c);
		Queued.AddChild(c);
	}

	public void OnGameUpdated(Match match)
	{
		if (Q.Count <= 0) { return;}
		var command = Q.Dequeue();
		command.Connect(nameof(Command.Executed), this, nameof(OnCommandExecuted), new Godot.Collections.Array(match, command));
		command.Execute(match);
	}

	public void OnCommandExecuted(Match match, Command command)
	{ 
		command.Disconnect(nameof(Command.Executed), this, nameof(OnCommandExecuted));
		CallDeferred(nameof(OnGameUpdated), match);
	}
}
