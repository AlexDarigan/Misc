using Godot.Collections;
namespace CardGame.Libraries;

public class Library : Resource
{
	[Export] private Array<PackedScene> Cards { get; set; } = new();
	private Dictionary<string, PackedScene> Index { get; set; } = new();
	public Node this[string cardName] => Index[cardName].Instance();

	public void Initialize()
	{
		foreach (var card in Cards)
		{
			Index[card.GetState().GetNodeName(0)] = card;
		}

	}
}
