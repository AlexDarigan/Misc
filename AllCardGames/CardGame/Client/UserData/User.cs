using Godot.Collections;
namespace CardGame.Client.UserData;

public class User: Resource
{
    [Export] public string Name { get; set; }
    [Export] public Array<DeckList> Decks { get; set; }
    [Export] public DeckList CurrentDeck { get; set; }
}