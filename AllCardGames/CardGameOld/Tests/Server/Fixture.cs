using System.Collections.Generic;
using System.Linq;

namespace CardGame.Server.Tests
{
    public class Fixture: WAT.Test
    {
        protected Player P1;
        protected Player P2;
        protected Match Match;
        
        protected void StartGame(IEnumerable<string> deckList1 = null, IEnumerable<string> deckList2 = null)
        {
            P1 = new Player(1, deckList1 ?? BuildDeck());
            P2 = new Player(2, deckList2 ?? BuildDeck());
            Match = new Match(P1, P2);
            Match.Begin(new List<Player> {P1, P2});
        }
       
        protected static IEnumerable<string> BuildDeck(string setCode = "Null Card")
        {
            IList<string> deckList = new List<string>();
            for (int i = 0; i < 40; i++) { deckList.Add(setCode); }
            return deckList.AsEnumerable();
        }
        
        protected static Skill BuildSkill(Card support, params object[] codes)
        {
            return new Skill(support, new List<Triggers>(), codes.Select(opCode => (int) opCode).ToList(), "");
        }
    }

    public class MockRoom: Node
    {
        //InputController.Declare += (commandId, args) => { RpcId(1, Enum.GetName(commandId.GetType(), commandId), args); };
        public void Declare(CommandId commandId, params object[] args)
        {
            RpcId(1, Enum.GetName(commandId.GetType(), commandId), args);
        }
    }
}