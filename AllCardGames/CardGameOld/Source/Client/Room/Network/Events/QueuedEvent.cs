namespace CardGame.Client.Match.Events
{
    public class QueuedEvent: EventArgs
    {
        public CommandId CommandId { get; }
        public object[] Args { get; }

        public QueuedEvent(CommandId commandId, object[] args)
        {
            CommandId = commandId;
            Args = args;
        }
    }
}