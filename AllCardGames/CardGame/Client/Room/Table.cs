using CardGame.Client.UserData;

namespace CardGame.Client.Room;

public class Table: Node
{
    [Export(PropertyHint.ResourceType)] public User User { get; set; }
    private const int Server = 1;
    public override void _Ready()
    {
        GD.Print($"{CustomMultiplayer.GetNetworkUniqueId()} is sitting at table {Name}");
        RpcId(Server, "OnPlayerSeated", User.CurrentDeck.Deck);
    }
}