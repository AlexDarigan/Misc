using System.Collections;
using System.Collections.Generic;
using CardGame.Server.Events;

namespace CardGame.Server
{
    public class History: IEnumerable<GameEventArgs>
    {
        private readonly List<GameEventArgs> _gameEvents = new();

        public void OnGameEvent(object sender, GameEventArgs gameGameEventArgs)
        {
            _gameEvents.Add(gameGameEventArgs);
        }
        
        public IEnumerator<GameEventArgs> GetEnumerator() { return _gameEvents.GetEnumerator(); }
        IEnumerator IEnumerable.GetEnumerator() { return GetEnumerator(); }
    }
}