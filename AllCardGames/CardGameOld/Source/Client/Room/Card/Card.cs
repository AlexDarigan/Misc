namespace CardGame.Client.Match
{
	public class PressedCard : EventArgs
	{
		public Card Card { get; }
		public PressedCard(Card card) { Card = card; }
	}
	
	[GodotScene]
	public class Card : CardBase
	{
		public EventHandler<PressedCard> CardPressed;
		public int Id { get; set; }
		public Texture Art { set { Face = value; } }
		public CardStates State { get; set; }

		public override void _Ready()
		{
			GetNode<Area>("Area").Connect("input_event", this, nameof(OnInputEvent));
			base._Ready();
		}
		
		public void OnInputEvent(Node camera, InputEvent input, 
			Vector3 clickPos, Vector3 clickNormal, int shapeIdx)
		{
			if (input is InputEventMouseButton { ButtonIndex: (int) ButtonList.Left, Doubleclick: true })
			{
				Console.WriteLine("Clicked");
				CardPressed?.Invoke(this, new PressedCard(this));
			}
		}
		
	}
}
