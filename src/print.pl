imprime([H | T]) :-
        mostra(H), nl,
        imprime(T).
imprime([]).
mostra([H | T]) :-
        traduz(H, X), write(X), write('|'),
        mostra(T).
mostra([]).
traduz(H, H).