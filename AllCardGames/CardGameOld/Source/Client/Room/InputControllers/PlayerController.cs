using CardGame.Client.Match.Input.Events;

namespace CardGame.Client.Match.InputControllers
{
    public class PlayerController
    {
        public event EventHandler<DeployedUnit> UnitDeployed;
        public event EventHandler<SetFaceDown> CardSetFaceDown;
        public event EventHandler<UnitAttacked> AttackedUnit;
        // public event EventHandler<AttackedPlayer> AttackedPlayer;
        // public event EventHandler<ActivatedCard> ActivatedCard;
        // public event EventHandler<PassedPlay> PassedPlay;
        // public event EventHandler<EndedTurn> EndedTurn;

        private Card Attacker { get; set; }

        public void OnCardPressed(object sender, PressedCard e)
        {
            Console.WriteLine($"Clicked {e.Card}");
            switch (e.Card.State)
            {
                case CardStates.Deploy:
                    DeployUnit(e.Card);
                    break;
                case CardStates.SetFaceDown:
                    SetFaceDown(e.Card);
                    break;
                case CardStates.AttackUnit:
                    Attacker = Attacker is null ? e.Card : null;
                    break;
                case CardStates.AttackPlayer:
                    break;
                case CardStates.Activate:
                    break;
                case CardStates.None:
                    // if attacker is not null, card state is attack unit, (and valid target)
                    if(Attacker is not null)
                    { AttackUnit(Attacker, e.Card); }
                    break;
                default:
                    throw new ArgumentOutOfRangeException();
            }
        }

        private void DeployUnit(Card card)
        {
            UnitDeployed?.Invoke(this, new DeployedUnit(card));
        }
        
        private void SetFaceDown(Card card)
        {
            CardSetFaceDown?.Invoke(this, new SetFaceDown(card));
        }

        private void AttackUnit(Card attacker, Card defender)
        {
            AttackedUnit?.Invoke(this, new UnitAttacked(attacker, defender));
        }
        
        private void ActivateFaceDown()
        {
            
        }

        private void PassPlay()
        {
            
        }

        private void EndTurn()
        {
            
        }
        
        
        
        
    }
}