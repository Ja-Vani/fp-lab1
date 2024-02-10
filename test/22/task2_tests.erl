-module(task2_tests).
-include_lib("eunit/include/eunit.hrl").

% Reduce with tail recursion
names_score_test() ->
    ?assertEqual(task2:names_score(), 324536).

% Reduce with recursion
names_score_t_test() ->
    ?assertEqual(task2:names_score_r(), 324536).

% Fold
names_score_f_test() ->
    ?assertEqual(task2:names_score_f(), 324536).