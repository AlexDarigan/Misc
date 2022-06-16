using System.Collections.Generic;
using System.Linq;
using CardGame.Client.Match.Commands;

namespace CardGame.Client.Match
{
	public class CommandQueue
	{
		private static IReadOnlyDictionary<CommandId, Type> Commands { get; }
		private Queue<Command> Queue { get; } = new();

		static CommandQueue()
		{
			Commands = Enum.GetValues(typeof(CommandId)).Cast<CommandId>().ToDictionary(id => id, id =>
				Type.GetType($"CardGame.Client.Match.Commands.{Enum.GetName(id.GetType(), id)}"));
		}

		public async void Update(IGameBoard board)
		{
			while (Queue.Count > 0)
			{
				await Queue.Dequeue().Execute(board);
			}
		}
		
		public void Enqueue(CommandId commandId, object[] args)
		{
			Console.WriteLine(commandId);
			try
			{
				Queue.Enqueue((Command) Activator.CreateInstance(Commands[commandId], args));
			}
			catch (Exception e)
			{
				Console.WriteLine($"No Instance of Command {commandId.ToString()} exists yet");
			}
		}
	}

// [Puppet]
		// public async void Update()
		// {
		//     while (CommandQueue.Count > 0)
		//     {
		//         await CommandQueue.Dequeue().Execute(this);
		//     }
		// }
		//
		// [Puppet]
		// public void Queue(CommandId commandId, object[] args)
		// {
		//     Console.WriteLine(commandId);
		//     try
		//     {
		//         Queue.Enqueue((Command) Activator.CreateInstance(Commands[commandId], args));
		//     }
		//     catch (Exception e)
		//     {
		//         Console.WriteLine($"No Instance of Command {commandId.ToString()} exists yet");
		//     }
		// }
}
