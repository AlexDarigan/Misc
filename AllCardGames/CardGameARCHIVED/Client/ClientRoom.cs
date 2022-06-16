using Godot;
using System;

namespace CardGame.Client
{


    public class ClientRoom : Node
    {

        public static ClientRoom CreateInstance()
        { 
            return (ClientRoom) GD.Load<PackedScene>("res://Client/ClientRoom.tscn").Instance();
        }
        
        public override void _Ready()
        {
            RpcId(1, "PlayerReady", CustomMultiplayer.GetNetworkUniqueId());
        }
    }
}