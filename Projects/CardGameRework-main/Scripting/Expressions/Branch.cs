using CardGame.Common.Constants;
using CardGame.Server;
using CardGame.Server.Game;

namespace CardGame.Scripting.Expressions;

public class Branch : Expr
{
    
    [Export()] private LogicOp Op { get; set; }
    private Branch() {}

    public Branch(Expr a, Expr b, LogicOp op, Statement branch)
    {
        Add(a);
        Add(b);
        Op = op;
        Add(branch);
    }
    
    
    public override object Resolve(Match match, Card card)
    {
        var a = Resolve<int>(0, match, card);
        var b = Resolve<int>(1, match, card);

        var success = Op switch
        {
            LogicOp.Equal => a == b,
            LogicOp.NotEqual => a != b,
            LogicOp.Less => a < b,
            LogicOp.Greater => a > b,
            LogicOp.EqualOrLess => a <= b,
            LogicOp.EqualOrGreater => a >= b,
            LogicOp.And => Convert.ToBoolean(a) && Convert.ToBoolean(b),
            LogicOp.Or => Convert.ToBoolean(a) || Convert.ToBoolean(b),
            _ => false
        };

        return success ? Resolve<object?>(2, match, card) : null;
    }
}