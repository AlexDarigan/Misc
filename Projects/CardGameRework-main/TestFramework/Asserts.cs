namespace CardGame.TestFramework;

public static class Asserts
{
    public static event Action<Assertion> Assertion;
        
    public static void IsTrue(bool condition, string context)
    {
        Assertion?.Invoke(new Assertion(condition, context));
    }
}