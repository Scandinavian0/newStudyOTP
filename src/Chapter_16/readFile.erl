%%%-------------------------------------------------------------------
%%% @author liuxu
%%% @copyright (C) 2022, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 25. 1月 2022 4:44 PM
%%%-------------------------------------------------------------------
-module(readFile).
-author("liuxu").

%% API
%% 读取文件
-export([start/0]).
start() ->
  Path = "/Users/liuxu/learnCode/erlang- program/newStudyOTP/src/File/data1.dat",
  Result = read_file(Path),
  io:format("Result: ~p~n", [Result]),
  ChangeGroup = file_change_group(Path),
  io:format("ChangeGroup: ~p~n", [ChangeGroup]),
  ChangeOwner = file_change_owner(Path),
  io:format("ChangeOwner: ~p~n", [ChangeOwner]),
%%  ReadResult=file_read_file(Path),
%%  io:format("ReadResult : ~p~n",ReadResult)
  ReadFile=file_read_file(Path),
  io:format("ReadFile : ~p~n",[ReadFile])
.

read_file(Path) ->
  file:consult(Path).
file_change_group(Path)->
  file:change_group(Path,1).
file_change_owner(Path)->
  file:change_group(Path,1).
file_read_file(Path)->
  file:read_file(Path).
