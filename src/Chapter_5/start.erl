%%%-------------------------------------------------------------------
%%% @author liuxu
%%% @copyright (C) 2022, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 04. 1月 2022 3:15 PM
%%%-------------------------------------------------------------------
-module(start).
-author("liuxu").

%% API
-include("records.hrl").
-export([
%%  clear_status/0
  count_characters/0
]).
%% 计算字符串里各个字符的出现次数
count_characters()->
  Str="hello",
  count_characters(Str)
  ,io:format("~ts~n",[maps:values(count_characters(Str))])
.
count_characters(Str)->
  count_characters(Str,#{}).
count_characters([H|T], X) ->
  case maps:is_key(H,X) of
    false -> count_characters(T, maps:put(H,1,X));
    true  -> Count = maps:get(H,X),
      count_characters(T, maps:update(H,Count+1,X))
  end;
count_characters([], X) ->
  X.
%% 写法过时了，不再支持,#{H=>N}=X这种=>写法，需要用到maps模块
%%在 Erlang/opt 17中
%%- No variable keys (key中不能含变量)
%%- No single value access (不支持取单个value，即不支持#{Key}操作)
%%- No map comprehensions (不支持map推导，例如 #{X => foggy || X <- [london,boston]}.)
%%count_characters([H|T],#{H=>N}=X)->
%%  count_characters(T,X#{H:=N+1});
%%count_characters([H|T],X)->
%%  count_characters(T,X#{H=>1});
%%count_characters([],X)->
%%  X.
%%clear_status()->
  %% 在此函数内部，S和W绑定了记录里面的字段
  %% values in the records
  %%
  %% R是"整个"记录
%%  R={},
%%  #todo{status = S,who = W}=R,
%%  io:format("~s~n",[S]),
%%  io:format("~s~n",[W]),
%%  R#todo{status = finished}.
