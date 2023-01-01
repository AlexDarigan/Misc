using CardGame.Server.Game.States;
using CardGame.TestFramework;

namespace CardGame.Tests;

[TestClass]
public class StateMachineTests: Fixture
{
    public StateMachineTests() {}

    [Post] public void CleanUp() { EndGame(); }

    // TODO:
    // Battle Tests
    // Resolve Tests
    // Acting Player Tests
    
    [TestMethod]
    public void GameIsIdleOnStart()
    {
        // Idle -> StartGame() -> Idle
        StartGame();
        Asserts.IsTrue(Match.StateMachine.Current is Idle, "Game State is Idle On Start");
    }

    [TestMethod]
    public void GameIsIdleOnEndTurn()
    {
        // Idle -> EndTurn() -> Idle
        StartGame();
        Match.PassPlay(P1.Id);
        Asserts.IsTrue(Match.StateMachine.Current is Idle, "Game State is Idle On End Turn");
    }

    [TestMethod]
    public void GameIsIdleOnDeploy()
    {
        // Idle -> Deploy() -> Idle
        StartGame(BuildDeck("BasicUnit"), BuildDeck("BasicUnit"));
        Match.Deploy(P1.Id, P1.Hand[0].Id);
        Asserts.IsTrue(Match.StateMachine.Current is Idle, "Game State is Idle on Deploy Unit");
    }

    [TestMethod]
    public void GameIsIdleOnSetFaceDown()
    {
        // Idle -> Set() -> Idle
        StartGame(BuildDeck("BasicSupport"), BuildDeck("BasicSupport"));
        Asserts.IsTrue(Match.StateMachine.Current is Idle, "Game State is Idle On Set FaceDown");
    }

    [TestMethod]
    public void GameIsResponseOnActivateFaceDown()
    {
        // Idle -> Set() -> Idle -> EndTurn() -> Idle -> EndTurn() -> Idle -> Activate() -> Response
        StartGame(BuildDeck("BasicSupport"), BuildDeck("BasicSupport"));
        var card = P1.Hand[0];
        Match.SetFaceDown(P1.Id, card.Id);
        Match.PassPlay(P1.Id);
        Match.PassPlay(P2.Id);
        Match.Activate(P1.Id, card.Id);
        Asserts.IsTrue(Match.StateMachine.Current is Response, "Game State is Response on Card Activated");
    }

    [TestMethod]
    public void GameIsActOnPass()
    {
        // Idle -> Set() -> Idle -> EndTurn() -> Idle -> EndTurn() -> Idle -> Activate() -> Response -> Pass() -> Act
        StartGame(BuildDeck("BasicSupport"), BuildDeck("BasicSupport"));
        var card = P1.Hand[0];
        Match.SetFaceDown(P1.Id, card.Id);
        Match.PassPlay(P1.Id);
        Match.PassPlay(P2.Id);
        Match.Activate(P1.Id, card.Id);
        Match.PassPlay(P2.Id);
        Asserts.IsTrue(Match.StateMachine.Current is Act, "Game State is Act on Pass");
    }
    
    [TestMethod]
    public void GameIsIdleOnResolve()
    {   
        // Idle->Act->Response->Pass->Pass->Idle (Idle, effects resolved)
        StartGame(BuildDeck("BasicSupport"), BuildDeck("BasicSupport"));
        var card = P1.Hand[0];
        Match.SetFaceDown(P1.Id, card.Id);
        Match.PassPlay(P1.Id);
        Match.PassPlay(P2.Id);
        Match.Activate(P1.Id, card.Id);
        Match.PassPlay(P2.Id);
        Match.PassPlay(P1.Id);
        Asserts.IsTrue(Match.StateMachine.Current is Idle, "Game State is Idle after second pass");
    }



}