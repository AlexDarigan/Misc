using CardGame.Common.Constants;
using CardGame.Server.Game;
using CardGame.Server.Game.Players;

namespace CardGame.Server.Events;

public class SetHealth: GameEventArgs
{
    private int NewHealth { get; }
    private Player Damaged { get; }

    public SetHealth(Player damaged)
    {
        NewHealth = damaged.Health;
        Damaged = damaged;
    }
        
    public override void QueueOnClients(Enqueue queue)
    { 
        queue(Damaged.Id, CommandId.SetHealth, Who.Controller, NewHealth);
        queue(Damaged.Opponent.Id, CommandId.SetHealth, Who.Opponent, NewHealth);
    }
}