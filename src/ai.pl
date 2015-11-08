ai_evaluate_and_choose([Move | Moves], MovePred, ValuePred, Game, BestMove) :-
        ai_evaluate_and_choose_aux([Move | Moves], MovePred, ValuePred, Game, [[0, 0], -99999], [BestMoves, _]),
        random_member(BestMove, BestMoves).
        

ai_evaluate_and_choose_aux([Move | Moves], MovePred, ValuePred, Game, Record, BestMoves) :-
        M =.. [MovePred, Game, Move, NewGame],
        M,
        V =.. [ValuePred, NewGame, Value],
        V,
        ai_update(Move, Value, Record, BestMoves1),
        ai_evaluate_and_choose_aux(Moves, MovePred, ValuePred, NewGame, BestMoves1, BestMoves).
ai_evaluate_and_choose_aux([], _, _, _, BestMoves, BestMoves).

ai_update(_, Value, [Moves, Value1], [Moves, Value1]) :- Value < Value1, !.
ai_update(Move, Value, [Moves, Value], [[Move | Moves], Value]) :- !.
ai_update(Move, Value, [_, _], [[Move], Value]).