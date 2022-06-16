namespace CardGame.Client.Match.Commands
{
    public class PlayerUpdate: Command
    {
        private States State { get; }

        public PlayerUpdate(int state)
        {
            State = (States) state;
        }
        
        protected override void Setup(IGameBoard board)
        {
            board.Player.State = State;
            board.Table.SetState(State);
        }
    }
}