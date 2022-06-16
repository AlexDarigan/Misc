using CardGame.Client.Resources;
using CardGame.Client.Screens;

namespace CardGame.Client
{
	
	public class App : Control
	{
		[Export] public User User { get; set; } = new User();
		private DeckListMenu DeckListMenu { get; set; }
		private MainMenu MainMenu { get; set; }
		private IScreen DeckEditor { get; set; }
		private IScreen UserProfile { get; set; }
		private IScreen Settings { get; set; }
		private IScreen CurrentScreen { get; set; }
		private Match.Room Room { get; set; }
		private readonly string _displayName;
		
		private App()
		{
			string[] args = OS.GetCmdlineArgs();
			if (args.Length > 1 && !Engine.EditorHint)
			{
				_displayName = args[0];
				OS.SetWindowTitle(args[0]);
				OS.CurrentScreen = Convert.ToInt32(args[1]);
				OS.WindowFullscreen = true;
			}
		}

	
		public override void _Ready()
		{
			DeckListMenu = GetNode<DeckListMenu>("DeckListMenu");
			MainMenu = GetNode<MainMenu>("MainMenu");
			Room = GetNode<Match.Room>("Room");
			DeckEditor = GetNode<IScreen>("DeckEditor");
			UserProfile = GetNode<IScreen>("UserProfile");
			Settings = GetNode<IScreen>("Settings");

			DeckListMenu.User = User;
			Room.User = User;
			DeckEditor.User = User;
			UserProfile.User = User;
			Settings.User = User;

			MainMenu.PlayPressed += OnPlayPressed;
			MainMenu.DeckEditorPressed += OnDeckEditorPressed;
			MainMenu.UserProfilePressed += OnUserProfilePressed;
			MainMenu.SettingsPressed += OnSettingsPressed;
			MainMenu.QuitPressed += OnQuitPressed;

			//GetNode<Label>("DisplayName").Text = User.DisplayName;
			GetNode<Label>("DisplayName").Text = _displayName;
		}

		public void Display()
		{
			Show();
			if(CurrentScreen == Room) { Room.Display();}
		}

		public void StopDisplaying()
		{
			Hide();
			Room?.StopDisplaying();
		}
		
		private void DisplayScreen(IScreen newScreen)
		{
			CurrentScreen?.StopDisplaying();
			CurrentScreen = newScreen;
			CurrentScreen.Display();
		}
		
		private void OnPlayPressed() { DisplayScreen(Room); }
		private void OnDeckEditorPressed() { DisplayScreen(DeckEditor); }
		private void OnUserProfilePressed() { DisplayScreen(UserProfile); }
		private void OnSettingsPressed() { DisplayScreen(Settings); }
		private void OnQuitPressed() { GetTree().Quit(); }
	}
}
