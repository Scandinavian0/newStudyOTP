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
  , while/1
  , while/2
%%  ,for/2
  , total/1
  , cost/1
]).

%% this project Entrance method
start() ->
  io:fwrite("this is my new study file for log my study process"),
  X = [1, 2, 3, 4],
  while(X),
  for(5, 1),
%%  Buy=[{oranges,4},{newspapper,1},{apples,6},{pears,6},{milk,3}],
  total([]),
  total([{milk, 3}]),
  total([{oranges, 10}]),
%%  hypot = fun(X, Y) ->
%%    math:sqrt(X * X + Y * Y)
%%          end,
%%  io:fwrite("~w~n", [hypot(3, 4)])
%%  hypot(3,4),
%%  L=[1,2,3,4],
%%  io:fwrite("~w~n",lists:map(fun(X)-> 2*X end,L)),
  Add = fun (A, B) -> A + B end,
  io:fwrite("~w~n",[Add(1,2)])
.

cost(oranges) -> 4;
cost(newsspapper) -> 1;
cost(apples) -> 3;
cost(pears) -> 6;
cost(milk) -> 3.

total([{What, N} | T]) ->
%%  递归
  A = cost(What) * N + total(T),
%%  打印变量的方法，而不是直接io:fwrite(A)
  io:fwrite("~w~n", [A]);
total([]) -> 0.


%% while循环
%% 所有函数式编程语言，它们不提供任何循环结构
%% 函数式编程依赖于一种称为递归的概念。
while(L) -> while(L, 0).
while([], Acc) -> Acc;
while([_ | T], Acc) ->
  io:fwrite("~w~n", [Acc]),
  while(T, Acc + 1).

for(0, _) ->
  [];
for(N, Term) when N > 0 ->
  io:fwrite("Hello word ~n"),
  [Term | for(N - 1, Term)].


