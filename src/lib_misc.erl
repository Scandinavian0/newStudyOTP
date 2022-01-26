%%%-------------------------------------------------------------------
%%% @author liuxu
%%% @copyright (C) 2021, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 08. 12月 2021 4:51 PM
%%%-------------------------------------------------------------------
-module(lib_misc).
-author("liuxu").

%% API
-export([for/3
  , sum/1
  , map/2
  , start/0
  , pythag/1
  , perms/1
  , odds_and_evens1/1
  ,odds_and_evens2/1,
  unconsult/2]).
%% for循环 迭代for函数
for(Max, Max, F) -> [F(Max)];
for(I, Max, F) -> [F(I) | for(I + 1, Max, F)].

%% sum函数
%% 设传入的指是[1,3,10]
%% 1.sum([1,3,10])
%% 2.sum([1,3,10])  =1+sum([3,10])
%%                  =1+3+sum([10])
%%                  =1+3+10+sum([])
%%                  =1+3+10+0.
sum([H | T]) -> H + sum(T);
sum([]) -> 0.

%% map集合便利函数
map(_, []) -> [];
map(F, [H | T]) -> [F(H) | map(F, T)].

%%勾股定理，毕达哥拉斯三元函数
pythag(N) ->
  [{A, B, C} ||
    A <- lists:seq(1, N),
    B <- lists:seq(1, N),
    C <- lists:seq(1, N),
    A + B + C =< N,
    A * A + B * B =:= C * C
  ].

%%回文构词
%%
perms([]) -> [[]];
perms(L) -> [[H | T] %% 分离出列表头元素赋值到H，剩下代表作为T
  || H <- L, %% H从列表L中提取
  T <- perms(L--[H])] %% 递归，L -- H是列表移除操作符，它从X里移除Y中的元素
.

%% 归集器，
%% 区分奇数和偶数,只适用于列表比较短的情况下
odds_and_evens1(L) ->
  Odds = [X || X <- L, (X rem 2) =:= 1],
  Evens = [X || X <- L, (X rem 2) =:= 0],
  {Odds, Evens}
.
%%从写odds_and_evens1，主要避免两次遍历列表
odds_and_evens2(L)->
  odd_and_evens_acc(L,[],[]).

odd_and_evens_acc([H|T],Odds,Evens)->
  case(H rem 2) of
    1->odd_and_evens_acc(T,[H|Odds],Evens);
    0->odd_and_evens_acc(T,Odds,[H|Evens])
  end;
odd_and_evens_acc([],Odds,Evens)->
  {Odds,Evens}.

%% 写入文件的函数
unconsult(File,L)->
  {ok,S}=file:open(File,write),
  lists:foreach(fun(X)->io:format(S,"~p.~n",[X]) end,L),
  file:close(S).




start() ->
  io:format("~w~n", [for(1, 10, fun(I) -> I * I end)])
%%   io:format("~w~n",[for(10,10,fun(I)->I*I end)])
  , io:format("~w~n", [map(fun(X) -> 2 * X end, [1, 2, 3])])
  , io:fwrite("~w~n", [pythag(30)])
%%  ,io:format("~w~n",[])

  , io:fwrite("~ts~n", [perms("cats")])
  , io:format("~w~n", [time()])
  , io:format("~w~n", [odds_and_evens1([1, 2, 3, 4, 5, 6,7])])
  , io:format("~w~n", [odds_and_evens2([1, 2, 3, 4, 5, 6,7])])
.
