using CardGame.Common.Constants;
using CardGame.Server.Game;

namespace CardGame.Server.Events;

public class AttackParticipant: GameEventArgs
{
    private Card Attacker { get; }
        
    public AttackParticipant(Card attacker) { Attacker = attacker; }

    public override void QueueOnClients(Enqueue queue)
    {
        queue(Attacker.Controller.Id, CommandId.DeclareDirectAttack, Attacker.Id);
        queue(Attacker.Controller.Opponent.Id, CommandId.DeclareDirectAttack, Attacker.Id);
    }
}