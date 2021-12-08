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
-export([for/3,start/0]).

for(Max, Max, F) -> [F(Max)];
for(I, Max, F) -> [F(I) | for(I + 1, Max, F)].

start()->
   io:format("~w~n",[for(1,10,fun(I)->I*I end)])
%%   io:format("~w~n",[for(10,10,fun(I)->I*I end)])

.
