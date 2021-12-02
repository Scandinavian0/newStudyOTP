%%%-------------------------------------------------------------------
%%% @author liuxu
%%% @copyright (C) 2021, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 02. 12月 2021 4:39 下午
%%%-------------------------------------------------------------------
-module(multiple).
-author("liuxu").

%% API
%% 这里最好使用函数的调用来进行编译，对于idea编译器来说，这样不会因为erlang报出的warring导致编译失败，后续将都使用这种写法来进行编译
-export([start/0,multiples/2]).
start()->
  multiples(1,2).

multiples(A,B) ->
  io:fwrite("hahah"),
  if
    A == B ->
      io:fwrite("A is equal to B");
    A < B ->
      io:format("A is less than B");
    true ->
      io:fwrite("false")
  end.
