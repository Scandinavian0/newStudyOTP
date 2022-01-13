%%%-------------------------------------------------------------------
%%% @author liuxu
%%% @copyright (C) 2022, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 13. 1月 2022 11:39 AM
%%%-------------------------------------------------------------------
-module(area_server1).
-author("liuxu").

%% API
%% 在area-server0的基础上添加了远程过程调用的小函数，为了确保能处理发送给进程消息不匹配的信息
-export([loop/0, rpc/2]).
rpc(Pid, Request) ->
  Pid ! {self(), Request},
  receive
%%    Response ->
%%      Response
%%    新改动：防止其他进程给该进程发送消息时会误认为是服务端的消息，所以需要绑定一个pid
    {Pid, Response} ->
      Response
  end.

loop() ->
  receive
%%    {rectangle, Width, Ht} ->
%%      io:format("Area of rectangle is ~p~n", [Width * Ht]),
%%      loop();
%%    {square, Side} ->
%%      io:format("Area of square is ~p~n", [Side * Side]),
%%      loop();
%%    带上客户端的进程标识符
    {From, {rectangle, Width, Ht}} ->
%%      From ! Width * Ht,
      %% 这边也要做改动
      From ! {self(), Width * Ht},
      loop();
    {From, {circle, R}} ->
%%      From ! 3.141596 * R * R,
      From ! {self(), 3.141596 * R * R},
      loop();
    {From, Other} ->
%%      From ! {error, Other},
      From ! {self(), {error, Other}},
      loop()
  end.

