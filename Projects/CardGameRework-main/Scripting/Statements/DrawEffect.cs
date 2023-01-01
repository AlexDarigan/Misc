using CardGame.Server;
using CardGame.Server.Events;
using CardGame.Server.Game;
using CardGame.Server.Game.Players;

namespace CardGame.Scripting.Statements;

public class DrawEffect : Statement
{
    private DrawEffect() { }
    public DrawEffect(Expr getPlayer, Expr number)
    {
        Add(getPlayer);
        Add(number);
    }
    
    public override object Resolve(Match match, Card card)
    {
        var player = Resolve<Player>(0, match, card);
        var count = Resolve<int>(1, match, card);
        
        for (var i = 0; i < count; i++)
        {
            var drawn = player.Deck[^1];
            player.Deck.Remove(drawn);
            player.Hand.Add(drawn);
            match.Publish(new Draw(drawn));
        }

        return null;
    }
}