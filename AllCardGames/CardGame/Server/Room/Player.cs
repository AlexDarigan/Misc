using System.Collections.Generic;
using CardGame.Server.Cards;
using Godot.Collections;
namespace CardGame.Server.Room;

public class Player: Godot.Object
{
    public int Id { get; }
    public Array<string> DeckList { get; set; }
    public IList<Card> Deck { get; set; } = new List<Card>();

    public Player(int playerId)
    {
        Id = playerId;
    }
}