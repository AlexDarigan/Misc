using CardGame.Client.Screens.Title.Buttons;

namespace CardGame.Client.Screens.Title;

public class TitleScreen : Control, IScreen
{
    private AudioStreamPlayer Player { get; set; }
    public event Action PlayPressed;
    public event Action DeckEditorPressed;
    public event Action UserProfilePressed;
    public event Action SettingsPressed;
    public event Action ExitPressed;


    public override void _Ready()
    {
        Player = GetNode<AudioStreamPlayer>("AudioStreamPlayer");
        var menu = GetNode<VBoxContainer>("Menu");
        menu.GetNode<MainMenuButton>("Play").ButtonPressed += () => { PlayPressed?.Invoke(); };
        menu.GetNode<MainMenuButton>("DeckEditor").ButtonPressed += () => { DeckEditorPressed?.Invoke(); };
        menu.GetNode<MainMenuButton>("UserProfile").ButtonPressed += () => { UserProfilePressed?.Invoke(); };
        menu.GetNode<MainMenuButton>("Settings").ButtonPressed += () => { SettingsPressed?.Invoke(); };
        menu.GetNode<MainMenuButton>("Exit").ButtonPressed += () => { ExitPressed?.Invoke(); };
    }

    public void Display()
    {
        Player.Play();
        Show();
        
    }

    public void StopDisplaying()
    {
        Player.Stop();
        Hide();
    }
}