using System.Collections.Generic;
using System.Linq;
using CardGame.Server.Events;

namespace CardGame.Server
{
    public class Match
    {
        /*
         * Match is a Rules-Enforced Script. This means any action called from here will have
         * to be a legal play otherwise the player invoking the illegal play will be disqualified.
         * When we want to test actions independently of a script like this, we will just invoke them
         * directly on their owners (either a player or a skill).
         */

        public event EventHandler GameUpdated;
        public event EventHandler<GameEventArgs> GameEvent;
        public Cards Cards { get; } = new();
        public Dictionary<int, Player> Players { get; } = new();
        private History History { get; } = new();
        private Link Link { get; } = new();
        private Player TurnPlayer { get; set; }
        public bool GameOver { get; set; } = false;
        
        public Match(Player player1, Player player2)
        {
            GameEvent += History.OnGameEvent;
            Players[player1.Id] = player1;
            Players[player2.Id] = player2;
            GameOver = false;
            player1.Opponent = player2;
            player2.Opponent = player1;
        }

        private bool Disqualified(bool condition, Player player, Illegal reason)
        {
            if (GameOver) return true;
            player.ReasonPlayerWasDisqualified = reason;
            return condition;
        }
       
        public void Begin(List<Player> players, Enqueue loadDeck = null)
        {
            foreach (Player player in players)
            {
                foreach (string setCode in player.DeckList)
                {
                    Card card = Cards.CreateCard(setCode, player);
                    player.Deck.Add(card);
                }
                
                GameEvent?.Invoke(this, new LoadDeck(player, player.Deck.ToDictionary(card => card.Id, card => card.SetCodes)));
            }
            
            foreach (Player player in players)
            {
                for (int i = 0; i < 7; i++)
                {
                    Card card = player.Deck[player.Deck.Count - 1];
                    player.Deck.Remove(card);
                    player.Hand.Add(card);
                    GameEvent?.Invoke(this, new Draw(card));
                }
            }

            TurnPlayer = players[0];
            TurnPlayer.State = States.IdleTurnPlayer;
            
            Update();
        }
        
        public void Deploy(Player player, Card unit)
        {
            if (Disqualified(unit.CardStates != CardStates.Deploy, player, Illegal.Deploy))
            {
                return;
            }
            player.Hand.Remove(unit);
            player.Units.Add(unit);
            unit.Zone = player.Units;
            GameEvent?.Invoke(this, new Deploy(unit));
            Update();
        }

        public void AttackUnit(Player player, Card attacker, Card defender)
        {
            if (Disqualified(attacker.CardStates != CardStates.AttackUnit, player, Illegal.AttackUnit))
            {
                return;
            }
            GameEvent?.Invoke(this, new AttackUnit(attacker, defender));
            
            // TODO: Make sure this isn't a duplicate list
            void DamageCalculation(Card winner, Card loser)
            {
                loser.Controller.Health -= winner.Power - loser.Power;
                GameEvent?.Invoke(this, new SetHealth(loser.Controller));
                
                loser.Controller.Units.Remove(loser);
                loser.Owner.Graveyard.Add(loser);
                
                GameEvent?.Invoke(this, new SentToGraveyard(loser));
                if (loser.Controller.Health <= 0)
                {
                    GameOver = true;
                    GameEvent?.Invoke(this, new GameOver(loser.Controller));
                }
            }

     
            if (attacker.Power > defender.Power) { DamageCalculation(attacker, defender); }
            else if (defender.Power > attacker.Power) { DamageCalculation(defender, attacker); }
            attacker.IsReady = false;
            
            Update();
        }

        public void AttackPlayer(Player player, Card attacker)
        {
            if (Disqualified(attacker.CardStates != CardStates.AttackPlayer, player, Illegal.AttackPlayer))
            {
                return;
            }
            player.Opponent.Health -= attacker.Power;

            GameEvent?.Invoke(this, new AttackParticipant(attacker));
            GameEvent?.Invoke(this, new SetHealth(player.Opponent));

            if (player.Opponent.Health <= 0)
            {
                player.State = States.Winner;
                player.Opponent.State = States.Loser;
                GameOver = true;
                GameEvent?.Invoke(this, new GameOver(player.Opponent));
            }
            
            attacker.IsReady = false;
            
            Update();
        }

