using CardGame.Client.Resources;

namespace CardGame.Client.Screens
{
    public interface IScreen
    {
        User User { get; set; }
        void Display();
        void StopDisplaying();
    }
}

