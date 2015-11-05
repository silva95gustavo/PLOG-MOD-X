% Cell

cell_spieces([Ss, _], Ss).
cell_xpiece([_, X], X).
cell_top_spiece(Cell, S) :- 
        cell_spieces(Cell, []),
        S = -1.
cell_top_spiece(Cell, S) :-
        cell_spieces(Cell, [S | _]).
cell_convert_xpiece_to_spiece([Ss, X], [[X | Ss], -1]) :- X \= -1.