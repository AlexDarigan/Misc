using CardGame.Client.Game.Cards;
using CardGame.Common.Constants;

namespace CardGame.Client.Game;

[GodotScene]
public class CardViewer : PanelContainer
{
    private TextureRect Art { get; set; }
    private RichTextLabel Text { get; set; }
    
    public override void _Ready()
    {
        Art = GetNode<TextureRect>("Image");
        Text = GetNode<RichTextLabel>("Image/PanelContainer/Text");
       // Card.ViewCard += OnCardViewed;
    }

    private void OnCardViewed(Card card)
    {
        if (!IsInsideTree()) { return; }
        Art.Texture = card.Art;
        var text = card.Title;
        if (card.CardTypes is CardTypes.Unit)
        {
            text += $"\n{card.Factions.ToString()}";
            text += $"\nPower: {card.Power}";
        }

        text += $"\n{card.Text}";
        Text.Text = text;
    }
}