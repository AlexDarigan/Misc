using System.Collections.Generic;

namespace CardGame.Server
{
    /*
     * Player is a Script that doesn't care about the game rules unlike Match
     * Largely that means what can happen here depends on who is invoking it (either
     * the game or a skill from a card). This allows us to test a number of actions with
     * ease in our Unit Tests
     */
    public class Player
    {
        public Zone Deck { get; } = new();
        public IEnumerable<string> DeckList { get; }
        public Zone Graveyard { get; } = new();
        public Zone Hand { get; } = new();
        public int Id { get; }
        public Zone Supports { get; } = new();
        public Zone Units { get; } = new();
        public Illegal ReasonPlayerWasDisqualified { get; set; } = Illegal.NotDisqualified;
        
        // TODO: Remove this when old tests are removed
        public const bool Disqualified = false;
        public int Health = 8000;
        public Player Opponent;
        public bool Ready = false;
        public States State { get; set; } = States.Passive;

        public Player(int id, IEnumerable<string> deckList)
        {
            Id = id;
            DeckList = deckList;
        }
    }
}