%%%-------------------------------------------------------------------
%%% @author liuxu
%%% @copyright (C) 2021, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 02. 12月 2021 4:55 下午
%%%-------------------------------------------------------------------
-module(studyErlang).
-author("liuxu").

%% API
-export([start/0
  ,while/1
  ,while/2
%%  ,for/2
]).

%% this project Entrance method
start()->
  io:fwrite("this is my new study file for log my study process"),
  X = [1,2,3,4],
  while(X),
  for(5,1)
.

%% while循环
%% 所有函数式编程语言，它们不提供任何循环结构
%% 函数式编程依赖于一种称为递归的概念。
while(L) -> while(L,0).
while([], Acc) -> Acc;
while([_|T], Acc) ->
  io:fwrite("~w~n",[Acc]),
  while(T,Acc+1).

for(0,_)->
  [];
  for(N,Term) when N>0->
    io:fwrite("Hello word ~n"),
    [Term|for(N-1,Term)].

  
