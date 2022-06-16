using CardGame.Common;
using CardGame.Server.Room;
namespace CardGame.Server;

public class TableFactory: CardGameResource
{
    [Export(PropertyHint.ResourceType)] private PackedScene DefaultTable { get; set; }

    public Node CreateInstance(int p1, int p2)
    {
        var table = DefaultTable.Instance();
        table.Set("Player1", new Player(p1));
        table.Set("Player2", new Player(p2));
        return table;
    }

    public override void OnApplicationAboutToClose()
    {
        /**/
    }
}