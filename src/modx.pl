/* Modules*/

:- use_module(library(random)).
:- use_module(library(lists)).


/* Constants */

board_size(8).
num_xpieces(14).
num_markers(18).

% Game

game_board(Game, Board) :- nth0(0, Game, Board).

game_player(Game, Player) :- nth0(1, Game, Player).

% Board

board_xy(Board, [X, Y], Cell) :-
        nth0(Y, Board, Line),
        nth0(X, Line, Cell).

create_board(Board) :-
        board_size(Size),
        create_board(Size, Board).
create_board(Size, Board) :- create_board(Size, Size, Board).               
create_board(Width, Height, Board) :-
        Height > 0,
        H1 is Height - 1,
        create_board_line(Width, L1),
        create_board(Width, H1, B1),
        append([L1], B1, Board).
create_board(_, 0, []).
create_board_line(Width, Line) :-
        Width > 0,
        W1 is Width - 1,
        create_board_line(W1, L1),
        append([[[], -1]], L1, Line).
create_board_line(0, []).

% Cell

cell_spieces([Ss, _], Ss).
cell_xpiece([_, X], X).
cell_top_spiece(Cell, S) :- 
        cell_spieces(Cell, []),
        S = -1.
cell_top_spiece(Cell, S) :-
        cell_spieces(Cell, [S | _]).
        
        
% Plays

place_xpiece(Game, [X, Y], New_game). % TODO!!! deve também apagar os jokers a ser movidos

place_joker(Game, [X, Y], New_game). % TODO!!!

        
% Visualization

print_board([H | T]) :-
        print_dashed_line(H), nl,
        print_board_content([H | T]).

print_board_content([H | T]) :-
        print_board_row(H), nl,
        print_dashed_line(H), nl,
        print_board_content(T).
print_board_content([]).

print_board_row([H | T]) :-
        write('|'), print_board_line_aux([H | T], 1), nl,
        write('|'), print_board_line_aux([H | T], 2), nl,
        write('|'), print_board_line_aux([H | T], 3).
print_board_line_aux([Cell | T], Line) :-
        write(' '),
        cell_top_spiece(Cell, B),
        cell_xpiece(Cell, P),
        print_cell(B, P, Line),
        write(' |'),
        print_board_line_aux(T, Line).
print_board_line_aux([], _).

print_dashed_line([_ | T]) :-
        write('--------'),
        print_dashed_line(T).
print_dashed_line([]) :- write('-').

xpiece_to_ascii(-1, ' ').
xpiece_to_ascii(0, 'X').
xpiece_to_ascii(1, 'R').
xpiece_to_ascii(2, 'G').

marker_to_ascii(-1, ' ').
marker_to_ascii(1, 'r').
marker_to_ascii(2, 'g').

print_cell(Marker, -1, _) :-
        marker_to_ascii(Marker, M),
        print(M),
        print(M),
        print(M),
        print(M),
        print(M).
print_cell(Marker, Xpiece, 1) :-
        Xpiece > -1,
        xpiece_to_ascii(Xpiece, X),
        marker_to_ascii(Marker, M),
        print(X),
        print(M),
        print(M),
        print(M),
        print(X).
print_cell(Marker, Xpiece, 2) :-
        Xpiece > -1,
        xpiece_to_ascii(Xpiece, X),
        marker_to_ascii(Marker, M),
        print(M),
        print(M),
        print(X),
        print(M),
        print(M).
print_cell(Marker, Xpiece, 3) :-
        Xpiece > -1,
        print_cell(Marker, Xpiece, 1).

% Test code by calling test(x) - x can be any atom or variable
test(_) :-
        create_board(B),
        print_board(B).

test_displ(_) :-
        print_board([[[[], -1], [[], -1],       [[], -1],       [[], -1],       [[], 0],        [[], -1],       [[], -1],       [[], -1]],
                     [[[], -1], [[], -1],       [[], -1],       [[], -1],       [[], -1],       [[], -1],       [[], -1],       [[], -1]],
                     [[[], -1], [[], -1],       [[], -1],       [[], -1],       [[], 0],        [[], -1],       [[], 0],        [[], -1]],
                     [[[], -1], [[], -1],       [[], -1],       [[1], -1],      [[], -1],       [[], -1],       [[], -1],       [[], -1]],
                     [[[], -1], [[], -1],       [[], -1],       [[], -1],       [[1], -1],      [[2], -1],      [[], -1],       [[2], -1]],
                     [[[], -1], [[], -1],       [[2], -1],      [[2], -1],      [[2], -1],      [[2], -1],      [[2], -1],      [[], -1]],
                     [[[], 2],  [[], 0],        [[], 1],        [[], 1],        [[], 0],        [[2], 1],       [[], 1],        [[2], -1]],
                     [[[], -1], [[], -1],       [[], -1],       [[], -1],       [[], -1],       [[], -1],       [[], 1],        [[], -1]]]).


