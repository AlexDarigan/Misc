namespace Client
{
    public class MainMenu : HBoxContainer
    {
        public event Action PlayPressed;
        public event Action DeckEditorPressed;
        public event Action UserProfilePressed;
        public event Action SettingsPressed;
        public event Action QuitPressed;

        public override void _Ready()
        {
            void Subscribe(string name, string method)
            {
                GetNode<Button>(name).Connect("pressed", this, method);
            }

            Subscribe("Play", nameof(OnPlayPressed));
            Subscribe("DeckEditor", nameof(OnDeckEditorPressed));
            Subscribe("UserProfile", nameof(OnUserProfilePressed));
            Subscribe("Settings", nameof(OnSettingsPressed));
            Subscribe("Quit", nameof(OnQuitPressed));
        }

        private void OnPlayPressed() { PlayPressed?.Invoke(); }
        private void OnDeckEditorPressed() { DeckEditorPressed?.Invoke(); }
        private void OnUserProfilePressed() { UserProfilePressed?.Invoke(); }
        private void OnSettingsPressed() { SettingsPressed?.Invoke(); }
        private void OnQuitPressed() { QuitPressed?.Invoke(); }
    }
}
