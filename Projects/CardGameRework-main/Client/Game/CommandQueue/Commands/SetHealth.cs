using CardGame.Common.Constants;

namespace CardGame.Client.Game.CommandQueue.Commands;

public class SetHealth: Command
{
    private Who Who { get; set; }
    private int Health { get; set; }
    
    private SetHealth() {}

    public SetHealth(int who, int health)
    {
        Who = (Who) who;
        Health = health;
    }
    
    protected override void Setup(Match board)
    {
        // var health = Who == Who.Controller ? board.Player.Health : board.Rival.Health;
        // health.Text = Health.ToString();
    }
}