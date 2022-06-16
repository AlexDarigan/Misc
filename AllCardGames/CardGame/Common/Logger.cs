namespace CardGame.Common;

public abstract class Logger: CardGameResource
{
    [Export(PropertyHint.MultilineText)] protected string Logged { get; set; }
    [Export()] protected bool PrintToConsole { get; set; }
    [Export()] protected bool PrintToGodot { get; set; }
    // We keep a running log so every new run is cleared from the old logs
    protected string RunningLog { get; set; } = "";
    protected abstract void _Log(Godot.Object source, string what);

    protected Logger()
    {
        
    }
    public void Log(Godot.Object source, string what)
    {
        _Log(source, what);
        if (PrintToConsole) {
            Console.WriteLine($"{source}: {what}");
        }

        if (PrintToGodot) {
            GD.Print($"{source}: {what}");
        }
    }
}