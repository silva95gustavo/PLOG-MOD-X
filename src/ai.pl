ai_evaluate_and_choose([Move | Moves], MovePred, ValuePred, Game, BestMove) :-
        ai_evaluate_and_choose_aux([Move | Moves], MovePred, ValuePred, Game, [0, -99999], BestMove).

ai_evaluate_and_choose_aux([Move | Moves], MovePred, ValuePred, Game, Record, BestMove) :-
        M =.. [MovePred, Game, Move, NewGame],
        M,
        V =.. [ValuePred, NewGame, Value],
        V,
        ai_update(Move, Value, Record, [BestMove, BestValue]),
        ai_evaluate_and_choose_aux(Moves, MovePred, ValuePred, NewGame, [BestMove, BestValue], BestMove).
ai_evaluate_and_choose_aux([], _, _, _, _, _).

ai_update(_, Value, [Move1, Value1], [Move1, Value1]) :- Value =< Value1, !.
ai_update(Move, Value, [_, _], [Move, Value]).