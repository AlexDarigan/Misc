namespace CardGame.Common;

public class PlainTextLogger: Logger
{
    public PlainTextLogger()
    {
        Log(this, "Starting Plain TextLogger");
    }

    protected override void _Log(Godot.Object source, string what)
    {
        RunningLog += $"{what} ({((Resource) source.GetScript()).ResourcePath} : {Time.GetTimeStringFromSystem()})\n";
        Logged = RunningLog;    
    }

    public override void OnApplicationAboutToClose()
    {
        System.IO.File.WriteAllText($"{OS.GetUserDataDir()}/{Time.GetDatetimeStringFromSystem().Replace(":","-")}.txt", Logged);
    }
}