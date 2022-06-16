using CardGame.Client.Resources;

namespace CardGame.Client.Screens
{
	public class Settings : Control, IScreen
	{
		public User User { get; set; }
		public Settings() { }
		public void Display() { Show(); }
		public void StopDisplaying() { Hide(); }
	}
}
