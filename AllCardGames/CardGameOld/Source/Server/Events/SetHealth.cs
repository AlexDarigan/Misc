namespace CardGame.Server.Events
{
    public class SetHealth: GameEventArgs
    {
        private int NewHealth { get; }
        private Player Damaged { get; }

        public SetHealth(Player damaged)
        {
            NewHealth = damaged.Health;
            Damaged = damaged;
        }
        
        public override void QueueOnClients(Enqueue queue)
        { 
            queue(Damaged.Id, CommandId.SetHealth, Who.Player, NewHealth);
            queue(Damaged.Opponent.Id, CommandId.SetHealth, Who.Rival, NewHealth);
        }
    }
}