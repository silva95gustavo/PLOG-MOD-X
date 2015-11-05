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