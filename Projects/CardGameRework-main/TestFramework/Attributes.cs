namespace CardGame.TestFramework;

[AttributeUsage(AttributeTargets.Class)]
public class TestClassAttribute : System.Attribute
{
        
}

[AttributeUsage(AttributeTargets.Method, AllowMultiple = true)]
public class TestMethodAttribute : System.Attribute
{
    public object[] Arguments { get; private set; }

    public TestMethodAttribute()
    {
        Arguments = Array.Empty<object>();
    }

    public TestMethodAttribute(params object[] arguments)
    {
        Arguments = arguments;
    }
}
    
[AttributeUsage(AttributeTargets.Method)]
public class StartAttribute: System.Attribute { }
    
[AttributeUsage(AttributeTargets.Method)]
public class PreAttribute: System.Attribute { }
    
[AttributeUsage(AttributeTargets.Method)]
public class PostAttribute: System.Attribute { }
    
[AttributeUsage(AttributeTargets.Method)]
public class EndAttribute: System.Attribute { }