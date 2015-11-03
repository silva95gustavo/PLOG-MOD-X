% Modules

:- use_module(library(random)).
:- use_module(library(lists)).
:- use_module(library(system)).
:- now(Timestamp),
   setrand(Timestamp).


% Constants

board_size(8).
num_xpieces(14).
num_markers(18).
num_jokers(5).

% Menus

show_intro :-
        nl, nl,
        write('        |/$$      /$$  /$$$$$$  /$$$$$$$        /$$   /$$        '), nl,
        write('        | $$$    /$$$ /$$__  $$| $$__  $$      | $$  / $$        '), nl,
        write('        | $$$$  /$$$$| $$  \\ $$| $$  \\ $$      |  $$/ $$/        '), nl,
        write('        | $$ $$/$$ $$| $$  | $$| $$  | $$       \\  $$$$/         '), nl,
        write('        | $$  $$$| $$| $$  | $$| $$  | $$        >$$  $$         '), nl,
        write('        | $$\\  $ | $$| $$  | $$| $$  | $$       /$$/\\  $$        '), nl,
        write('        | $$ \\/  | $$|  $$$$$$/| $$$$$$$/      | $$  \\ $$        '), nl,
        write('        |__/     |__/ \\______/ |_______/       |__/  |__/        '), nl,
        nl, nl,
        write('                         Press enter to play                      '), nl,
        nl,
        get_char(_),
        show_main_menu.
        
show_main_menu :-
        write('1. Player vs Bot'), nl,
        write('2. 2 Players'), nl,
        write('3. Bot vs Bot'), nl,
        write('0. Exit'), nl.

% Utils

member_list_chk([], _).
member_list_chk([H | T], List2) :-
        memberchk(H, List2),
        member_list_chk(T, List2).

replace(N, X, L1, L2) :-
        length(L3, N),
        append(L3, [_ | T], L1),
        append(L3, [X | T], L2).

inc(X, X1) :- X1 is X + 1.
dec(X, X1) :- X1 is X - 1.
        

% CLI

cli_get_char(C) :-
        get_char(C),
        get_char(_).

% Game

start_game(Game) :-
        game_board(Game, Board),
        create_board(Board),
        game_player(Game, 1),
        player_info_score(Player_info, 0),
        num_xpieces(N),
        player_info_num_xpieces(Player_info, N),
        game_player_info(Game, 0, Player_info),
        game_player_info(Game, 1, Player_info).

game_board(Game, Board) :- nth0(0, Game, Board).
game_player(Game, Player) :- nth0(1, Game, Player).
game_player_info(Game, Player, Player_info) :-
        nth0(P2, Game, Player_info),
        Player is P2 - 2.

game_set_board(Game, Board, New_game) :- replace(0, Board, Game, New_game).
game_next_player(Game, New_game) :-
        game_player(Game, Player),
        next_player(Player, New_player),
        replace(1, New_player, Game, New_game).
game_inc_player_score(Game, Player, New_game) :-
        game_player_info(Game, Player, Player_info1),
        player_info_num_xpieces(Player_info1, Score), write('call 1'),
        inc(Score, Score1), write('Score1: '), write(Score1),
        player_info_set_score(Player_info1, Score1, Player_info),
        P2 is Player + 2,
        replace(P2, Player_info, Game, New_game).
game_dec_player_score(Game, Player, New_game) :-
        game_player_info(Game, Player, Player_info1),
        player_info_num_xpieces(Player_info1, Score),
        dec(Score, Score1),
        player_info_set_score(Player_info1, Score1, Player_info),
        P2 is Player + 2,
        replace(P2, Player_info, Game, New_game).
game_inc_player_num_xpieces(Game, Player, New_game) :-
        game_player_info(Game, Player, Player_info1),
        player_info_num_xpieces(Player_info1, Num_xpieces),
        inc(Num_xpieces, Num_xpieces1),
        player_info_set_score(Player_info1, Num_xpieces1, Player_info),
        P2 is Player + 2,
        replace(P2, Player_info, Game, New_game).
game_dec_player_num_xpieces(Game, Player, New_game) :-
        game_player_info(Game, Player, Player_info1),write('Player_info1: '), write(Player_info1),
        player_info_num_xpieces(Player_info1, Num_xpieces), write('Num_xpieces: '), write(Num_xpieces), write('call 2'),
        dec(Num_xpieces, Num_xpieces1), write('Num_xpieces1: '), write(Num_xpieces1),
        player_info_set_score(Player_info1, Num_xpieces1, Player_info),
        P2 is Player + 2,
        replace(P2, Player_info, Game, New_game).
                
