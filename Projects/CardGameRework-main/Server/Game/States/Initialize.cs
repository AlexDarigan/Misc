using System.Collections.Generic;
using System.Linq;
using CardGame.Data;
using CardGame.Server.Events;
using CardGame.Server.Game.Players;

namespace CardGame.Server.Game.States;

public class Initialize: State
{
    protected override void OnStartGame(List<Player> players)
    {
        foreach (var player in players) { LoadDeck(player); }
        foreach (var player in players) { DrawStartingHand(player, 7); }
        Machine.Pop();
        Machine.Push<Idle>(players.First());
    }

    private void LoadDeck(Player player)
    {
        player.Deck = player.DeckList.Select(name => CreateCard(player, name)).ToList();
        Match.Publish(new LoadDeck(player, player.Deck.ToDictionary(card => card.Id, card => card.SetCodes)));
    }

    private void DrawStartingHand(Player player, int count)
    {
        for (var i = 0; i < count; i++)
        {
            var card = player.Deck[^1];
            player.Deck.Remove(card);
            player.Hand.Add(card);
            Match.Publish(new Draw(card));
        }
    }

    private Card CreateCard(Player owner, string name)
    {
        var cardInfo = Library.GetCard(name);
        var card = new Card(name, Match.Cards.Count, owner, cardInfo);
        Match.Cards.Add(card);
        return card;
    }
}