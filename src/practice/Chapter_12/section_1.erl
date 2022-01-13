%%%-------------------------------------------------------------------
%%% @author liuxu
%%% @copyright (C) 2022, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 13. 1月 2022 5:34 PM
%%%-------------------------------------------------------------------
-module(section_1).
-author("liuxu").

%% API
-export([create/2]).
start(Antom, Fun) ->
  case whereis(Antom) of
    undifind ->
      register(Antom, Fun),
      io:format("pricess is registered,name:~p~n", [Antom]);
    Pid->
      io:format("this AnAtom have registered~p~n,",[Pid])
  end.

create(Antom,Fun)->
  start(Antom,Fun),
  start(Antom,Fun).