player_info_score([Score, _], Score).
player_info_num_xpieces([_, Num_xpieces], Num_xpieces).
player_info_set_score(Player_info, Score, New_player_info) :- replace(0, Score, Player_info, New_player_info).
player_info_set_num_xpieces(Player_info, Num_xpieces, New_player_info) :- replace(1, Num_xpieces, Player_info, New_player_info).

next_player(1, 2).
next_player(2, 1).

check_patterns(Game, New_scores) :-
        check_patterns_aux(Game, [0, 0], [], New_scores).
check_patterns_aux(Game, [X, Y], Scores, Scores) :-
        game_board(Game, Board),
        \+ board_xy(Board, [X, Y], _).
check_patterns_aux(Game, [X, Y], Scores, New_scores) :-
        game_board(Game, Board),
        board_xy(Board, [X, Y], _),
        check_patterns_aux_aux(Game, [X, Y], Scores, New_scores1),
        Y1 is Y + 1,
        check_patterns_aux(Game, [X, Y1], New_scores1, New_scores).
check_patterns_aux_aux(Game, [X, Y], Scores, Scores) :-
        game_board(Game, Board),
        \+ board_xy(Board, [X, Y], _).
check_patterns_aux_aux(Game, [X, Y], Scores, New_scores) :-
        game_board(Game, Board),
        board_xy(Board, [X, Y], _),
        check_pattern_x(Game, [X, Y], Scores, S1),
        check_pattern_plus(Game, [X, Y], S1, S2),
        check_pattern_5inarow(Game, [X, Y], S2, S3),
        X1 is X + 1,
        check_patterns_aux_aux(Game, [X1, Y], S3, New_scores).

check_pattern_x(Game, [X, Y], Scores, New_scores) :-
        Xm1 is X - 1,
        Xp1 is X + 1,
        Ym1 is Y - 1,
        Yp1 is Y + 1,
        check_pattern(Game, [[Xm1, Ym1], [Xp1, Ym1], [X, Y], [Xm1, Yp1], [Xp1, Yp1]], Scores, New_scores).

check_pattern_plus(Game, [X, Y], Scores, New_scores) :-
        Xm1 is X - 1,
        Xp1 is X + 1,
        Ym1 is Y - 1,
        Yp1 is Y + 1,
        check_pattern(Game, [[Xm1, Y], [Xp1, Y], [X, Y], [X, Ym1], [X, Yp1]], Scores, New_scores).

check_pattern_5inarow(Game, [X, Y], Scores, New_scores) :-
        check_pattern_5inarow_hor(Game, [X, Y], Scores, S1),
        check_pattern_5inarow_vert(Game, [X, Y], S1, S2),
        check_pattern_5inarow_diag1(Game, [X, Y], S2, S3),
        check_pattern_5inarow_diag2(Game, [X, Y], S3, New_scores).

check_pattern_5inarow_hor(Game, [X, Y], Scores, New_scores) :-
        Xm1 is X - 1,
        Xm2 is X - 2,
        Xp1 is X + 1,
        Xp2 is X + 2,
        check_pattern(Game, [[Xm2, Y], [Xm1, Y], [X, Y], [Xp1, Y], [Xp2, Y]], Scores, New_scores).

check_pattern_5inarow_vert(Game, [X, Y], Scores, New_scores) :-
        Ym1 is Y - 1,
        Ym2 is Y - 2,
        Yp1 is Y + 1,
        Yp2 is Y + 2,
        check_pattern(Game, [[X, Ym2], [X, Ym1], [X, Y], [X, Yp1], [X, Yp2]], Scores, New_scores).

check_pattern_5inarow_diag1(Game, [X, Y], Scores, New_scores) :-
        Xm1 is X - 1,
        Xm2 is X - 2,
        Xp1 is X + 1,
        Xp2 is X + 2,
        Ym1 is Y - 1,
        Ym2 is Y - 2,
        Yp1 is Y + 1,
        Yp2 is Y + 2,
        check_pattern(Game, [[Xm2, Ym2], [Xm1, Ym1], [X, Y], [Xp1, Yp1], [Xp2, Yp2]], Scores, New_scores).

check_pattern_5inarow_diag2(Game, [X, Y], Scores, New_scores) :-
        Xm1 is X - 1,
        Xm2 is X - 2,
        Xp1 is X + 1,
        Xp2 is X + 2,
        Ym1 is Y - 1,
        Ym2 is Y - 2,
        Yp1 is Y + 1,
        Yp2 is Y + 2,
        check_pattern(Game, [[Xp2, Ym2], [Xp1, Ym1], [X, Y], [Xm1, Yp1], [Xm2, Yp2]], Scores, New_scores).

