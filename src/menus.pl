% Menus

:- ensure_loaded('modx.pl').

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
        nl,
        nl,
        write('                         Press enter to play                      '), nl,
        nl,
        get_char(_),
        show_main_menu.
        
show_main_menu :-
        write('1. Player vs Bot'), nl,
        write('2. 2 Players'), nl,
        write('3. Bot vs Bot'), nl,
        write('0. Exit'), nl,
        cli_get_digit(D),
        D >= 0,
        D =< 3, !,
        main_menu(D).
show_main_menu :-
        write('Invalid option! Please try again.'), nl,
        show_main_menu.
        
main_menu(1) :-
        start_game(Game),
        randomize_order_1vbot(Preds),
        write(Preds), nl,
        play_1vbot(Game, Preds), !.
main_menu(2) :-
        start_game(Game),
        play_1v1(Game), !.
main_menu(3) :-
        start_game(Game),
        play_botvbot(Game), !.
main_menu(0).

randomize_order_1vbot(Preds) :-
        random(0, 2, 1),
        !,
        order2_1vbot(Preds).

randomize_order_1vbot(Preds) :-
        order1_1vbot(Preds).

order1_1vbot([make_play, make_play_bot]).
order2_1vbot([make_play_bot, make_play]).

ask_for_jokers(Num) :-
        write(Num),
        ask_for_jokers_aux(Num),
        write(' must be placed. Please indicate the joker\'s location.'), nl.

ask_for_jokers_aux(Num) :-
        Num is 1,
        write(' joker').
ask_for_jokers_aux(Num) :-
        Num > 1,
        write(' jokers').

show_end_game(Winner) :-
        nl, nl,
        write('  /$$$$$$                                          '), nl,
        write(' /$$__  $$                                         '), nl,
        write('| $$  \\__/  /$$$$$$  /$$$$$$/$$$$   /$$$$$$       '), nl,
        write('| $$ /$$$$ |____  $$| $$_  $$_  $$ /$$__  $$       '), nl,
        write('| $$|_  $$  /$$$$$$$| $$ \\ $$ \\ $$| $$$$$$$$     '), nl,
        write('| $$  \\ $$ /$$__  $$| $$ | $$ | $$| $$_____/      '), nl,
        write('|  $$$$$$/|  $$$$$$$| $$ | $$ | $$|  $$$$$$$       '), nl,
        write(' \\______/  \\_______/|__/ |__/ |__/ \\_______/    '), nl, nl,
        write('    /$$$$$$                                        '), nl,
        write('   /$$__  $$                                       '), nl,
        write('  | $$  \\ $$ /$$    /$$ /$$$$$$   /$$$$$$         '), nl,
        write('  | $$  | $$|  $$  /$$//$$__  $$ /$$__  $$         '), nl,
        write('  | $$  | $$ \\  $$/$$/| $$$$$$$$| $$  \\__/       '), nl,
        write('  | $$  | $$  \\  $$$/ | $$_____/| $$              '), nl,
        write('  |  $$$$$$/   \\  $/  |  $$$$$$$| $$              '), nl,
        write('   \\______/     \\_/    \\_______/|__/            '), nl, nl,
        write('          Congratulations player '), write(Winner), write('!'), nl,
        write('              You are the winner!'), nl, nl.