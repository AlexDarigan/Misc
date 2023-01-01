namespace CardGame.Client.Game.CommandQueue.Commands.Rival;

public class RivalDraw: AsyncCommand
{
    protected override void Setup(Match board)
    {
        board.Rival.Draw(SceneTreeTween);
    }
}