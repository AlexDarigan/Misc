using CardGame.Client.Game.Cards;
using CardGame.Client.Game.Players;
using CardGame.Data;
using Godot.Collections;
namespace CardGame.Client.Game;

public class CardAlbum : Zone
{
    [Export()] private PackedScene CardScene { get; set; }
    private Dictionary<int, Card> CardDict { get; } = new(); // Could be card list resource?

    public CardAlbum() { }
    
    public Card GetCard(int id) { return CardDict[id]; }
		
    public Card GetCard(int id, string setCode)
    {
        if(!CardDict.ContainsKey(id)) { Create(id, setCode); }
        return CardDict[id];
    }

    private void Create(int id, string setCode)
    {
        var card = CardScene.Instance<Card>();
        var cardInfo = Library.GetCard(setCode);
        AddChild(card);
        card.Name = $"[{id} {setCode}]";
        card.Id = id;
        card.Title = cardInfo.Title;
        card.Art = cardInfo.Art;
        card.Text = cardInfo.Text;
        card.CardTypes = cardInfo.CardType;
        card.Factions = cardInfo.Factions;
        card.Power = cardInfo.Power;
        CardDict[card.Id] = card;
    }

    public void Reveal(int cardId, string setCode, Card hidden)
    {
        var card = GetCard(cardId, setCode);

        // Revealing Card in Place
        hidden.Name = card.Name;
        hidden.Id = card.Id;
        hidden.Title = card.Title;
        hidden.Art = card.Art;
        hidden.Text = card.Text;
        hidden.CardTypes = card.CardTypes;
        hidden.Factions = card.Factions;
        hidden.Power = card.Power;
        CardDict[hidden.Id] = hidden;
        card.QueueFree();
    }
}