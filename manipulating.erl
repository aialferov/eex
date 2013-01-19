-module(manipulating).
-export([filter/2, reverse/1, concatenate/1, flatten/1]).

filter(L, V) -> filter(L, V, []).
filter([H|T], V, Acc) when H =< V -> filter(T, V, [H|Acc]);
filter([_|T], V, Acc) -> filter(T, V, Acc);
filter([], _, Acc) -> reverse(Acc).

reverse(L) -> reverse(L, []).
reverse([H|T], Acc) -> reverse(T, [H|Acc]);
reverse([], Acc) -> Acc.

concatenate(L) -> concatenate(L, []).
concatenate([[H|T]|T1], Acc) -> concatenate([T|T1], [H|Acc]);
concatenate([[]|T], Acc) -> concatenate(T, Acc);
concatenate([], Acc) -> reverse(Acc).

flatten(L) -> flatten(L, []).
flatten([H|T], Acc) when is_list(H) -> flatten(T, reverse(flatten(H, Acc)));
flatten([H|T], Acc) -> flatten(T, [H|Acc]);
flatten([], Acc) -> reverse(Acc).
