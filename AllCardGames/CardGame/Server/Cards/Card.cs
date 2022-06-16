using CardGame.Server.Room;

namespace CardGame.Server.Cards;
using CardData;

public class Card : Node
{
    [Export(PropertyHint.ResourceType)] private CardData CardData { get; set; }
    private static int _nextCardId = 0;
    public int Id { get; }
    public Player OwningPlayer { get; set; }
    public Player Controller { get; set; }
    public CardType CardType { get; set; }
    public Faction Faction { get; set; }
    public int Power { get; set; }

    public Card()
    {
        Id = _nextCardId;
        _nextCardId++;
    }
    
    public override void _Ready()
    {
        (Name, CardType, Faction, Power) = CardData.GetServerData();
    }
}
