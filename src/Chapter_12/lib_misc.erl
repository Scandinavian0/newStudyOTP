%%%-------------------------------------------------------------------
%%% @author liuxu
%%% @copyright (C) 2022, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 13. 1月 2022 3:30 PM
%%%-------------------------------------------------------------------
-module(lib_misc).
-author("liuxu").

%% API
-export([sleep/1, flush_buffer/0,priority_receive/0]).

%% 只带超时的接收 让进程挂起t秒
sleep(T) ->
  receive
  after T ->
    true
  end.

%% 超时值为0的接收
%% 超时值为0会让超时的主体部分立即发声，但在这之前，系统会尝试对邮箱里的消息进行匹配，然后全部清空。
flush_buffer() ->
  receive
    _Any ->
      flush_buffer()
  after 0 ->
    true
  end.

%% 使用零超时来实现某种形式的"优先接收"
%% 如果邮箱里不存在匹配{ararm,X}的消息，priority_receive就会接受邮箱里第一个消息。
%% 如果没有任何消息，他就会在最里面的接受语句处挂起，并返回它收到的第一个消息。
%% 如果存在匹配{alarm,X}的消息，这个消息就会被立即返回。
priority_receive() ->
  receive
    {alarm, X} ->
      {alarm, X}
  after 0 ->
    receive
      Any ->
        Any
    end
  end.

