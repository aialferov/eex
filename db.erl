-module(db).

-export([new/0, destroy/1]).
-export([write/3, read/2, delete/2, match/2]).

new() -> [].
destroy(_DbRef) -> ok.

write(Key, Element, DbRef) -> [{Key, Element}|DbRef].

read(Key, [{Key, Element}|_]) -> {ok, Element};
read(Key, [_|T]) -> read(Key, T);
read(_, []) -> {error, instance}.

delete(Key, DbRef) -> delete(Key, DbRef, []).
delete(Key, [{Key, _}|T], Acc) -> delete(Key, T, Acc);
delete(Key, [H|T], Acc) -> delete(Key, T, [H|Acc]);
delete(_, [], Acc) -> Acc.

match(Element, DbRef) -> match(Element, DbRef, []).
match(Element, [{Key, Element}|T], Acc) -> match(Element, T, [Key|Acc]);
match(Element, [_|T], Acc) -> match(Element, T, Acc);
match(_, [], Acc) -> Acc.
