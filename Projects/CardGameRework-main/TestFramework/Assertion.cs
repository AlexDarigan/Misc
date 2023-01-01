using System.Diagnostics;

namespace CardGame.TestFramework;

public class Assertion: EventArgs
{
    public string TestClass { get; private set; }
    public string TestMethod { get; private set; }
    public string Context { get; private set; }
    public bool Passed { get; private set; }

    public Assertion(bool passed, string context)
    {
        Context = context;
        Passed = passed;
        TestMethod = new StackTrace().GetFrame(2).GetMethod().Name;
        TestClass = new StackTrace().GetFrame(2).GetMethod().DeclaringType?.ToString();
    }
}