using CardGame.Server;
using CardGame.Server.Game;

namespace CardGame.Scripting.Expressions.Terminals;

public class Literal : Terminal
{
    [Export()] public int Value { get; set; }

    private Literal() { }
    public Literal(int i) { Value = i; }
    public override object Resolve(Match match, Card card) { return Value; }
}