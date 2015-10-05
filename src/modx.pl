/* Print */

print_board([H | T]) :-
        print_dashed_line(H), nl,
        print_board_content([H | T]).

print_board_content([H | T]) :-
        print_board_line(H), nl,
        print_dashed_line(H), nl,
        print_board_content(T).
print_board_content([]).

print_board_line([H | T]) :-
        write('|'),
        print_board_line_aux([H | T]).
print_board_line_aux([H | T]) :-
        print_piece(H, X),
        write(' '),
        write(X),
        write(' |'),
        print_board_line_aux(T).
print_board_line_aux([]).

print_piece(H, H).

print_dashed_line([_ | T]) :-
        write('----'),
        print_dashed_line(T).
print_dashed_line([]) :- write('-').