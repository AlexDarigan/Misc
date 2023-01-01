using CardGame.Server;
using CardGame.Server.Game;


namespace CardGame.Scripting;

public abstract class ScriptNode : Node
{

    public abstract object Resolve(Match match, Card card);

    protected T Resolve<T>(int position, Match match, Card card)
    {
        return (T) GetChild<ScriptNode>(position).Resolve(match, card);
    }

    protected void Add<T>(T expr) where T: ScriptNode
    {
        AddChild(expr);
    }
}