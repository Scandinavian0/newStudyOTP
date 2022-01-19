%%%-------------------------------------------------------------------
%%% @author liuxu
%%% @copyright (C) 2022, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 17. 1月 2022 7:37 PM
%%%-------------------------------------------------------------------
-module(lib_misc).
-author("liuxu").

%% API
%% 容错式编程，在进行终止式执行擦欧总
-export([on_exit/2]).

on_exit(Pid, Fun) ->
  spawn(fun() ->
    Ref=monitor(process,Pid),
    receive
      {'DOWN',Ref,process,Pid,Why}->
        Fun(Why)
        end
    end
  ).

