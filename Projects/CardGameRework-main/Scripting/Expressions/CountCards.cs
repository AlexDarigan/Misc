using System.Collections.Generic;
using CardGame.Server;
using CardGame.Server.Game;

namespace CardGame.Scripting.Expressions;

public class CountCards : Expr
{

    private CountCards() {}

    public CountCards(Expr expr)
    {
        Add(expr);
    }
    
    public override object Resolve(Match match, Card card)
    {
        return Resolve<List<Card>>(0, match, card).Count;
    }

}