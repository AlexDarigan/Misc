using CardGame.Common.Constants;
using CardGame.Server;
using CardGame.Server.Game;

namespace CardGame.Scripting.Expressions;

public class Binary : Expr
{
    [Export(PropertyHint.Enum)] private BinaryOp Op { get; set; }
    
    private Binary() {}

    // It is possible that MathOp gets resolved from an effect (namely if statement)
    public Binary(Expr a, Expr b, BinaryOp op)
    {
        Add(a);
        Add(b);
        Op = op;
    }
    
    public override object Resolve(Match match, Card card)
    {
        var a = Resolve<int>(0, match, card);
        var b = Resolve<int>(1, match, card);
        return Op switch
        {
            BinaryOp.Add => a + b,
            BinaryOp.Divide => a / b,
            BinaryOp.Subtract => a - b,
            BinaryOp.Multiply => a * b,
            _ => throw new ArgumentOutOfRangeException()
        };
    }
}