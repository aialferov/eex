-module(sorting).
-export([quicksort/1, mergesort/1]).

quicksort([]) -> [];
quicksort([H|T]) -> quicksort(T, H, [], []).
quicksort([H|T], P, S, R) when H < P -> quicksort(T, P, [H|S], R);
quicksort([H|T], P, S, R) -> quicksort(T, P, S, [H|R]);
quicksort([], P, S, R) -> quicksort(S) ++ [P|quicksort(R)].

mergesort([]) -> [];
mergesort([H]) -> [H];
mergesort(L) -> mergesort(L, [], []).
mergesort([H1, H2|T], L1, L2) -> mergesort(T, [H1|L1], [H2|L2]);
mergesort([H|T], L1, L2) -> mergesort(T, [H|L1], L2);
mergesort([], L1, L2) -> merge(mergesort(L1), mergesort(L2)).

merge([H1|T1], [H2|T2]) when H1 < H2 -> [H1|merge(T1, [H2|T2])];
merge([H1|T1], [H2|T2]) -> [H2|merge([H1|T1], T2)];
merge([H|T], []) -> [H|T];
merge([], [H|T]) -> [H|T];
merge([], []) -> [].
