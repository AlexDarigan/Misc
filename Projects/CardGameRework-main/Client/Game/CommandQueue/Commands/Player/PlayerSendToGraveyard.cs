namespace CardGame.Client.Game.CommandQueue.Commands.Player;

public class PlayerSendToGraveyard: AsyncCommand
{
    private int CardId { get; set; }
    private PlayerSendToGraveyard() {}

    public PlayerSendToGraveyard(int cardId)
    {
        CardId = cardId;
    }
    
    protected override void Setup(Match board)
    {
        board.Player.SendToGraveyard(board.CardAlbum.GetCard(CardId), SceneTreeTween);
    }
}