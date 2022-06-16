using System.Collections;

namespace CardGame.Client.Match.Commands
{
    public class UpdateCards: Command
    {
        private IEnumerable Cards { get; }

        public UpdateCards(IEnumerable cards) { Cards = cards; }
        
        protected override void Setup(IGameBoard room)
        {
            foreach (DictionaryEntry pair in Cards) 
            { room.Cards[(int) pair.Key].State = (CardStates) pair.Value; }
        }
    }
}