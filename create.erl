-module(create).
-export([create/1, reverse_create/1]).

create(N) when N > 0 -> create(N + 1, 1).
create(N, N) -> [];
create(N, C) -> [C|create(N, C + 1)].

reverse_create(0) -> [];
reverse_create(N) when N > 0 -> [N|reverse_create(N - 1)].
