%%%-------------------------------------------------------------------
%%% @author liuxu
%%% @copyright (C) 2022, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 05. 1月 2022 3:04 PM
%%%-------------------------------------------------------------------
-module(try_test).
-author("liuxu").

%% API
-export([demo1/0, demo2/0]).
demo1() ->
  io:format("~w~n", [[catcher(I) || I <- [1, 2, 3, 4, 5]]]).
%%  [catcher(I)||I<-[1,2,3,4,5]].
demo2() ->
%%  [{I, (catch generate_exception(I))} || I < [1, 2, 3, 4, 5]]
    io:format("~ts~n", ["这样写有问题"]).
catcher(N) ->
  try
    generate_exception(N) of Val -> {N, normal, Val}
  catch
    throw: X -> {N, caught, thrown, X};
    exit:X -> {N, caught, exited, X};
    error: X -> {N, caught, error, X}
  end.


generate_exception(1) -> a;
generate_exception(2) -> throw(a);
generate_exception(3) -> exit(a);
generate_exception(4) -> {'EXIT', a};
generate_exception(5) -> error(a).