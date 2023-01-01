namespace CardGame.Client.Game.CommandQueue.Commands;

public class DeclareAttackUnit: Command
{
    private int AttackerId { get; set; }
    private int DefenderId { get; set; }
    
    private DeclareAttackUnit() {}
    
    public DeclareAttackUnit(int attackerId, int defenderId)
    {
        AttackerId = attackerId;
        DefenderId = defenderId;
    }
    
    protected override void Setup(Match board)
    {
       // board.CardAlbum.GetCard(AttackerId).DeclareAttackUnit(board.CardAlbum.GetCard(DefenderId));
    }
}