-module(echo).
-export([start/0, stop/0, print/1, loop/0]).

start() -> register(echo, spawn(echo, loop, [])).
stop() -> echo ! stop.

print(Term) -> echo ! {print, Term, self()}.

loop() ->
	receive
		{print, Term, _From} ->
			io:format("~p~n", [Term]);
		stop ->
			true
	end.
