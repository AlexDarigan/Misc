namespace CardGame.Client.Game.CommandQueue.Commands.Player;

public class PlayerDeploy: AsyncCommand
{
    private int CardId { get; }
        
    private PlayerDeploy() {}

    public PlayerDeploy(int cardId)
    {
        CardId = cardId;
    }
        
    protected override void Setup(Match board)
    {
        board.Player.Deploy(board.CardAlbum.GetCard(CardId), SceneTreeTween);
    }
}