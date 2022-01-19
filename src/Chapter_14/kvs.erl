%%%-------------------------------------------------------------------
%%% @author liuxu
%%% @copyright (C) 2022, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 19. 1月 2022 6:56 PM
%%%-------------------------------------------------------------------
-module(kvs).
-author("liuxu").

%% API
%% kvs:start()->true 启动服务器
%% kvs:store(Key,Value)-> true 关联key和value
%% kvs:lookup(Key)->{ok,Value}|undifind 查找key的值
-export([start/0, store/2, lookup/1,main/0]).

start() -> register(kvs, spawn(fun() -> loop() end)).

store(Key, Value) -> rpc({store, Key, Value}).

lookup(Key) -> rpc({lookup, Key}).

rpc(Q) ->
  io:format("~p~n",[Q]),
  kvs ! {self(), Q},
  receive
    {kvs, Reply} ->
      io:format("rpc receive"),
      Reply
  end.

loop() ->
  io:format("I'm here! ~n"),
  receive
    {From, {store, Key, Value}} ->
      io:format("entering this method ~n"),
      put(Key, {ok, Value}),
      From ! {kvs, true},
      loop();
    {From, {lookup, Key}} ->
      From ! {kvs, get(Key)},
      loop()
  end.


main()->
  start(),
  Msg1=store({location,joe},"Stockholm"),
  Msg2=store(weather,raining),
  io:format("store message:~p ~p ~n",[Msg1,Msg2]),
  Msg3=lookup(weather),
  Msg4=lookup({location,joe}),
  Msg5=lookup({location,jane}),
  io:format("lookup Msg : ~p ~p ~p ~n",[Msg3,Msg4,Msg5]).

