% Utils

%member_list_chk(List1, List2)
% Checks if List1 has all members in List 2
member_list_chk([], _).
member_list_chk([H | T], List2) :-
        memberchk(H, List2),
        member_list_chk(T, List2).

%replace(+N, +X, +L1, -L2)
% Replaces the Nth member of L1 by X and instanciates L2 to the result.
replace(N, X, L1, L2) :-
        length(L3, N),
        append(L3, [_ | T], L1),
        append(L3, [X | T], L2).

%inc(+X, -X1)
inc(X, X1) :- X1 is X + 1.

%dec(+X, -X1)
dec(X, X1) :- X1 is X - 1.