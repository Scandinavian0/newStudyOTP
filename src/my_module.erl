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
-export([print/1, either_or_both/2, area/1, newArea/1,sign/1,newSign/1]).

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
%%% if 表达式
sign(N) when is_number(N)->
  if
    N>0 -> positive;
    N<0 -> negative;
    true -> zero
  end.
%%% 用case来表示上面的函数

