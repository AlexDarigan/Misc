using CardGame.Common.Constants;
using CardGame.Server.Game;
using CardGame.Server.Game.Players;

namespace CardGame.Server.Events;

public class Activation: GameEventArgs
{
    private Player Player { get; }
    private Card Activated { get; }
        
    private int SlotIndex { get; }
        
    public Activation(Player player, Card activated)
    {
        Player = player;
        Activated = activated;
        SlotIndex = player.Supports.IndexOf(activated);
    }
        
    public override void QueueOnClients(Enqueue queue)
    {
        queue(Player.Id, CommandId.PlayerActivate, Activated.Id);
        queue(Player.Opponent.Id, CommandId.RivalActivate,Activated.Id, Activated.SetCodes, SlotIndex);
    }
}