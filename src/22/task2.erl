-module(task2).
-export([names_score/0, names_score_r/0, names_score_f/0]).


read_list_from_file()->
    {ok, Data} = file:read_file("0022_names.txt"),
    List = string:tokens(binary:bin_to_list(Data), ",\"").

word_sum(Word)->word_sum(Word, 0).

word_sum([], Acc)->Acc;
word_sum([Head|Tail], Acc)-> word_sum(Tail, Acc + Head-64).

%tail rec
names_score()->
    names_score(0, read_list_from_file()).

names_score(Acc, [])-> Acc;
names_score(Acc, [Head|Tail])->names_score(Acc + word_sum(Head),Tail).

%rec
names_score_r()->
    names_score_r(read_list_from_file()).

names_score_r([])-> 0;
names_score_r([Head|Tail])->names_score_r(Tail) + word_sum(Head).

%fold

names_score_f()->
    lists:foldl(fun word_sum/2, 0,
    read_list_from_file()).