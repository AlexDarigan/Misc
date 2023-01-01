using System.Linq;
using CardGame.Common.Constants;
using CardGame.Server.Events;
using CardGame.Server.Game.Events.Movement;

namespace CardGame.Server.Game.States;

public class Idle: State
{
    private Action Resolvable { get; set; } = () => { };
    
    protected override void OnEnter()
    {
        CanBeDeployed = Player.Hand.Where(c => c.CardTypes == CardTypes.Unit);
        CanBeSetFaceDown = Player.Hand.Where(c => c.CardTypes == CardTypes.Support);
        CanBeActivated = Player.Supports.Where(c => c.IsReady);
        CanAttackUnit = Player.Units.Where(c => c.IsReady && Player.Opponent.Units.Count > 0);
        CanAttackPlayer = Player.Units.Where(c => c.IsReady && Player.Opponent.Units.Count == 0);
    }
    
    protected override void OnDeploy(Card unit)
    {
        unit.IsReady = false;
        Player.Hand.Remove(unit);
        Player.Units.Add(unit);
        Match.Publish(new Deploy(unit));
        Machine.Enter(Player);
    }

    protected override void OnSetFaceDown(Card support)
    {
        support.IsReady = false;
        Player.Hand.Remove(support);
        Player.Supports.Add(support);
        Match.Publish(new SetFaceDown(support));
        Machine.Enter(Player);
    }

    protected override void OnActivateCard(Card card)
    {
        card.IsReady = false;
        var effect = card.Activate();
        GD.Print(effect); // effect is null
        Match.Publish(new Activation(Player, card));
        Resolvable = () =>
        {
            effect.Resolve(Match);
            effect.Card.Controller.Supports.Remove(card);
            effect.Card.Owner.Graveyard.Add(card);
            Match.Publish(new SendToGraveyard(card));
            
        }; 
        Machine.Push<Response>(Player.Opponent);
    }
    
    protected override void OnPassPlay()
    {
        var card = Player.Opponent.Deck[^1];
        Player.Opponent.Deck.Remove(card);
        Player.Opponent.Hand.Add(card);
        Match.Publish(new Draw(card));
        Player.Units.ForEach(c => c.IsReady = true);
        Player.Supports.ForEach(c => c.IsReady = true);
        Player.Opponent.Units.ForEach(c => c.IsReady = true);
        Player.Opponent.Supports.ForEach(c => c.IsReady = true);
        Machine.Enter(Player.Opponent); // We're always in Idle at the bottom?
    }

    protected override void OnResolve()
    {
        Resolvable();
        Machine.Enter(Player);
    }
}