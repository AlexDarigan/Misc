using System.Collections.Generic;

namespace CardGame.Server.MatchMaking.Events
{
    public class MatchMade : EventArgs
    {
        public Room Room { get; }
        public IEnumerable<Player> Players { get; }

        public MatchMade(Room room, IEnumerable<Player> players)
        {
            Room = room;
            Players = players;
        }
    }
}