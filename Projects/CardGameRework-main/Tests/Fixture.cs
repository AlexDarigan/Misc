using System.Collections.Generic;
using System.Linq;
using CardGame.Server.Game;
using CardGame.Server.Game.Players;
using CardGame.Server.Game.States;

namespace CardGame.Tests;

public class Fixture: Node
{
    protected Player P1 { get; set; }
    protected Player P2 { get; set; }
    protected Match Match { get; set; }
    protected StateMachine Machine { get; set; }


    protected void StartGame(IEnumerable<string> deckList1 = null, IEnumerable<string> deckList2 = null)
    {
        Machine = new StateMachine();
        P1 = new Player(1, deckList1 ?? BuildDeck());
        P2 = new Player(2, deckList2 ?? BuildDeck());
        (P1.Opponent, P2.Opponent) = (P2, P1);
        Match = new Match
        {
            Players = new Dictionary<int, Player> { { P1.Id, P1 }, { P2.Id, P2 } },
            StateMachine = Machine
        };
        
        AddChild(Match);
        Match.StartGame();
    }

    protected void EndGame()
    {
        Match?.QueueFree();
    }
    
    protected static IEnumerable<string> BuildDeck(string setCode = "NullCard")
     {
         IList<string> deckList = new List<string>();
         for (var i = 0; i < 40; i++) { deckList.Add(setCode); }
         return deckList.AsEnumerable();
     }
}
