namespace Server
{
    public class Match : Node
    {
        public event Action GameOver;
        public event Action GameEvent;
        public object Players { get; set; }
        public object History { get; set; }
        public object Cards { get; set; }
        public object Link { get; set; }

        public Match() { }
        public void Update() { }
        public void OnGameEvent() { }
        public void Deploy() { }
        public void SetFaceDown() { }
        public void AttackUnit() { }
        public void AttackPlayer() { }
        public void Activate() { }
        public void PassPlay() { }
        public void EndTurn() { }
    }
}