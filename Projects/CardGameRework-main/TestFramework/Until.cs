using System;
using System.Linq;
using System.Threading.Tasks;
using Godot;

namespace ProjectCubed.TestFramework;

public static class Until
{
    public static Task Timeout(int mSec)
    {
        return Task.Delay(mSec);
    }

    private static async Task<TestEventData> Event(object instance, string eventName, int mSec, Type[] types)
    {
        var eventData = new TestEventData();
        var eventInfo = instance.GetType().GetEvent(eventName);
        var methodInfo = eventData.GetType().GetMethod(nameof(TestEventData.OnEventRaised), types);
        var handler = Delegate.CreateDelegate(eventInfo.EventHandlerType, eventData, methodInfo!);
        eventInfo.AddEventHandler(instance, handler); // What?
        await Task.WhenAny(eventData.GetData(), Task.Delay(mSec));
        eventData.Cancel();
        eventInfo.RemoveEventHandler(instance, handler);
        return eventData;
    }
        
    public static async Task Event(object instance, string eventName, int mSec)
    {
        await Event(instance, eventName, mSec, Type.EmptyTypes);
    }
        
    public static async Task<TestEventData> Event<T>(object instance, string eventName, int mSec)
    {
        return await Event(instance, eventName, mSec, new[] { typeof(T) });
    }
        
    public static async Task<TestEventData> Event<T, U>(object instance, string eventName, int mSec)
    {
        return await Event(instance, eventName, mSec, new[] { typeof(T), typeof(U) });
    }
        
    public static async Task<TestEventData> Event<T, U, V>(object instance, string eventName, int mSec)
    {
        return await Event(instance, eventName, mSec, new[] { typeof(T), typeof(U), typeof(V) });
    }
        
    public static async Task<TestEventData> Event<T, U, V, W>(object instance, string eventName, int mSec)
    {
        return await Event(instance, eventName, mSec, new[] { typeof(T), typeof(U), typeof(V), typeof(W) });
    }
        
    public static async Task<TestEventData> Event<T, U, V, W, Y>(object instance, string eventName, int mSec)
    {
        return await Event(instance, eventName, mSec, new[] { typeof(T), typeof(U), typeof(V), typeof(W), typeof(Y) });
    }
        
    public static async Task<TestEventData> Event<T, U, V, W, Y, X>(object instance, string eventName, int mSec)
    {
        return await Event(instance, eventName, mSec, new[] { typeof(T), typeof(U), typeof(V), typeof(W), typeof(Y), typeof(X) });
    }
        
    public static async Task<TestEventData> Event<T, U, V, W, Y, X, Z>(object instance, string eventName, int mSec)
    {
        return await Event(instance, eventName, mSec, new[] { typeof(T), typeof(U), typeof(V), typeof(W), typeof(Y), typeof(X), typeof(Z)});
    }
        
    public class TestEventData
    {
        public object[] Arguments { get; private set; } = null;
        private bool EventWasRaised { get; set; }
        private bool Cancelled { get; set; } = false;
            
        public async Task GetData()
        {
            while (!EventWasRaised && !Cancelled) { await Task.Delay(1); }
            await Task.CompletedTask;
        }

        public void Cancel() { Cancelled = true; }

        private void EventRaised(params object[] args)
        {
            Arguments = args;
            EventWasRaised = true;
        }
            
        public void OnEventRaised() { EventRaised(); }
        public void OnEventRaised(object t)
        {
            EventRaised(t);
        }

        public void OnEventRaised(object t, object u)
        {
            EventRaised(t, u);
        }

        public void OnEventRaised(object t, object u, object v)
        {
            EventRaised(t, u, v);
        }

        public void OnEventRaised(object t, object u, object v, object w)
        {
            EventRaised(t, u, v, w);
        }

        public void OnEventRaised(object t, object u, object v, object w, object x)
        {
            EventRaised(t, u, v, w, x);
        }

        public void OnEventRaised(object t, object u, object v, object w, object x, object y)
        {
            EventRaised(t, u, v, w, x, y);
        }

        public void OnEventRaised(object t, object u, object v, object w, object x, object y, object z)
        {
            EventRaised(t, u, v, w, x, y, z);
        }
    }
}