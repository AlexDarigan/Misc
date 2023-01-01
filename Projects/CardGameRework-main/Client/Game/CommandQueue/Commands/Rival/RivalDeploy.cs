namespace CardGame.Client.Game.CommandQueue.Commands.Rival;

public class RivalDeploy: AsyncCommand
{
    private int CardId { get; }
    private string SetCode { get; }

    private RivalDeploy() { }
        
    public RivalDeploy(int cardId, string setCode)
    {
        CardId = cardId;
        SetCode = setCode;
    }
        
    protected override void Setup(Match board)
    {
       board.Rival.Deploy(CardId, SetCode, board.CardAlbum, SceneTreeTween);
    }
}