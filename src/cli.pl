% CLI

cli_get_char(C) :-
        get_char(C),
        get_char(_).

cli_get_digit(D) :-
        get_code(C),
        get_char(_),
        D is C - 48.