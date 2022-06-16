using CardGame.Client.Resources;

namespace CardGame.Client.Screens
{
	public class DeckEditor : Control, IScreen
	{
		private DeckEditor() { }
		public User User { get; set; }
		public void Display() { Show(); }
		public void StopDisplaying() { Hide(); }
	}
}
