namespace CardGame.Client.Game.CommandQueue.Commands.Rival;

public class RivalActivate: AsyncCommand
{
    private int CardId { get; }
    private string SetCode { get; }
    
    private int SlotIndex { get; }

    private RivalActivate() {}
    
    public RivalActivate(int cardId, string setCode, int slotIndex)
    {
        CardId = cardId;
        SetCode = setCode;
        SlotIndex = slotIndex;
    }
    
    protected override void Setup(Match board)
    {
       board.Rival.ActivateCard(CardId, SetCode, SlotIndex, board.CardAlbum, SceneTreeTween);
    }
}