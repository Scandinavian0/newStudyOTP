%%%-------------------------------------------------------------------
%%% @author liuxu
%%% @copyright (C) 2022, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 10. 1月 2022 11:08 AM
%%%-------------------------------------------------------------------
%% 为了展示动态加载代码的特性，先将b的输出设为1，在编译运行后，再次更改为2，则将打印最新的输出
-module(a).
-author("liuxu").

%% API
%%-export([]).
- compile(export_all).

start(Tag)->
  spawn(fun()->loop(Tag) end).

loop(Tag)->
  sleep(),
  Val=b:x(),
  io:format("Vsn1(~p) b:x() = ~p~n",[Tag,Val]),
  loop(Tag).
sleep()->
  receive
    after 3000->true
  end.