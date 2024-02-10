-module(task1_tests).
-include_lib("eunit/include/eunit.hrl").

% Reduce with tail recursion
get_max_factor_test() ->
    ?assertEqual(task1:special_pyth_trip(1000), {200, 375, 425.0}).

% Reduce with recursion
get_max_factor_t_test() ->
    ?assertEqual(task1:special_pyth_trip_r(1000), {200, 375, 425.0}).

% Fold
get_max_factor_f_test() ->
    ?assertEqual(task1:special_pyth_trip_f(1000), {200, 375, 425.0}).