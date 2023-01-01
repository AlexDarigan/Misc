using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using System.Threading.Tasks;

namespace CardGame.TestFramework;

public class TestDriver : Node
{

    public async Task Drive(object test)
    {
        if (test is Node preTestNode) { AddChild(preTestNode); }
        await Run(test);
        if (test is Node postTestNode)
        {
            RemoveChild(postTestNode);
            postTestNode.QueueFree();
        }
    }

    private static async Task Run(object test)
    {

        await CallHook<StartAttribute>(test);
        foreach (var method in GetMethods(test))
        {
            await CallHook<PreAttribute>(test);
            await method();
            await CallHook<PostAttribute>(test);
        }

        await CallHook<EndAttribute>(test);
    }

    private static async Task CallHook<T>(object test)
    {
        var hook = test.GetType().GetMethods().FirstOrDefault(m => m.IsDefined(typeof(T)));
        if (hook?.Invoke(test, null) is Task task) { await task; }else { await Task.CompletedTask; }
    }

    private static List<Func<Task>> GetMethods(object test)
    {
        return (
            from method in test.GetType().GetMethods().Where(m => m.IsDefined(typeof(TestMethodAttribute)))
            from attr in method.GetCustomAttributes().OfType<TestMethodAttribute>() 
            select (Func<Task>)(async () => { await CallTest(test, method, attr); })).ToList();
    }

    private static async Task CallTest(object test, MethodBase method, TestMethodAttribute attr)
    {
        if (method.Invoke(test, attr.Arguments) is Task task) { await task; } else { await Task.CompletedTask; }
    }
}