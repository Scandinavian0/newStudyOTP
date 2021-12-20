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
  , perms/1]).
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

start() ->
  io:format("~w~n", [for(1, 10, fun(I) -> I * I end)])
%%   io:format("~w~n",[for(10,10,fun(I)->I*I end)])
  , io:format("~w~n", [map(fun(X) -> 2 * X end, [1, 2, 3])])
  , io:fwrite("~w~n", [pythag(30)])
%%  ,io:format("~w~n",[])

  ,io:fwrite("~ts",[perms("cats")])
.
