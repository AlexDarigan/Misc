using System.Collections;
using System.Collections.Generic;

namespace CardGame.Client.Match
{
	public class Zone: Node
	{
		private Position3D Hint { get; }
		private IList<Card> Cards { get; } = new List<Card>();
		private Zone() { }
		
		public Zone(Position3D hint)
		{
			Hint = hint;
		}
		
		public void Add(Card card)
		{
			Cards.Add(card);
			AddChild(card);
		}

		public void Remove(Card card)
		{
			Cards.Remove(card);
			RemoveChild(card);
		}
		
		public void Shift(Vector3 offset)
		{
			Hint.Translation += offset;
		}

		public void Update(Vector3 offset)
		{
			// This is really just for our deck
			foreach (Card card in Cards)
			{
				card.Translation = Hint.Translation + offset * card.GetIndex();
				card.RotationDegrees = Hint.RotationDegrees;
			}
		}
		
		public void Update(Vector3 offset, IGameBoard board)
		{

			foreach (Card card in Cards)
			{
				board.Effects.Gfx.InterpolateProperty(
					card, 
					"translation", 
					card.Translation,
					Hint.Translation + offset * card.GetIndex(), 
					.2f);
				
				board.Effects.Gfx.InterpolateProperty(
					card, 
					"rotation_degrees", 
					card.RotationDegrees,
					Hint.RotationDegrees, .2f);
			}
		}
	}
}
