using System.Collections.Generic;
using CardGame.Server.MatchMaking.Events;

namespace CardGame.Server.MatchMaking
{
    public class Matchmaker
    {
        public event EventHandler<MatchMade> MatchMade;
        private Queue<Player> Players { get; } = new();
        private List<Room> Rooms { get; } = new();

        public void Update()
        {
            if (Players.Count > 1) { CreateRoom(); }
        }

        public void AddPlayerToQueue(Player player)
        {
            Players.Enqueue(player);
        }
        
        private void CreateRoom()
        {
            // This will likely need review when we build our GUI since it depends on NodePaths in the tree
            Player player1 = Players.Dequeue();
            Player player2 = Players.Dequeue();
            string count = Rooms.Count.ToString();
            Room room = new(player1, player2) {Name = count};
            Rooms.Add(room);
            MatchMade?.Invoke(this, new MatchMade(room, new List<Player> { player1, player2}));
        }
    }
    
    
}