check_pattern(Game, Coords_list, Scores, New_scores) :-
        check_pattern_aux(Game, Coords_list), !,
        \+ member_list_chk(Coords_list, Scores),
        append(Scores, Coords_list, New_scores1),
        remove_dups(New_scores1, New_scores).
check_pattern(_, _, Scores, Scores).

check_pattern_aux(_, []).
check_pattern_aux(Game, [[X, Y] | T]) :-
        game_board(Game, Board),
        board_xy(Board, [X, Y], Cell),
        check_pattern_valid_cell(Game, Cell),
        check_pattern_aux(Game, T).

check_pattern_valid_cell(Game, Cell) :-
        game_player(Game, Player),
        cell_xpiece(Cell, Player).
check_pattern_valid_cell(_, Cell) :-
        cell_xpiece(Cell, 0). % Joker

convert_patterns_to_score(Game, [], Game).
convert_patterns_to_score(Game, [Coords | T], New_game) :-
        convert_pattern_to_score(Game, Coords, Game1),
        convert_patterns_to_score(Game1, T, New_game).

convert_pattern_to_score(Game, [], Game) :- !.
convert_pattern_to_score(Game, Coords, New_game) :-
        game_board(Game, Board),
        game_player(Game, Player),
        board_xy(Board, Coords, Cell),
        cell_convert_xpiece_to_spiece(Cell, Cell1),
        board_set_cell(Board, Coords, Cell1, Board1),
        game_set_board(Game, Board1, Game1),
        game_dec_player_num_xpieces(Game1, Player, Game2),
        game_inc_player_score(Game2, Player, New_game).

print_game(Game) :-
        game_board(Game, Board),
        print_board(Board).

% Board

board_xy(Board, [X, Y], Cell) :-
        nth0(Y, Board, Line),
        nth0(X, Line, Cell).

num_jokers_to_place(Board, N) :-
        num_jokers(J),
        count_xpieces(0, Board, N1),
        N is J - N1.

create_board(Board) :-
        board_size(Size),
        create_board(Size, Board1),
        create_board_place_jokers(Board1, Board).
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

create_board_place_jokers(Board, New_board) :-
        num_jokers(N),
        board_get_size(Board, Width, Height),
        Total is Width * Height,
        create_board_place_jokers_aux(Board, New_board, N, Width, Total).
create_board_place_jokers_aux(Board, Board, 0, _, _) :- !.
create_board_place_jokers_aux(Board, New_board, N, Width, Total) :-
        board_random_coords(Board, Coords),
        board_xy(Board, Coords, Cell),
        cell_xpiece(Cell, -1), !,
        cell_spieces(Cell, Spieces),
        cell_spieces(New_cell, Spieces),
        cell_xpiece(New_cell, 0),
        board_set_cell(Board, Coords, New_cell, Board1),
        N1 is N - 1,
        create_board_place_jokers_aux(Board1, New_board, N1, Width, Total).

create_board_place_jokers_aux(Board, New_board, N, Width, Total) :- create_board_place_jokers_aux(Board, New_board, N, Width, Total).
        
board_random_coords(Board, [X, Y]) :-
        board_get_size(Board, Width, Height),
        Total_size is Width * Height,
        random(0, Total_size, R),
        Div is R div Width,
        Mod is R mod Width,
        X = Div,
        Y = Mod.
        
board_set_cell(Board, [X, Y], Cell, New_board) :-
        nth0(Y, Board, Line),
        replace(X, Cell, Line, New_line),
        replace(Y, New_line, Board, New_board).

board_get_size([H | T], Width, Height) :-
        length([H | T], Height),
        length(H, Width).

% Cell

cell_spieces([Ss, _], Ss).
cell_xpiece([_, X], X).
cell_top_spiece(Cell, S) :- 
        cell_spieces(Cell, []),
        S = -1.
cell_top_spiece(Cell, S) :-
        cell_spieces(Cell, [S | _]).
cell_convert_xpiece_to_spiece([Ss, X], [[X | Ss], -1]) :- X \= -1.
        
        
% Main

count_xpieces_line(_, [], 0).
count_xpieces_line(Xpiece, [Cell | T], N) :-
        cell_xpiece(Cell, Xpiece),
        count_xpieces_line(Xpiece, T, N1),
        N is N1 + 1.
count_xpieces_line(Xpiece, [Cell | T], N) :-
        cell_xpiece(Cell, X2),
        Xpiece \= X2,
        count_xpieces_line(Xpiece, T, N).
count_xpieces(_, [], 0).
count_xpieces(Xpiece, [Line | T], N) :-
        count_xpieces_line(Xpiece, Line, N1),
        count_xpieces(Xpiece, T, N2),
        N is N1 + N2.

