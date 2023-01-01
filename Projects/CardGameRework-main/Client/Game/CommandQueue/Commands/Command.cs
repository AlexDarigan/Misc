using Godot.Collections;

namespace CardGame.Client.Game.CommandQueue.Commands;

public abstract class Command: Node
{
	[Signal]
	public delegate void Executed();
	protected SceneTreeTween SceneTreeTween { get; set; }
	
	public virtual void Execute(Match board)
	{
		Setup(board);
		EmitSignal(nameof(Executed));
	}

	protected abstract void Setup(Match board);

	public Command GetInstance(object[] args)
	{
		const int exportedValue = (int)PropertyUsageFlags.ScriptVariable + (int)PropertyUsageFlags.Default;
		var copy = (Command) Activator.CreateInstance(GetType(), args);
		foreach (Dictionary dict in GetPropertyList())
		{
			var usage = (int) dict["usage"];
			if (usage != exportedValue) continue;
			var prop = (string) dict["name"];
			copy.Set(prop, Get(prop));
		}
		return copy;
	}
}