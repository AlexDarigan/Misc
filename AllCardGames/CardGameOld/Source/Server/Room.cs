using System.Collections.Generic;
using System.Linq;
using CardGame.Server.Events;

namespace CardGame.Server
{
	public delegate void Enqueue(int id, CommandId command, params object[] args);

	public class Room: Node 
	{
		private Match Match { get; }
		public Room() { /* Required By Godot Engine Callbacks */  }

		public Room(Player player1, Player player2)
		{
			Match = new Match(player1, player2);
			Match.GameEvent += OnGameEvent;
			Match.GameUpdated += OnGameUpdated;
			
		}

		private Player GetSender() { return Match.Players[CustomMultiplayer.GetRpcSenderId()]; }
		private Card GetCard(int cardId) { return Match.Cards[cardId]; }

		[Master]
		public void OnClientReady()
		{
			GetSender().Ready = true;
			if (Match.Players.Values.Any(player => !player.Ready)) return;
			Match.Begin(Match.Players.Values.ToList());
		}
		
		[Master] public void Deploy(int id) { Match.Deploy(GetSender(), GetCard(id)); }
		[Master] public void SetFaceDown(int id) { Match.SetFaceDown(GetSender(), GetCard(id)); }
		[Master] public void AttackUnit(int attackerId, int defenderId) { Match.AttackUnit(GetSender(), GetCard(attackerId), GetCard(defenderId)); }
		[Master] public void AttackPlayer(int id) { Match.AttackPlayer(GetSender(), GetCard(id)); }
		[Master] public void Activate(int id) { Match.Activate(GetSender(), GetCard(id)); }
		[Master] public void PassPlay() { Match.PassPlay(GetSender()); }
		[Master] public void EndTurn() { Match.EndTurn(GetSender());}
		
		
		private void OnGameEvent(object sender, GameEventArgs args)
		{
			args.QueueOnClients(Queue);
		}

		private void OnGameUpdated(object sender, EventArgs args = null)
		{
			foreach (int id in Match.Players.Keys)
			{
				Dictionary<int, CardStates> updateCards = new();
				foreach (Card card in Match.Cards)
				{
					if (card.Controller.Id != id) continue;
					updateCards[card.Id] = card.CardStates;
				}
				
				Queue(id, CommandId.UpdateCards, updateCards.AsEnumerable());
				Queue(id, CommandId.PlayerUpdate, Match.Players[id].State);
				Update(id);
			}
		}

		private void Queue(int id, CommandId commandId, params object[] args)
		{
			RpcId(id, "Queue", commandId, args);
		}

		private void Update(int id)
		{
			RpcId(id, "Update");
		}
		
		
	}
}
