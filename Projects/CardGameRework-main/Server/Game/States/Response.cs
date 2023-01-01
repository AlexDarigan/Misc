using System.Linq;
using CardGame.Server.Events;
using CardGame.Server.Game.Events.Movement;

namespace CardGame.Server.Game.States;

public class Response: State
{
    private Action Resolvable { get; set; } = () => { };
    
    protected override void OnEnter()
    {
        CanBeActivated = Player.Supports.Where(c => c.IsReady);
    }
    
    protected override void OnActivateCard(Card card)
    {
        card.IsReady = false;
        var effect = card.Activate();
        Resolvable = () =>
        {
            effect.Resolve(Match);
            effect.Card.Controller.Supports.Remove(card);
            effect.Card.Owner.Graveyard.Add(card);
            Match.Publish(new SendToGraveyard(card));
        };
        Match.Publish(new Activation(Player, card));
        Machine.Push<Response>(Player.Opponent);
    }

    protected override void OnPassPlay()
    {
        Machine.Push<Act>(Player.Opponent);
    }

    protected override void OnResolve()
    {
        Resolvable();
        Machine.Pop();
        Machine.Resolve();
    }
}