%%%-------------------------------------------------------------------
%%% @author liuxu
%%% @copyright (C) 2021, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 21. 12月 2021 4:09 PM
%%%-------------------------------------------------------------------
-module(section_4).
-author("liuxu").

%% API
-export([start/0]).

practice_1(T, {L, W}) ->
  case (T) of
    "circle" -> math:pi() * L * W;
    "triangle" -> (L * W) / 2
  end.

%%
practice_2(T) ->
  practice_2(T, tuple_size(T), 0, []).
%%T 是元组，index是下标，F是>=0的阀值，L是列表
practice_2(T, Index, F, L) when Index > F ->
  practice_2(T, Index - 1, F, [element(Index, T) | L]);
practice_2(_, Index, F, L) when Index =:= F ->
  L.

%% 温习
practice_2_1(T) ->
  practice_2_1(T, tuple_size(T), 0, []).
practice_2_1(T, Index, F, L) when Index > F ->
%%  递归
  practice_2_1(T, Index - 1, F, [element(Index, T) | L]);
practice_2_1(_, Index, F, L) when Index =:= F ->
  L.

%% 另一种方法
practice_2_2(T) ->
  practice_2_2(T, tuple_size(T), []).
practice_2_2(_, 0, L) -> L;
practice_2_2(T, Index, L) ->
  practice_2_2(T, Index - 1, [element(Index, T) | L]).

%% 让它执行fun F并记下执行时间
practice_3_1(X, Y) ->
  {MegaSecs1, Secs1, MicroSecs1} = erlang:timestamp(),
%%  io:format("~w~n",[MegaSecs1]),
%%  io:format("~w~n",[Secs1]),
%%  io:format("~w~n",[MicroSecs1]),
  io:format("~w~n", [math:pow(X, Y)]),
  {MegaSecs2, Secs2, MicroSecs2} = erlang:timestamp(),
%%  io:format("~w~n",[MegaSecs2]),
%%  io:format("~w~n",[Secs1]),
%%  io:format("~w~n",[MicroSecs1]),

  (MegaSecs2 - MegaSecs1) * 1000000000000 + (Secs2 - Secs1) * 1000000 + (MicroSecs2 - MicroSecs1).
practice_3_2() ->
  {Year, Month, Day} = erlang:date(),
  {Hour, Minute, Second} = erlang:time(),
  io:format("~w/~w/~w:~w:~w:~w~n", [Year, Month, Day, Hour, Minute, Second]).

start() ->
  io:format("~ts~n", ["********practice_1********"])
  , io:format("~w~n", [practice_1("circle", {10, 10})])
  , io:format("~w~n", [practice_1("triangle", {10, 10})])
  , io:format("~ts~n", ["********practice_2********"])
  , io:format("~w~n", [tuple_to_list({1, 2, 3, 4})])
  , io:format("~w~n", [practice_2({1, 2, 3, 4})])
  , io:format("~w~n", [practice_2_1({1, 2, 3, 4})])
  , io:format("~w~n", [practice_2_2({1, 2, 3, 4})])
  , io:format("~s~n", ["****practice_3****"])
  , io:format("~w~n", [practice_3_1(2, 1000)])
  , io:format("~w~n", [practice_3_2()])
.

