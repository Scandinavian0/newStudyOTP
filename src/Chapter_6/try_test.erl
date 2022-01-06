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
-export([demo1/0, demo2/0,demo3/0]).
%% 异常写法
demo1() ->
  io:format("~w~n", [[catcher(I) || I <- [1, 2, 3, 4, 5]]]).
%%  [catcher(I)||I<-[1,2,3,4,5]].
%% 异常的另一种写法
demo2() ->
%%  [{I, (catch generate_exception(I))} || I < [1, 2, 3, 4, 5]]
    io:format("~ts~n", ["这样写有问题"]).
%% 栈跟踪
%% 在Erlang 21.0中，获取栈异常的新语法是
%% _:_:Stacktrace ->
%%      erlang:display(Stacktrace)
%% 书上写的erlang:get_stacktrace() 只适用于Erlang 20.0以下版本
demo3()->
  try
      generate_exception(5)
  catch
      _:_: X ->
        erlang:display(X),
        io:format("~w~n",[{X,erlang:display(X)}])
  end .
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