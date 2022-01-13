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
%(1).编写一个start(AnAtom, Fun)函数来把spawn(Fun)注册为AnAtom。
% 确保当两个并行的进程同时执行start/2时你的程序也能正确工作。
% 在这种情况下，必须保证其中一个进程会成功执行而另一个会失败。
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