using CardGame.Client.CardLibrary;
using Godot.Collections;

namespace CardGame.Client.Match
{
	public class CreatedCard : EventArgs
	{
		public Card Card { get; }

		public CreatedCard(Card card)
		{
			Card = card;
		}
	}

	public class Cards: Node
	{
		private static readonly PackedScene CardScene = 
			GD.Load<PackedScene>("res://Source/Client/Room/Card/Card.tscn");
		private Dictionary<int, Card> _cards { get; } = new();
		public event EventHandler<CreatedCard> CardCreated;

		public Card this[int id] { get { return _cards[id]; } }

		public Card this[int id, string setCode]
		{
			get
			{
				if(!_cards.ContainsKey(id)) { Create(id, setCode); }
				return _cards[id];
			}
		}

		private void Create(int id, string setCode)
		{
			Card card = (Card) CardScene.Instance();
			CardInfo cardInfo = Library.Cards[setCode];
			AddChild(card);
			card.Name = $"[{id} {setCode}]";
			card.Id = id;
			card.Art = cardInfo.Art;
			_cards[card.Id] = card;
			RemoveChild(card);
			CardCreated?.Invoke(this, new CreatedCard(card));
		}
	}
}
