using System.Collections.Generic;
using CardGame.Server;
using CardGame.Server.Game;

namespace CardGame.Scripting.Expressions.Terminals;

public class GetZones : Terminal
{
    public enum Zone
    {
        OwnerDeck,
        OwnerHand,
        OwnerUnits,
        OwnerSupport,
        OwnerGraveyard,
        
        ControllerDeck,
        ControllerHand,
        ControllerUnits,
        ControllerSupport,
        ControllerGraveyard,
        
        OpponentDeck,
        OpponentHand,
        OpponentUnits,
        OpponentSupport,
        OpponentGraveyard
    }
    [Export()] private List<Zone> Zones { get; set; }
    private GetZones() {}

    public GetZones(List<Zone> zones)
    {
        Zones = zones;
    }
    public override object Resolve(Match match, Card card)
    {
        List<Card> cards = new();
        foreach(var zone in Zones)
        {
            cards.AddRange(zone switch
            {
                Zone.OwnerDeck => card.Owner.Deck,
                Zone.OwnerHand => card.Owner.Hand,
                Zone.OwnerUnits => card.Owner.Units,
                Zone.OwnerSupport => card.Owner.Supports,
                Zone.OwnerGraveyard => card.Owner.Graveyard,
                Zone.ControllerDeck => card.Controller.Deck,
                Zone.ControllerHand => card.Controller.Hand,
                Zone.ControllerUnits => card.Controller.Units,
                Zone.ControllerSupport => card.Controller.Supports,
                Zone.ControllerGraveyard => card.Controller.Graveyard,
                Zone.OpponentDeck => card.Controller.Opponent.Deck,
                Zone.OpponentHand => card.Controller.Opponent.Hand,
                Zone.OpponentUnits => card.Controller.Opponent.Units,
                Zone.OpponentSupport => card.Controller.Opponent.Supports,
                Zone.OpponentGraveyard => card.Controller.Opponent.Graveyard,
                _ => throw new ArgumentOutOfRangeException()
            });
        }
        return cards;
    }
}