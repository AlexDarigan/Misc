namespace CardGame.Client.Game;

public class ClickableArea: Area
{
    private IClickable Clickable { get; set; }
    private bool HasMouse { get; set; }

    public override void _Ready()
    {
        Clickable = Owner as IClickable;
        Connect("mouse_entered", this, nameof(OnMouseEntered));
        Connect("mouse_exited", this, nameof(OnMouseExited));
    }

    public override void _Input(InputEvent input)
    {
        if (input is InputEventMouseButton { Doubleclick: true, ButtonIndex: (int) ButtonList.Left } && HasMouse)
        {
            Clickable.Click();
            GetTree().SetInputAsHandled();
        }
    }

    private void OnMouseEntered()
    {
        HasMouse = true;
    }

    private void OnMouseExited()
    {
        HasMouse = false;
    }
}