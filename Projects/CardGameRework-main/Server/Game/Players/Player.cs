using System.Collections.Generic;
using CardGame.Server.Events;

namespace CardGame.Server.Game.Players;

public class Player: Node
{
        
    public int Id { get; private set; }
    public IEnumerable<string> DeckList { get; private set; }
    public List<Card> Deck { get; set; } = new();
    public List<Card> Graveyard { get; } = new();
    public List<Card> Hand { get; } = new();
    public List<Card> Supports { get; } = new();
    public List<Card> Units { get; } = new();
    public int Health { get; set; } = 8000;
    public Player Opponent { get; set; }
    public bool IsReady { get; set; }

    public Player(int id, IEnumerable<string> deckList)
    {
        Id = id;
        DeckList = deckList;
    }
}