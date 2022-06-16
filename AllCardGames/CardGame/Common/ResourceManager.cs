using Godot.Collections;

namespace CardGame.Common;

public class ResourceManager: Node
{
    [Export] private Array<CardGameResource> Resources { get; set; } = new();

    public override void _Notification(int what)
    {
        if (what is not (NotificationWmQuitRequest or NotificationCrash or NotificationAppPaused)) return;
        foreach (var resource in Resources)
        {
            resource.OnApplicationAboutToClose();
        }
    }
}