using Godot;
using System;

namespace CardGame.Server
{
    public class ServerRoom : Node
    {
        
        // export game

        private Player _player1 { get; set; }
        private Player _player2 { get; set; }
        
        public static ServerRoom CreateInstance(Player player1, Player player2)
        {
            // Create
            var room = (ServerRoom) GD.Load<PackedScene>("res://Server/ServerRoom.tscn").Instance();
            room._player1 = player1;
            room._player2 = player2;
            return room;
        }

        [Master]
        public void PlayerReady(int id)
        {
            Console.WriteLine($"{id} is ready!");
        }
    }
}