namespace CardGame.Client.Game.CommandQueue.Commands.Player;

public class PlayerActivate: AsyncCommand
{
    private int CardId { get; }
  
    private PlayerActivate() {}
    
    public PlayerActivate(int cardId)
    {
        GD.Print("Activating");
        CardId = cardId;
    }
    
    protected override void Setup(Match board)
    {
       board.Player.ActivateCard(board.CardAlbum.GetCard(CardId), SceneTreeTween);
    }
}