play :-
        start_game(Game),
        show_main_menu,
        play(Game).

play(Game) :-
        print_game(Game),
        make_play(Game, Game1),
        end_play(Game1, New_game),
        play(New_game).

make_play(Game, New_game) :-
        game_player(Game, Player),
        write('Player '), write(Player), write(', please choose a location to place the X.'), nl,
        read_coords(Coords),
        place_xpiece(Game, Coords, New_game), !.

make_play(Game, New_game) :-
        write('Invalid location! Please try again.'), nl,
        make_play(Game, New_game).

end_play(Game, New_game) :-
        check_patterns(Game, New_scores),
        %New_scores = [[0, 0], [1, 1]],
        convert_patterns_to_score(Game, New_scores, Game1),
        game_next_player(Game1, New_game).
        
        
read_coords([X, Y]) :-
        write('X? '),
        read(X),
        write('Y? '),
        read(Y).

% Plays

place_xpiece(Game, Coords, New_game):-
        game_board(Game, Board),
        num_jokers_to_place(Board, 0), !,
        game_player(Game, Player),
        board_xy(Board, Coords, Cell),
        cell_xpiece(Cell, -1),
        cell_spieces(Cell, Spieces),
        cell_spieces(New_cell, Spieces),
        cell_xpiece(New_cell, Player),
        board_set_cell(Board, Coords, New_cell, New_board),
        game_set_board(Game, New_board, New_game).
        
        
% Visualization

print_board([H | T]) :-
        print_dashed_line(H), nl,
        print_board_content([H | T]), nl,
        write([H | T]).

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
        print_board([[[[], -1],         [[], -1],       [[], -1],       [[], -1],       [[], 0],        [[], -1],       [[], -1],       [[], -1]],
                     [[[], -1],         [[1], -1],      [[], -1],       [[], -1],       [[], -1],       [[], -1],       [[], -1],       [[], -1]],
                     [[[], -1],         [[], -1],       [[1], -1],      [[], -1],       [[], -1],       [[], -1],       [[], 0],        [[], -1]],
                     [[[], -1],         [[], -1],       [[], -1],       [[1], -1],      [[], -1],       [[], -1],       [[], -1],       [[], -1]],
                     [[[], -1],         [[], -1],       [[], -1],       [[], -1],       [[1], -1],      [[], -1],       [[], -1],       [[], 0]],
                     [[[], -1],         [[], -1],       [[2], -1],      [[2], -1],      [[2, 1], -1],   [[2], -1],      [[2], 2],       [[], -1]],
                     [[[], 2],          [[], 0],        [[], 1],        [[], 1],        [[], 0],        [[], 2],        [[], 1],        [[], -1]],
                     [[[], -1],         [[], -1],       [[], -1],       [[], -1],       [[], -1],       [[], -1],       [[], -1],       [[], -1]]]).

test_displ(_) :-
        print_board([[[[], -1], [[], -1],       [[], -1],       [[], -1],       [[], 0],        [[], -1],       [[], -1],       [[], -1]],
                     [[[], -1], [[], -1],       [[], -1],       [[], -1],       [[], -1],       [[], -1],       [[], -1],       [[], -1]],
                     [[[], -1], [[], -1],       [[], -1],       [[], -1],       [[], 0],        [[], -1],       [[], 0],        [[], -1]],
                     [[[], -1], [[], -1],       [[], -1],       [[1], -1],      [[], -1],       [[], -1],       [[], -1],       [[], -1]],
                     [[[], -1], [[], -1],       [[], -1],       [[], -1],       [[1], -1],      [[2], -1],      [[], -1],       [[2], -1]],
                     [[[], -1], [[], -1],       [[2], -1],      [[2], -1],      [[2], -1],      [[2], -1],      [[2], -1],      [[], -1]],
                     [[[], 2],  [[], 0],        [[], 1],        [[], 1],        [[], 0],        [[2], 1],       [[], 1],        [[2], -1]],
                     [[[], -1], [[], -1],       [[], -1],       [[], -1],       [[], -1],       [[], -1],       [[], 1],        [[], -1]]]).

test_board([[[[], 0], [[], -1], [[], -1], [[], 0], [[], 0]],
         [[[], 0], [[], -1], [[], -1], [[], 0], [[], 0]],
         [[[], 0], [[], -1], [[], -1], [[], 0], [[], 0]],
         [[[], 0], [[], -1], [[], -1], [[], 0], [[], 0]],
         [[[], 0], [[], -1], [[], -1], [[], 0], [[], 0]]]).