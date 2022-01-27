%%%-------------------------------------------------------------------
%%% @author liuxu
%%% @copyright (C) 2022, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 27. 1月 2022 10:30 AM
%%%-------------------------------------------------------------------
-module(socket_example).
-author("liuxu").

%% API
%% 用 tcp 套接字从服务器获取数据
-export([nano_get_url/0,test/0]).
test()->
  Bin=[1,2,3,4,5],
  SoFar=[],
  K=[Bin|SoFar],
  io:format("~p~n",[K]).
nano_get_url() ->
  B=nano_get_url("www.bing.com"),
%%  B = nano_get_url("www.baidu.com"),
  io:format("B is :~p~n", [B]).

nano_get_url(Host) ->
%%  连接host
  {ok, Socket} = gen_tcp:connect(Host, 80, [binary, {packet, 0}]),

  ok = gen_tcp:send(Socket, "Get / HTTP/1.0 \r\n\r\n"),

  io:format("ok is ~p~n", [ok]),
  receive_data(Socket, []).

receive_data(Socket, SoFar) ->
  io:format("SoFar is ~p~n", [SoFar]),
  io:format("Socket is ~p~n", [Socket]),
  receive
    {tcp, Socket, Bin} ->
      io:format("Bin is ~p~n", [Bin]),
      receive_data(Socket, [Bin | SoFar]),
      io:format("SoFa2r is ~p~n",[[Bin | SoFar]]);
    {tcp_closed, Socket} ->
      list_to_binary(lists:reverse(SoFar))
  end.



