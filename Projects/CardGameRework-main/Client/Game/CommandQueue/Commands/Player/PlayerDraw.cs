namespace CardGame.Client.Game.CommandQueue.Commands.Player;

public class PlayerDraw : AsyncCommand
{
    
    private int CardId { get; }
		
    private PlayerDraw () {}

    public PlayerDraw(int cardId)
    {
        CardId = cardId;
    }
		
    protected override void Setup(Match board)
    {
        board.Player.Draw(board.CardAlbum.GetCard(CardId), SceneTreeTween);
    }
}