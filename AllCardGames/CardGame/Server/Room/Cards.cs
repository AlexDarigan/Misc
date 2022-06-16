using CardGame.Libraries;
using CardGame.Server.Cards;
using Godot.Collections;

namespace CardGame.Server.Room;

public class Cards : Node
{
    [Export()] public Library Library { get; set; }
    private Dictionary<int, Card> CardIndex { get; set; }
    public Card this[int cardId] => CardIndex[cardId];

    public override void _Ready()
    {
       Library.Initialize();
    }

    public Card CreateCard(string cardName, Player owner)
    {
        var card = Library[cardName] as Card;
        card.OwningPlayer = owner;
        card.Controller = owner;
        return card;
    }
}
