using System.Collections.Generic;
using System.Linq;
using CardGame.Server.Cards;

namespace CardGame.Server.Room;

public class Match: Node
{
    [Export()] private NodePath CardsPath { get; set; }
    private Cards Cards { get; set; }
    public override void _Ready()
    {
        base._Ready();
        Cards = GetNode<Cards>(CardsPath);
    }

    public void LoadDeck(Player player)
    {
        player.Deck = player.DeckList.Select(name => Cards.CreateCard(name, player)).ToList();
    }
}