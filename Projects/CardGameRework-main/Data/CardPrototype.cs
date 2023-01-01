using CardGame.Common.Constants;
using CardGame.Scripting;

namespace CardGame.Data;

public class CardPrototype : Node
{
    [Export()] public Texture Art { get; set; }
    [Export()] public string Title { get; set; }
    [Export()] public CardTypes CardType { get; set; }
    [Export()] public Factions Factions { get; set; }
    [Export()] public int Power { get; set; }
    [Export(PropertyHint.MultilineText)] public string Text { get; set; }
    public Effect Effect { get; private set; }

    public override void _Ready()
    {
        Effect = GetNodeOrNull<Effect>("CardEffect");
    }
}