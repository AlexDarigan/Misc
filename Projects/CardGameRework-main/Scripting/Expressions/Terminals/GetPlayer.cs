using CardGame.Common.Constants;
using CardGame.Server;
using CardGame.Server.Game;

namespace CardGame.Scripting.Expressions.Terminals;

public class GetPlayer : Terminal
{
    [Export(PropertyHint.Enum)] public Who Player { get; set; }
    
    private GetPlayer() { }
    public GetPlayer(Who who) { Player = who; }
    
    public override object Resolve(Match match, Card card)
    {
        return Player switch
        {
            Who.Owner => card.Owner,
            Who.Controller => card.Controller,
            Who.Opponent => card.Controller.Opponent,
            _ => throw new ArgumentOutOfRangeException()
        };
    }
}