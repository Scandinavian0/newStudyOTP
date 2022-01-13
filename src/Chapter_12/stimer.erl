%%%-------------------------------------------------------------------
%%% @author liuxu
%%% @copyright (C) 2022, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 13. 1月 2022 3:49 PM
%%%-------------------------------------------------------------------
-module(stimer).
-author("liuxu").

%% API
-export([start/2, cancel/1]).

start(Time, Fun) -> spawn(fun() -> timer(Time, Fun) end).
cancel(Pid) -> Pid ! cancel.
timer(Time,Fun)->
  receive
%%   这里就在匹配接收到的消息和原定消息的值是否一致
    cancel->
      void
  after Time->
    Fun()
  end.
