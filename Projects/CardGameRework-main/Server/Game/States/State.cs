using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using CardGame.Common.Constants;
using CardGame.Server.Game.Players;
using Godot.Collections;

namespace CardGame.Server.Game.States;

public class State
{
    protected IEnumerable<Card> CanBeDeployed { get; set; }
    protected IEnumerable<Card> CanBeSetFaceDown { get; set; }
    protected IEnumerable<Card> CanAttackUnit { get; set; }
    protected IEnumerable<Card> CanAttackPlayer { get; set; }
    protected IEnumerable<Card> CanBeActivated { get; set; }
    protected Player Player { get; set; }
    protected Match Match { get; set; }
    protected StateMachine Machine { get; set; }

    
    public void Enter(StateMachine machine, Match match, Player acting)
    {
        Machine = machine;
        Match = match;
        Player = acting;
        CanBeDeployed = new List<Card>();
        CanBeSetFaceDown = new List<Card>();
        CanAttackUnit = new List<Card>();
        CanAttackPlayer = new List<Card>();
        CanBeActivated = new List<Card>();
        OnEnter();
    }

    public void Exit()
    {
        OnExit();
    }

    public void StartGame(List<Player> player)
    {
        OnStartGame(player);
    }

    public void Deploy(Player player, Card unit)
    {
        if(player == Player && CanBeDeployed.Contains(unit)) { OnDeploy(unit); }
    }

    public void SetFaceDown(Player player, Card card)
    {
        if(player == Player && CanBeSetFaceDown.Contains(card)) { OnSetFaceDown(card); }
    }

    public void AttackUnit(Player player, Card attacker, Card defender)
    {
       if(player == Player && CanAttackUnit.Contains(attacker)) OnAttackUnit(attacker, defender);
    }

    public void AttackPlayer(Player player, Card attacker)
    {
       if(player == Player && CanAttackPlayer.Contains(attacker)) OnAttackPlayer(attacker);
    }

    public void ActivateCard(Player player, Card card)
    {
        if(player == Player && CanBeActivated.Contains(card)) OnActivateCard(card);
    }

    public void PassPlay(Player player)
    {
       if(player == Player) { OnPassPlay(); }
    }

    public void Resolve()
    {
        OnResolve();
    }

    public void Queue(Enqueue queue)
    {
        const bool isActingPlayer = true;
        var cards = new Godot.Collections.Dictionary<string,List<int>>
        {
            ["CanBeDeployed"] = CanBeDeployed.Select(c => c.Id).ToList(),
            ["CanBeSetFaceDown"] = CanBeSetFaceDown.Select(c => c.Id).ToList(),
            ["CanBeActivated"] = CanBeActivated.Select(c => c.Id).ToList(),
            ["CanAttackUnit"] = CanAttackUnit.Select(c => c.Id).ToList(),
            ["CanAttackPlayer"] = CanAttackPlayer.Select(c => c.Id).ToList()
        };
        queue(Player.Id, CommandId.Update, isActingPlayer, cards);
        queue(Player.Opponent.Id, CommandId.Update, !isActingPlayer, new Dictionary());
    }
    
    protected virtual void OnEnter()
    {
		
    }

    protected virtual void OnExit()
    {
		
    }

    protected virtual void OnStartGame(List<Player> players)
    {
        
    }
	
    protected virtual void OnDeploy(Card unit)
    {
        Debug.WriteLine($"{GetType()}.OnDeploy: Player {Player.Id} Disqualified");
    }

    protected virtual void OnSetFaceDown(Card support)
    {
        Debug.WriteLine($"{GetType()}.OnSetFaceDown: Player {Player.Id} Disqualified");
    }

    protected virtual void OnAttackUnit(Card attacker, Card defender)
    {
        Debug.WriteLine($"{GetType()}.OnAttackUnit: Player {Player.Id} Disqualified");
    }

    protected virtual void OnAttackPlayer(Card attacker)
    {
        Debug.WriteLine($"{GetType()}.OnAttackPlayer: Player {Player.Id} Disqualified");
    }

    protected virtual void OnActivateCard(Card card)
    {
        Debug.WriteLine($"{GetType()}.OnActivateCard: Player {Player.Id} Disqualified");
    }

    protected virtual void OnPassPlay()
    {
        Debug.WriteLine($"{GetType()}.OnPassPlay: Player {Player.Id} Disqualified");
    }

    protected virtual void OnResolve()
    {
        Debug.WriteLine($"{GetType()}.OnPassPlay: Player {Player.Id} Disqualified");
    }
}