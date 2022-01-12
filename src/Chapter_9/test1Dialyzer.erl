%%%-------------------------------------------------------------------
%%% @author liuxu
%%% @copyright (C) 2022, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 11. 1月 2022 3:21 PM
%%%-------------------------------------------------------------------
-module(test1Dialyzer).
-author("liuxu").

%% APIcd
-export([f1/0]).
f1()->
  X=erlang:time(),
  seconds(X).

seconds({_Year,_Month,_Day,Hour,Min,Sec})->
  (Hour*60+Min)*60+Sec.
