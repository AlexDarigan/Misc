namespace CardGame.Client.Game.CommandQueue.Commands.Player;

public class PlayerSetFaceDown: AsyncCommand
{
    private int CardId { get; }

    private PlayerSetFaceDown() { }
        
    public PlayerSetFaceDown(int cardId)
    {
        CardId = cardId;
    }
        
    protected override void Setup(Match board)
    {
        board.Player.SetFaceDown(board.CardAlbum.GetCard(CardId), SceneTreeTween);
    }
}