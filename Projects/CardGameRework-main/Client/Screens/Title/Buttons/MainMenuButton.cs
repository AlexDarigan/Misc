namespace CardGame.Client.Screens.Title.Buttons;

public class MainMenuButton : Button
{
    [Export()] private AudioStream OnHovered { get; set; }
    [Export()] private AudioStream OnPressed { get; set; }
    private AudioStreamPlayer Player { get; set; }
    public event Action ButtonPressed;
    
    
    public override void _Ready()
    {
        Player = GetNode<AudioStreamPlayer>("AudioStreamPlayer");
        Connect("button_down", this, nameof(OnButtonDown));
        Connect("mouse_entered", this, nameof(OnMouseEntered));
    }

    private void OnButtonDown()
    {
        Player.Stream = OnPressed;
        Player.Play();
        ButtonPressed?.Invoke();
    }

    private void OnMouseEntered()
    {
        Player.Stream = OnHovered;
        Player.Play();
    }
}