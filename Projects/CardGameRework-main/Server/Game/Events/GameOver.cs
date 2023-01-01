using CardGame.Common.Constants;
using CardGame.Server.Game;
using CardGame.Server.Game.Players;

namespace CardGame.Server.Events;

public class GameOver: GameEventArgs
{
    private const bool IsLoser = true;
    private Player Loser { get; }
    // Add Reason?

    public GameOver(Player loser) { Loser = loser; }
        
    public override void QueueOnClients(Enqueue queue)
    {
        queue(Loser.Id, CommandId.GameOver, IsLoser);
        queue(Loser.Opponent.Id, CommandId.GameOver, !IsLoser);
    }
}