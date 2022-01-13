%%%-------------------------------------------------------------------
%%% @author liuxu
%%% @copyright (C) 2022, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 13. 1月 2022 7:43 PM
%%%-------------------------------------------------------------------
-module(section_3).
-author("liuxu").

%% API
%(3).编写一个环形计时测试。创建一个由N个进程组成的环。
% 把一个消息沿着环发送M次，这样总共发送的消息是M*N。
% 记录不同的N和M值所花费的时间
% 用你熟悉的其他编程语言编写一个类似的程序，然后比较一下结果。
% 写一篇博客，把结果在网上发表出来。
-export([start/2]).

% N 个进程， M 次
start(N,M) -> start1(N,N*M).
start1(N, M) ->
  sendstart(M, createProcess(N)).

% 创建 N 个进程
createProcess(N) ->
  L = for(1, N, fun() -> spawn(fun() -> loop() end) end),
  L.

% 起始
sendstart(M, L) ->
  % 给第一个进程发送请求，开始绕环发送消息
  Pid = getPid(1, L, M),
  Pid ! {1, L, M, "hello world"}.

% 进程执行的函数
loop() ->
  receive
  % {1, [1,2,3,4,5], "hello world"}
    {I, L, M, Message} ->
      io:format("Pid:~p Recv Message:~p~n", [(I rem lists_size(L))+1,Message]),
      % 发送给下一个进程
      case getPid(I+1, L, M) of
        none -> io:format("have send...~n");
        Pid  -> Pid ! {I+1, L, M, Message},
          loop()
      end
  end.

% 获得进程的 Pid。
getPid(I, L, M) ->
  io:format("...........I:~p~n", [I]),
  case lists_size(L) of
    Size when I =< Size ->
      lists:nth(I, L);
    % 注意余数为 0
    Size when I > Size, I rem Size =:= 0 ->
      lists:nth(Size, L);
    Size when I > Size, I =< M ->
      lists:nth((I rem Size), L);
    Size when I > M ->
      none
  end.

for(Max, Max, F) -> [F()];
for(I, Max, F)   -> [F() | for(I+1, Max, F)].


% 计算lists大小函数
lists_size(L) ->
  lists_size(L, 0).
lists_size([_|T], Size) ->
  lists_size(T, Size+1);
lists_size([], Size) ->
  Size.