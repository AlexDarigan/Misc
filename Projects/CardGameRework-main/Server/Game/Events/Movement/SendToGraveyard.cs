using CardGame.Common.Constants;
using CardGame.Server.Events;

namespace CardGame.Server.Game.Events.Movement;

public class SendToGraveyard: MoveGameEventArgs
{
	public SendToGraveyard(Card card): base(card) { }
	public override void QueueOnClients(Enqueue queue)
	{
		queue(Card.Owner.Id, CommandId.PlayerSendToGraveyard, Card.Id);
		queue(Card.Owner.Opponent.Id, CommandId.RivalSendToGraveyard, Card.Id);
	}
}