using System.Collections.Generic;
using System.Linq;
using CardGame.Common.Constants;
using CardGame.Server;
using CardGame.Server.Game;

namespace CardGame.Scripting;

public class Effect : Node
{
    public Card Card { get; set; }
    [Export()] private List<Triggers> Triggers { get; set; }
    [Export(PropertyHint.MultilineText)] private string Text { get; set; }

    public Effect() {}
    public Effect(Node effectComponent)
    {
        AddChild(effectComponent);
    }
    
    public void Resolve(Match match)
    {
        foreach (var child in GetChildren().Cast<ScriptNode>())
        {
            child.Resolve(match, Card);
        }
    }
}