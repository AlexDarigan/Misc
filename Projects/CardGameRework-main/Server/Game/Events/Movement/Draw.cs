﻿using System;
using CardGame.Common.Constants;
using CardGame.Server.Game;

namespace CardGame.Server.Events;

public class Draw : MoveGameEventArgs
{
    public Draw(Card card) : base(card) { }

    public override void QueueOnClients(Enqueue queue)
    {
        queue(Controller.Id, CommandId.PlayerDraw, Card.Id);
        queue(Controller.Opponent.Id, CommandId.RivalDraw);
    }
}