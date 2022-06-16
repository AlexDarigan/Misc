namespace CardGame.Client.Match
{
	public class Effects : Node
	{
		// TODO: Abstract into functions and make private
		public Tween Gfx { get; }
		public AudioStreamPlayer Sfx { get; }

		public Effects()
		{
			Gfx = new Tween();
			Sfx = new AudioStreamPlayer();
			AddChild(Gfx);
			AddChild(Sfx);
		}

		public void PlaySound()
		{
			
		}

		public void MoveCard()
		{
			
		}

		public void UpdateZone()
		{
			
		}

		public void Start()
		{
			
		}

		public void Clear()
		{
			
		}
	}
}
