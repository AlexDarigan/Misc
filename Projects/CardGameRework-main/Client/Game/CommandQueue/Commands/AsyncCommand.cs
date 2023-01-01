namespace CardGame.Client.Game.CommandQueue.Commands;

public abstract class AsyncCommand: Command
{
    public override void Execute(Match board)
    {
        SceneTreeTween = GetTree().CreateTween();
        SceneTreeTween.Stop();
        SceneTreeTween.Connect("finished", this, nameof(OnCommandExecuted));
        Setup(board);
        SceneTreeTween.Play();
    }

    public void OnCommandExecuted()
    {
        // SceneTreeTween.Stop();
        // SceneTreeTween.Kill();
        // SceneTreeTween = null;
        EmitSignal(nameof(Executed));
    }
}