using System.Threading.Tasks;

namespace CardGame.Client.Match.Commands
{
	public abstract class Command
	{

		public async Task Execute(IGameBoard board)
		{
			board.Effects.Gfx.RemoveAll();
			Setup(board);
			board.Effects.Gfx.Start();
			await board.Effects.Gfx.ToSignal(board.Effects.Gfx, "tween_all_completed");
		}

		protected abstract void Setup(IGameBoard board);
	}
}
