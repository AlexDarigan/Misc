using System.Collections.Generic;

namespace CardGame.Client.Match
{
	public class Participant : Node
	{
		public Zone Deck { get; private set; }
		public Zone Discard { get; private set; }
		public Zone Hand { get; private set; }
		public Zone Units { get; private set; }
		public Zone Supports { get; private set; }
		public States State { get; set; }

		public override void _Ready()
		{
			Deck = new Zone(GetNode<Position3D>("DeckHint"));
			Discard = new Zone(GetNode<Position3D>("DiscardHint"));
			Units = new Zone(GetNode<Position3D>("UnitsHint"));
			Supports = new Zone(GetNode<Position3D>("SupportsHint"));
			Hand = new Zone(GetNode<Position3D>("HandHint"));
			AddChild(Deck);
			AddChild(Discard);
			AddChild(Units);
			AddChild(Supports);
			AddChild(Hand);
		}

	}
}
