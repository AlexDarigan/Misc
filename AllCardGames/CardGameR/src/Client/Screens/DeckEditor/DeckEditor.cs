namespace Client.Screens
{
    public class DeckEditor : Control, IScreen
    {
        private DeckEditor() { /* Godot Engine Reflection */ }
        public void Display() { Show(); }
        public void StopDisplaying() { Hide(); }
    }
}