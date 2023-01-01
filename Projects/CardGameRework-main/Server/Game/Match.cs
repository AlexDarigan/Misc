using System.Collections.Generic;
using System.Linq;
using CardGame.Server.Events;
using CardGame.Server.Game.Players;
using CardGame.Server.Game.States;
namespace CardGame.Server.Game;

public class Match: Node
{
	public event Action<GameEventArgs> PublishEvent;
	public List<Card> Cards { get; } = new();
	public Dictionary<int, Player> Players { get; init; }
	public StateMachine StateMachine { get; init; } = new();
	public Match() {  }

	public override void _Ready()
	{
		AddChild(StateMachine);
		StateMachine.Owner = this;
		StateMachine.Push<Initialize>(Players.Values.First());
	}

	public void Publish(GameEventArgs ge)
	{
		PublishEvent?.Invoke(ge);
	}

	public void StartGame()
	{
		StateMachine.Current.StartGame(Players.Values.ToList());
	}
	
	public void Deploy(int id, int unit)
	{
		StateMachine.Current.Deploy(Players[id], Cards[unit]);
	}

	public void AttackUnit(int id, int attacker, int defender)
	{
		StateMachine.Current.AttackUnit(Players[id], Cards[attacker], Cards[defender]);
	}

	public void AttackPlayer(int id, int attacker)
	{
		StateMachine.Current.AttackPlayer(Players[id], Cards[attacker]);
	}

	public void SetFaceDown(int id, int support)
	{
		StateMachine.Current.SetFaceDown(Players[id], Cards[support]);
	}

	public void Activate(int id, int support)
	{
		StateMachine.Current.ActivateCard(Players[id], Cards[support]);
	}
		
	public void PassPlay(int id)
	{
		StateMachine.Current.PassPlay(Players[id]);
	}
	
	public void Update(Enqueue enqueue)
	{
		StateMachine.Current.Queue(enqueue);
	}
}
