%%%-------------------------------------------------------------------
%%% @author liuxu
%%% @copyright (C) 2022, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 13. 1月 2022 10:42 AM
%%%-------------------------------------------------------------------
-module(area_server0).
-author("liuxu").

%% API
%% 使用进程改写一个进程。从area函数的参数里取两个模式，然后把他们重置为接受语句里的模式。
-export([loop/0]).

loop() ->
  receive
    {rectangle, Width, Ht} ->
      io:format("Area of rectangle is ~p~n", [Width * Ht]),
      loop();
    {square, Side} ->
      io:format("Area of square is ~p~n", [Side * Side]),
      loop();
%%    带上客户端的进程标识符
    {From, {rectangle, Width, Ht}} ->
      From ! Width * Ht,
      loop()
  end.
