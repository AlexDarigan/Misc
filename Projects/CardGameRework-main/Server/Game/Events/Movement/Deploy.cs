using CardGame.Common.Constants;
using CardGame.Server.Game;

namespace CardGame.Server.Events;

public class Deploy : MoveGameEventArgs
{
    public Deploy(Card card): base(card) { }
    public override void QueueOnClients(Enqueue queue)
    {
        queue(Controller.Id, CommandId.PlayerDeploy, Card.Id);
        queue(Controller.Opponent.Id, CommandId.RivalDeploy, Card.Id, Card.SetCodes);
    }
}