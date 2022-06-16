namespace CardGame.Client.Match.Commands
{
    public class AttackUnit: Command
    {
        private int AttackerId { get; }
        private int DefenderId { get; }
        
        public AttackUnit(int attackerId, int defenderId)
        {
            AttackerId = attackerId;
            DefenderId = defenderId;
        }
        
        protected override void Setup(IGameBoard board)
        {
            Card attacker = board.Cards[AttackerId];
            Card defender = board.Cards[DefenderId];

            Vector3 sourceRotation = attacker.RotationDegrees;
            attacker.LookAt(defender.Translation, Vector3.Up);
            board.Effects.Gfx.InterpolateProperty(
                attacker,
                "translation",
                attacker.Translation,
                defender.Translation,
                .25f
            );
            
            board.Effects.Gfx.InterpolateProperty(
                attacker,
                "translation",
                defender.Translation,
                attacker.Translation,
                .25f, Tween.TransitionType.Back, Tween.EaseType.Out, .25f
            );

            board.Effects.Gfx.InterpolateProperty(
                attacker,
                "rotation_degrees",
                attacker.RotationDegrees,
                sourceRotation,
                .25f, Tween.TransitionType.Linear, Tween.EaseType.In, .25f
            );

        }
    }
}

