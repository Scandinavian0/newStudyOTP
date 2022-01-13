%%%-------------------------------------------------------------------
%%% @author liuxu
%%% @copyright (C) 2022, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 13. 1月 2022 4:22 PM
%%%-------------------------------------------------------------------
-module(clock).
-author("liuxu").

%% API
%% 使用进程注册来模拟⏰时钟
-export([start/2, stop/0]).
start(Time, Fun) ->
  register(clock, spawn(fun() -> tick(Time, Fun) end)).
stop() -> clock ! stop.
tick(Time, Fun) ->
  receive
    stop ->
      void
  after Time ->
    Fun(),
    tick(Time, Fun)
  end.