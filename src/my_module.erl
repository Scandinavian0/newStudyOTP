%%%-------------------------------------------------------------------
%%% @author liuxu
%%% @copyright (C) 2021, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 24. 11月 2021 2:27 下午
%%%-------------------------------------------------------------------
-module(my_module).
-author("liuxu").

%% API
-export([print/1, either_or_both/2, area/1, newArea/1, sign/1, newSign/1, funFunction/2, ovrrideCatch/0, do_somthing/0]).

print(Term) ->
  io:format("The value of Term is : ~w.~n", [Term]).
either_or_both(true, B) when is_boolean(B) -> true;
either_or_both(A, true) when is_boolean(A) -> true;
either_or_both(false, false) -> false.

area({circle, Radius}) ->
  Radius * Radius * math:pi();
area({square, Side}) ->
  Side * Side;
area({rectangle, Height, Width}) ->
  Height * Width.

newArea(Shape) ->
  case Shape of
    {circle, Radius} ->
      Radius * Radius * math:pi();
    {square, Side} ->
      Side * Side;
    {rectangle, Height, Width} ->
      Height * Width
  end.

%% if 表达式
sign(N) when is_number(N) ->
  if
    N > 0 -> positive;
    N < 0 -> negative;
    true -> zero
  end.

%%% 用case来表示上面的函数
newSign(N) when is_number(N) ->
  case dummy of
    _ when N > 0 -> positive;
    _ when N < 0 -> negative;
    _ when true -> zero
  end.

%% 作为现有别名的fun函数的函数
funFunction(Boolean, Number) ->
  F = fun either_or_both/2.
%%  yesno(F)->
%%    case F(true,false) of
%%      true -> io:format("yes~n");
%%      false -> io:format("no~n")
%%    end.
%%  yesno(fun({A, B} -> A or B end)


%%重抛异常 ps 旧的语法过时了，这是21的新语法
ovrrideCatch() ->
  try
    do_somthing()
  catch
    Class:Reason:Stacktrace ->
      {Class,Reason,Stacktrace}
  end.








do_somthing() ->
  erlang:error(not_implemented).

analyze_exc(Class, Reason) ->
  erlang:error(not_implemented).

handle_exc(Class, Reason, Trace) ->
  erlang:error(not_implemented).