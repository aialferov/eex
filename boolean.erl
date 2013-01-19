-module(boolean).
-export([b_not/1, b_and/2, b_or/2]).

b_not(A) when A == true; A == false -> A xor true.
b_and(A, B) when is_atom(A), is_atom(B) -> A andalso B.
b_or(A, B) when is_atom(A), is_atom(B) -> A orelse B.
