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
    ,map/2
    , start/0,
    qsort/1]).
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
map(_,[])->[];
map(F,[H|T])->[F(H)|map(F,T)].
qsort([])->[];
qsort([Piovt|T])->
    qsort([X||X<-T,X<Piovt])
    ++[Piovt] ++
    qsort([X||X<-T,X>=Piovt]).

start() ->
    io:format("~w~n", [for(1, 10, fun(I) -> I * I end)])
%%   io:format("~w~n",[for(10,10,fun(I)->I*I end)])
    ,io:format("~w~n",[map(fun(X)->2*X end,[1,2,3])])
%%    排序算法
    ,Qsort=[23,6,2,9,27,400,78,45,61,82,14]
    ,io:format("sort algorithm")
    ,io:format("~w~n",[qsort(Qsort)])
.