        public void SetFaceDown(Player player, Card support)
        {
            if (Disqualified(support.CardStates != CardStates.SetFaceDown, player, Illegal.SetFaceDown))
            {
                return;
            }
            player.Hand.Remove(support);
            player.Supports.Add(support);
            support.Zone = player.Supports;
            GameEvent?.Invoke(this, new SetFaceDown(support));
            
            Update();
        }

        public void Activate(Player player, Card support)
        {

            if (Disqualified(support.CardStates != CardStates.Activate, player, Illegal.Activation))
            {
                return;
            }
            (GameEventArgs activation, SkillState skillState) = support.Activate();
            GameEvent?.Invoke(this, activation);
            
            // Link is a Zone
            player.Supports.Remove(support);
            
            Link.Add(skillState);
            player.State = States.Acting;
            player.Opponent.State = States.Active;
            
            Update();
        }
        
        public void PassPlay(Player player)
        {
            if (Disqualified(player.State != States.Active, player, Illegal.PassPlay))
            {
                return;
            }
            switch (player.Opponent.State)
            {
                case States.Acting:
                    player.State = States.Passing;
                    player.Opponent.State = States.Active;
                    break;
                case States.Passing:
                {
                    // TODO:
                    // Apply Triggers - When, Where, and how to respond? Maybe Async?
                    // Targeting (Set valid targets beforehand, server only needs to check validity)
                    // Resolve Events (Push Loop Up?)
                    // while(link.resolving) resolve = link.next()
                    // record
                    // queue
                    
                    // Some skills affect game state visually
                    // or rather some OPERATIONS do that so we need a way to return those operations back to the game state
                    // ...we could have the Resolve/Execute() function pass the result of the final method
                    while (Link.IsResolving)
                    {   
                        // Add Resolve first because nothing happens without it
                       // gameEvents.Add(new Resolve(TurnPlayer));
                       // gameEvents.AddRange(Link.Resolve());
                        GameEvent?.Invoke(this, new Resolve(TurnPlayer));
                        foreach (GameEventArgs gameEventArgs in Link.Resolve())
                        {
                            GameEvent?.Invoke(this, gameEventArgs);
                        }
                    }
                
                    TurnPlayer.State = States.IdleTurnPlayer;
                    TurnPlayer.Opponent.State = States.Passive;
                    break;
                }
                default:
                    throw new ArgumentOutOfRangeException();
                
            }
            
            Update();
        }
        
        public void EndTurn(Player player)
        {
            if (Disqualified(player.State != States.IdleTurnPlayer, player, Illegal.EndTurn))
            {
                return;
            }
            
            player.State = States.Passive;
            player.Opponent.State = States.IdleTurnPlayer;
            
            GameEvent?.Invoke(this, new EndTurn(player));
           
            TurnPlayer = TurnPlayer.Opponent;
            TurnPlayer.State = States.IdleTurnPlayer;
            TurnPlayer.Opponent.State = States.Passive;
            
            if (player.Opponent.Deck.Count > 0)
            {
                Card card = player.Opponent.Deck[player.Opponent.Deck.Count - 1];
                player.Opponent.Deck.Remove(card);
                player.Opponent.Hand.Add(card);
                GameEvent?.Invoke(this, new Draw(card));
            }
            else
            {
                player.State = States.Winner;
                player.Opponent.State = States.Loser;
                GameOver = true;
                GameEvent?.Invoke(this, new GameOver(player.Opponent));
            }
            
            foreach (Card card in player.Units) card.IsReady = true;
            foreach (Card card in player.Supports) card.IsReady = true;
            
            Update();
        }

        private void Update()
        {
            foreach (Card card in Cards) { card.Update(); }
            GameUpdated?.Invoke(this, null);
        }

    }
    
    
}