% CLI

cli_get_char(C) :-
        get_char(C),
        get_char(_).

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