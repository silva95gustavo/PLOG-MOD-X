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
        write('0. Exit'), nl,
        cli_get_char(C),
        main_menu(C), !.
show_main_menu :-
        write('Invalid option! Please try again.'), nl,
        show_main_menu.
        
main_menu('1') :-
        start_game(Game),
        play(Game), !.
main_menu('2') :-
        start_game(Game),
        play(Game), !.
main_menu('3') :-
        start_game(Game),
        play(Game), !.
main_menu('0').

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