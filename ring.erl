-module(ring).
-export([start/3, loop/1]).

start(Pn, Mn, M) -> send_message(create_ring(Pn), Mn, M).

create_ring(Pn) -> link_ring(create_proc(Pn)).

create_proc(0) -> [];
create_proc(Pn) -> [spawn(ring, loop, [{ok, ok}])|create_proc(Pn - 1)].

link_ring(Pids = [H|_]) -> link_ring(Pids, H).
link_ring([H, H1|T], FirstPid) ->
	H ! {next, {H1, FirstPid}},
	link_ring([H1|T], FirstPid);
link_ring([H|[]], FirstPid) -> H ! {next, {FirstPid, FirstPid}}, FirstPid.

send_message(Pid, 0, _) -> ok;%Pid ! stop;
send_message(Pid, Mn, M) -> Pid ! {send, M}, send_message(Pid, Mn - 1, M).
	
loop({NextPid, FirstPid}) ->
	receive
		{next, {NewNextPid, NewFirstPid}} ->
			io:format("~w next ~w~n", [self(), {NewNextPid, NewFirstPid}]),
			loop({NewNextPid, NewFirstPid});
		{send, Message} ->
			io:format("~w send ~w~n", [self(), Message]),
			self() ! {message, Message},
			loop({NextPid, FirstPid});
		{message, Message} ->
			io:format("~w message ~w~n", [self(), Message]),
			if
				NextPid /= FirstPid -> NextPid ! {message, Message};
				true -> ok
			end,
			loop({NextPid, FirstPid});
		stop ->
			io:format("~w stop~n", [self()]),
			NextPid ! stop,
			stop
	end.
