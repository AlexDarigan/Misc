using System.Linq;
using Godot.Collections;
namespace CardGame.Client.UserData;

public class DeckList: Resource
{
    [Export()] public Array<CardData.CardData> Cards { get; set; }

    public Array<string> Deck => new Array<string>(Cards.Select(data => data.Name));
}