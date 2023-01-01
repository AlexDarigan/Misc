using CardGame.Server.Game;

namespace CardGame.Server.Events;

public abstract class GameEventArgs: EventArgs
{
    public abstract void QueueOnClients(Enqueue queue);
}