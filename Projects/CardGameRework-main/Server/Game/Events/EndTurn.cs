using CardGame.Common.Constants;
using CardGame.Server.Game;
using CardGame.Server.Game.Players;

namespace CardGame.Server.Events;

public class EndTurn: GameEventArgs
{
    private Player Player { get; }

    public EndTurn(Player player)
    {
        Player = player;
    }
        
        
    public override void QueueOnClients(Enqueue queue)
    {
        queue(Player.Id, CommandId.EndTurn);
        queue(Player.Opponent.Id, CommandId.EndTurn);
    }
}