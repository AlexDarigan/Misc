using System.Collections.Generic;
using CardGame.Server.Game.Players;

namespace CardGame.Server.Game.States;

public class StateMachine: Node
{
    private Match Match { get { return Owner as Match; } }
    public List<State> States { get; set; } = new List<State>();
    public State Current { get { return States[States.Count-1]; } }

    // Push a new State
    public void Push<T>(Player player) where T: State
    {
        States.Add(Activator.CreateInstance<T>());
        Enter(player);
    }

    public void Pop()
    {
        States.Remove(States[^1]);
    }
    
    public void Enter(Player player)
    {
        Current.Enter(this, Match, player);
    }
    
    public void Resolve()
    {
        Current.Resolve();
    }
    
    public void Exit()
    {
        
    }

}