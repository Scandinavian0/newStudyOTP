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
-import(lists, [map/2, sum/1]).

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

%%  以fun作为参数的函数
    L = [1, 2, 3, 4],
    io:fwrite("~w~n", [lists:map(fun(E) -> 2 * E end, L)]),
    Add = fun(A, B) -> A + B end,
    io:fwrite("~w~n", [Add(1, 2)]),
    Even = fun(E) -> (E rem 2) =:= 0 end,
    io:fwrite("~w~n", [Even(7)]),
    io:format("~w~n", [Even(8)]),

%%  返回fun的函数
    Fruit = [apple, pear, orange],
    MakeTest = fun(A) -> (fun(B) -> lists:member(B, A) end) end,
    IsFruit = MakeTest(Fruit),
    io:format("~ts~n", [xmerl_ucs:to_utf8("返回fun的函数:")]),
    io:fwrite("IsFruit:~w~n", [IsFruit(apple)]),
%%  使用list:filter/2作为参数
    io:fwrite("~ts~n", [xmerl_ucs:to_utf8("使用list:filter/2作为参数:")]),
    io:fwrite("~w~n", [lists:filter(IsFruit, [dog, apple, orange, cat, apple])]),

%% for循环
    io:format("~ts~n", [xmerl_ucs:to_utf8("调用for 循环:")]),
    io:format("~w~n", [lib_misc:for(1, 10, fun(I) -> I * I end)]),
%% sum 函数求和
    io:format("~ts~n", [xmerl_ucs:to_utf8("sum函数求和：")]),
    io:format("~w~n", [lib_misc:sum([1, 3, 10])]),

%% 列表推导
%% [F(X)||X<-L] 标记的意思就是“由F(X)组成的列表(X从列表L中提取)"
    io:format("~ts~n", [xmerl_ucs:to_utf8("列表推导")]),
%%    [2 * K || K <- X] 这是一个整体
    io:format("~w~n", [[2 * K || K <- X]]),
    io:format("~w~n",[[K||K<-X]])

.

cost(oranges) -> 4;
cost(newspapper) -> 1;
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


