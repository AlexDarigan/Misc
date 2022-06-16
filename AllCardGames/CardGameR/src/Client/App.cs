namespace Client
{
    public class App : Node
    {
        private App () { /* Godot Engine Reflection */}
        private MainMenu MainMenu { get; set; }
        private IScreen Match { get; set; }
        private IScreen DeckEditor { get; set; }
        private IScreen UserProfile { get; set; }
        private IScreen Settings { get; set; }
        private IScreen CurrentScreen { get; set; }

        public override void _Ready()
        {
            MainMenu = GetNode<MainMenu>("MainMenu");
            Match = GetNode<IScreen>("Match");
            DeckEditor = GetNode<IScreen>("DeckEditor");
            UserProfile = GetNode<IScreen>("UserProfile");
            Settings = GetNode<IScreen>("Settings");

            MainMenu.PlayPressed += OnPlayPressed;
            MainMenu.DeckEditorPressed += OnDeckEditorPressed;
            MainMenu.UserProfilePressed += OnUserProfilePressed;
            MainMenu.SettingsPressed += OnSettingsPressed;
            MainMenu.QuitPressed += OnQuitPressed;
        }

        private void Display(IScreen newScreen)
        {
            CurrentScreen?.StopDisplaying();
            CurrentScreen = newScreen;
            CurrentScreen.Display();
        }
        
        private void OnPlayPressed() { Display(Match); }
        private void OnDeckEditorPressed() { Display(DeckEditor); }
        private void OnUserProfilePressed() { Display(UserProfile); }
        private void OnSettingsPressed() { Display(Settings); }
        private void OnQuitPressed() { GetTree().Quit(); }
        
    }
}
