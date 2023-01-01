namespace CardGame.Client.Game.CommandQueue.Commands;

public class DeclareDirectAttack: Command
{
    private int CardId { get; set; }

    private DeclareDirectAttack(int attackerId)
    {
        CardId = attackerId;
    }
    
    protected override void Setup(Match board)
    {
        // board.Player.Heart.Visible = true;
        // board.CardAlbum.GetCard(CardId).Attacking.Visible = true;
    }
}