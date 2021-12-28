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
    "triangle" -> (L*W)/2
  end.

practice_2(T)->

;
practice_2([])->[].
start() ->
  io:format("~ts~n",["********practice_1********"])
  ,io:format("~w~n",[practice_1("circle",{10,10})])
  ,io:format("~w~n",[practice_1("triangle",{10,10})])
  ,io:format("~ts~n",["********practice_2********"])
  ,io:format("~w~n",[tuple_to_list({1,2,3,4})])
  ,io:format("~w~n",[])

.

