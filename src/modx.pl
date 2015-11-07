% Modules

:- use_module(library(random)).
:- use_module(library(lists)).
:- use_module(library(system)).
:- now(Timestamp),
   setrand(Timestamp).

:- ensure_loaded('utils.pl').
:- ensure_loaded('menus.pl').
:- ensure_loaded('cli.pl').
:- ensure_loaded('constants.pl').
:- ensure_loaded('board.pl').
:- ensure_loaded('game.pl').
:- ensure_loaded('plays.pl').
:- ensure_loaded('cell.pl').
:- ensure_loaded('visualization.pl').
:- ensure_loaded('test.pl').       
        
        
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

play(Game) :- game_ended(Game),
        game_board(Game, Board),
        print_board(Board),
        game_player(Game, Winner),
        show_end_game(Winner).
        
play(Game) :-
        print_game(Game),
        make_play(Game, Game1),
        end_play(Game1, New_game),
        play(New_game).

make_play_2(Game, New_game) :-
        game_board(Game, Board),
        num_jokers_to_place(Board, Jokers),
        ask_for_jokers(Jokers),
        read_coords(Coords),
        place_joker(Game, Coords, New_game),
        play(New_game).

make_play_2(Game, New_game) :-
        write('Invalid location! Please try again.'), nl,
        make_play_2(Game, New_game).

make_play(Game, New_game) :-
        game_board(Game, Board),
        num_jokers_to_place(Board, Jokers),
        Jokers > 0,
        make_play_2(Game, New_game).

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
       