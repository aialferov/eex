-module(effects).
-export([print/1, even_print/1]).

print(0) ->
	io:format("~n", []);
print(N) when is_integer(N) ->
	io:format("~w ", [N]),
	print(N - 1).

even_print(0) ->
	io:format("~n", []);
even_print(N) when is_integer(N), N rem 2 == 0 ->
	io:format("~w ", [N]),
	even_print(N - 1);
even_print(N) when is_integer(N) ->
	even_print(N - 1).

