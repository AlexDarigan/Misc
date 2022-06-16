using CardGame.Client.Resources;

namespace CardGame.Client.Screens
{
	public class UserProfile : Control, IScreen
	{
		public User User { get; set; }
		private UserProfile() { }
		public void Display() { Show(); }
		public void StopDisplaying() { Hide(); }
	}
}
