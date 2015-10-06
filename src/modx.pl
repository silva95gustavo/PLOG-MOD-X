/* Visualization */

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
print_board_line_aux([[B, P] | T], Line) :-
        write(' '),
        print_cell(B, P, Line),
        write(' |'),
        print_board_line_aux(T, Line).
print_board_line_aux([], _).

print_piece(H, H).

print_dashed_line([_ | T]) :-
        write('--------'),
        print_dashed_line(T).
print_dashed_line([]) :- write('-').

piece_to_ascii(-1, ' ').
piece_to_ascii(0, 'X').
piece_to_ascii(1, 'M').
piece_to_ascii(2, 'O').
piece_to_ascii(3, '^').
piece_to_ascii(4, ';').

base_to_ascii(-1, ' ').
base_to_ascii(0, '=').
base_to_ascii(1, 'm').
base_to_ascii(2, '+').
base_to_ascii(3, '~').
base_to_ascii(4, ':').

print_cell(Base, -1, _) :-
        base_to_ascii(Base, B),
        print(B),
        print(B),
        print(B),
        print(B),
        print(B).
print_cell(Base, Piece, 1) :-
        Piece > -1,
        piece_to_ascii(Piece, P),
        base_to_ascii(Base, B),
        print(P),
        print(B),
        print(B),
        print(B),
        print(P).
print_cell(Base, Piece, 2) :-
        Piece > -1,
        piece_to_ascii(Piece, P),
        base_to_ascii(Base, B),
        print(B),
        print(B),
        print(P),
        print(B),
        print(B).
print_cell(Base, Piece, 3) :-
        Piece > -1,
        print_cell(Base, Piece, 1).

/* Test code: print_board([[[-1, -1], [0, -1]], [[-1, 0], [0, 0]]]). */