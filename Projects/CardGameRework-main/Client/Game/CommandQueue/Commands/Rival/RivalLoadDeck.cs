namespace CardGame.Client.Game.CommandQueue.Commands.Rival;

public class RivalLoadDeck: Command
{
    protected override void Setup(Match board)
    {
        board.Rival.LoadDeck(board.CardAlbum);
    }
}