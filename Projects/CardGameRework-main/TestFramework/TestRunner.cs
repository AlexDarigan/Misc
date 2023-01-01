using System.Linq;
using System.Reflection;

namespace CardGame.TestFramework;

public class TestRunner : Node
{
    [Export()] private Color FailureColor { get; set; }
    private TestDriver TestDriver { get; set; }
    private int Passed { get; set; }
    private int Failed { get; set; }
    
    public override async void _Ready()
    {
        TestDriver = GetNode<TestDriver>("TestDriver");
        var start = Time.GetTicksMsec();
        GD.Print("Begin Test Run");
        Asserts.Assertion += OnAssertion;
        var types = Assembly.GetExecutingAssembly().GetTypes().Where(t => t.IsDefined(typeof(TestClassAttribute)));
        foreach (var type in types)
        {
            await TestDriver.Drive(Activator.CreateInstance(type));
        }

        var time = Time.GetTicksMsec() - start;
        GD.Print($"Time: {time} mSecs");
        GD.Print($"Time: {time / 1000} seconds~");
        GD.Print($"{Failed} of {Passed + Failed} Assertions Failed");
        GD.Print("End Test Run");
        GetTree().Quit(Math.Min(1, Failed)); // 1 if Failed, otherwise Failed is 0 which is "Ok"
    }

    private void OnAssertion(Assertion assertion)
    {
        if (assertion.Passed)
        {
            Passed++;
        }
        else
        {
            Failed++;
            GD.Print($"{assertion.TestClass}.{assertion.TestMethod}");
            GD.PushWarning(assertion.Context);
        }
    }

}