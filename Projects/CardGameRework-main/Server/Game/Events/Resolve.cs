using CardGame.Common.Constants;
using CardGame.Server.Game;
using CardGame.Server.Game.Players;

namespace CardGame.Server.Events;

public class Resolve: GameEventArgs
{
    // This doesn't really matter but we do need to get the IDs somehow (maybe look into revising this?)
    private Player Player { get; }
    private Card Card { get; }
        
    public Resolve(Player player, Card card = null)
    {
        Player = player;
        Card = card;
    }
        
    public override void QueueOnClients(Enqueue queue)
    {
        queue(Player.Id, CommandId.Resolve);
        queue(Player.Opponent.Id, CommandId.Resolve);
    }
}