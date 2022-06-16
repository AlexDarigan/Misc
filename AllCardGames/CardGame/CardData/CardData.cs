namespace CardGame.CardData;
public class CardData : Resource
{
    [Export()] public string Name { get; private set; }
    [Export(PropertyHint.ResourceType)] private CardType CardType { get; set; }
    [Export(PropertyHint.ResourceType)] private Faction Faction { get; set; }
    [Export()] private int Power { get; set; } = 0;

    public (string, CardType, Faction, int) GetServerData()
    {
        return (Name, CardType, Faction, Power);
    }
}
