using CardGame.Client.Match.Events;

namespace CardGame.Client.Match
{
	public class NetworkMessenger: Node
	{
		public event EventHandler<QueuedEvent> EventQueued;
		public event EventHandler Updated;
		
		[Puppet]
		public void Queue(CommandId commandId, object[] args)
		{
			EventQueued?.Invoke(this, new QueuedEvent(commandId, args));
		}

		[Puppet]
		public void Update()
		{
			Updated?.Invoke(this, null);
		}
	}
}
