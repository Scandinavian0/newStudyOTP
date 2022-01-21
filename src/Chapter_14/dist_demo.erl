%%%-------------------------------------------------------------------
%%% @author liuxu
%%% @copyright (C) 2022, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 21. 1月 2022 2:35 PM
%%%-------------------------------------------------------------------
-module(dist_demo).
-author("liuxu").

%% API
%% 展示如何在某个远程节点上分裂进程。
-export([rpc/4, start/1]).

start(Node) ->
  spawn(Node, fun() -> loop() end).
rpc(Pid, M, F, A) ->
  Pid ! {rpc, self(), M, F, A},
  receive
    {Pid, Response} ->
      Response
  end.
loop() ->
  receive
    {rpc, Pid, M, F, A} ->
      Pid ! {self(), (catch apply(M, F, A))},
      loop()
  end.
