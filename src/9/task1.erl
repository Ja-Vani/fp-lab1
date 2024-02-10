-module(task1).
-export([special_pyth_trip/1, special_pyth_trip_r/1, special_pyth_trip_f/1]).

%tail rec
special_pyth_trip(K) ->
    special_pyth_trip(1, 1, math:pow(2, 0.5), K).

special_pyth_trip(A, B, C, K) when A + B + C == K -> {A, B, C};
special_pyth_trip(A, B, C, K) when A + B + C < K -> special_pyth_trip(A, B + 1, math:pow(A * A + (B + 1) * (B + 1), 0.5), K);
special_pyth_trip(A, B, _, K) when A + B > K -> {};
special_pyth_trip(A, _, _, K) -> special_pyth_trip(A + 1, A + 1, math:pow(2 * (A + 1) * (A + 1), 0.5), K).

%rec
is_valid_pyth(A, B, C, K) when A + B + C == K -> {A, B, C};
is_valid_pyth(A, B, C, K) when A + B + C < K -> special_pyth_trip_r(A, B + 1, K);
is_valid_pyth(A, B, _, K) when A + B > K -> {};
is_valid_pyth(A, _, _, K) -> special_pyth_trip_r(A + 1, A + 1, K).

special_pyth_trip_r(K) ->
    special_pyth_trip_r(1, 1, K).

special_pyth_trip_r(A, B, K) ->
    C = math:pow(A * A + B * B, 0.5),
    is_valid_pyth(A, B, C, K).

%fold
is_spicial({A, B, C, K}, {}) when A + B + C == K -> {A, B, C};
is_spicial(_, Acc) -> Acc.

get_fold_special_list(K) -> get_fold_special_list(1, 1, math:pow(2, 0.5), K).

get_fold_special_list(A, B, C, K) when B < K/2 -> [{A, B, C, K} | get_fold_special_list(A, B + 1, math:pow(A * A + (B + 1) * (B + 1), 0.5), K)];
get_fold_special_list(A, B, C, K) when A < K/2 -> [{A, B, C, K} | get_fold_special_list(A + 1, A + 1, math:pow(2 * (A + 1) * (A + 1), 0.5), K)];
get_fold_special_list(_, _, _, _) -> [].

special_pyth_trip_f(K) ->
    lists:foldl(fun({A, B, C, K1}, Acc) -> is_spicial({A, B, C, K1}, Acc) end, {},
    get_fold_special_list(K)).