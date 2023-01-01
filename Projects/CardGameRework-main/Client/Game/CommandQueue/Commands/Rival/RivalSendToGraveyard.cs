namespace CardGame.Client.Game.CommandQueue.Commands.Rival;

public class RivalSendToGraveyard: AsyncCommand
{
    private int CardId { get; set; }
    private RivalSendToGraveyard() {}

    public RivalSendToGraveyard(int cardId)
    {
        CardId = cardId;
    }
    
    protected override void Setup(Match board)
    {
        board.Rival.SendToGraveyard(board.CardAlbum.GetCard(CardId), SceneTreeTween);
    }
}
