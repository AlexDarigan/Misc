using CardGame.Server;
using CardGame.Server.Game;
using CardGame.Server.Game.Players;

namespace CardGame.Scripting.Statements;

public class SetHealthEffect : Statement
{
    // This is being created to test math more than any property related thing
    // In future, may create "Property" class that returns a class (this allows for
    // different execution paths)
    private SetHealthEffect() { }
    public SetHealthEffect(Expr a, Expr b)
    {
        Add(a);
        Add(b);
    }
    
    public override object Resolve(Match match, Card card)
    {
        var player = Resolve<Player>(0, match, card);
        var newHealth = Resolve<int>(1, match, card);
        player.Health = newHealth;
        return null;
    }
}