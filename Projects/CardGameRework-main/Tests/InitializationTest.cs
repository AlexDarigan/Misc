using CardGame.TestFramework;

namespace CardGame.Tests;

[TestClass]
public partial class InitializationTest: Fixture
{
    [Pre] public void Setup() { StartGame(); }
    [Post] public void CleanUp() { EndGame(); }
    
    [TestMethod]
    public void DeckSizeIsCorrect()
    {
        Asserts.IsTrue(P1.Deck.Count == 33, "Player 1 loaded a deck of 33 cards");
        Asserts.IsTrue(P2.Deck.Count == 33, "Player 2 loaded a deck of 33 cards");
    }
    
    [TestMethod]
    public void HandSizeIsCorrect()
    {
        Asserts.IsTrue(P1.Hand.Count == 7, "Player 1 drew 7 Cards");
        Asserts.IsTrue(P2.Hand.Count == 7, "Player 2 drew 7 Cards");
    }
    
    [TestMethod]
    public void DeckContentsIsCorrect()
    {
        Asserts.IsTrue(P1.Deck[0].Title == "Null Card", "Player 1 loaded a deck of 'Null Card'");
        Asserts.IsTrue(P2.Deck[0].Title == "Null Card", "Player 2 loaded a deck of 'Null Card'");
    }
    
    [TestMethod]
    public void OwnershipIsCorrect()
    {
        Asserts.IsTrue(P1.Deck[0].Owner == P1, "Player 1 owns the cards in their deck");
        Asserts.IsTrue(P2.Deck[0].Owner == P2, "Player 2 owns the cards in their deck");
    }
}