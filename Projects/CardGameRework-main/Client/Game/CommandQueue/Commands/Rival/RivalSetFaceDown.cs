namespace CardGame.Client.Game.CommandQueue.Commands.Rival;

public class RivalSetFaceDown: AsyncCommand
{
    protected override void Setup(Match board)
    {
        board.Rival.SetFaceDown(SceneTreeTween);
    }
}