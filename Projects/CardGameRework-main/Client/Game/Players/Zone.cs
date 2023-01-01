using System.Collections;
using System.Collections.Generic;
using CardGame.Client.Game.Cards;
namespace CardGame.Client.Game.Players;

public class Zone: Spatial, IEnumerable<Card>
{
	public int Count
	{
		get { return Cards.Count; }
	}
	private List<Card> Cards { get;} = new();
	private Spatial Contents { get; set; }
	
	public override void _Ready()
	{
		Contents = GetNode<Spatial>("Contents");
	}

	public void Add(Card card)
	{
		Cards.Add(card);
		Contents.AddChild(card);
	}

	public void Remove(Card card)
	{
		Cards.Remove(card);
		Contents.RemoveChild(card);
	}

	public IEnumerator<Card> GetEnumerator() { return Cards.GetEnumerator(); }
	IEnumerator IEnumerable.GetEnumerator() { return GetEnumerator(); }
	public Card this[Index index] { get { return Cards[index]; } }
}
