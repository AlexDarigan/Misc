using CardGame.Common.Constants;
using CardGame.Server.Game;

namespace CardGame.Server.Events;

public class DeclareAttackUnit: GameEventArgs
{
    private Card Attacker { get; set; }
    private Card Defender { get; set; }


    public DeclareAttackUnit(Card attacker, Card defender)
    {
        Attacker = attacker;
        Defender = defender;
    }
    
    public override void QueueOnClients(Enqueue queue)
    {
        queue(Attacker.Controller.Id, CommandId.DeclareAttackUnit, Attacker.Id, Defender.Id);
        queue(Defender.Controller.Id, CommandId.DeclareAttackUnit, Attacker.Id, Defender.Id);
    }
}