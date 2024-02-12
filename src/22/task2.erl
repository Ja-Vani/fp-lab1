-module(task2).

-export([names_score/0, names_score_r/0, names_score_f/0]).

read_list_from_file() ->
    {ok, Data} = file:read_file("0022_names.txt"),
    string:tokens(
        binary:bin_to_list(Data), ",\"").

word_sum(Word) ->
    word_sum(Word, 0).

word_sum([], Acc) ->
    Acc;
word_sum([Head | Tail], Acc) ->
    word_sum(Tail, Acc + Head - 64).

%tail rec
names_score() ->
    names_score(0, read_list_from_file(), 1).

names_score(Acc, [], _) ->
    Acc;
names_score(Acc, [Head | Tail], N) ->
    names_score(Acc + word_sum(Head) * N, Tail, N + 1).

%rec
names_score_r() ->
    names_score_r(read_list_from_file(), 1).

names_score_r([], _) ->
    0;
names_score_r([Head | Tail], N) ->
    names_score_r(Tail, N + 1) + word_sum(Head) * N.

%fold

names_score_f() ->
    {A, _} =
        lists:foldl(fun(List, {Acc, N}) -> {Acc + word_sum(List) * N, N + 1} end,
                    {0, 1},
                    read_list_from_file()),
    A.
