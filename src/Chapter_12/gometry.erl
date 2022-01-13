%%%-------------------------------------------------------------------
%%% @author liuxu
%%% @copyright (C) 2022, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 13. 1月 2022 10:41 AM
%%%-------------------------------------------------------------------
-module(gometry).
-author("liuxu").

%% API
-export([]).
area({rectangle, Width, Height}) -> Width * Height;
area({square, Side}) -> Side * Side.
