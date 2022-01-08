%%%-------------------------------------------------------------------
%%% @author liuxu
%%% @copyright (C) 2022, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 06. 1月 2022 3:54 PM
%%%-------------------------------------------------------------------
-module(mp3_sync).
-author("liuxu").

%% API
-export([]).
%% 同步程序
%% 为了找到同步点，首先假设成功定位到了某一个MPEG头的其实位置，然后是这计算该帧的长度
%% 如果假设正确，因此当前向前跳过帧长后，会找到另一个MPEG头
%% 如果假设错误，可能没有定位到标记MPEG头的其实位置的位序列上，或者因为字的格式不正确无法计算帧长。
%% 假设错误，但是定位到的若干字节音乐数据碰巧和MPEG头的起始位置相似，那么可以计算帧长，但是当向前跳过这段距离后，无法找到新的MPEG头
%% 所以找三个连续的MPEG头。

%% find_sync 尝试寻找三个连续的MPEG头帧，如果Bin第N个字节是某个头帧的开头，is_header(N,Bin)就会返回{ok,Length,Info}.
find_sync(Bin, N) ->
  case is_header(N, Bin) of
    {ok, Len1, _} ->
      case is_header(N + 1, Bin) of
        {ok, Len2, _} ->
          case is_header(N + Len1 + Len2, Bin) of
            {ok, _, _} ->
              {ok, N};
            error ->
              find_sync(Bin, N + 1)
          end;
        error ->
          find_sync(Bin, N + 1)
      end;
    error ->
      find_sync(Bin, N + 1)
  end.
%%  首先，提取32位数据进行分析（get_word实现），然后用decode_header解包帧头。
%% 现在便携代码，让decode_header在参数不是帧头的开头时崩溃，通过调用exit/1实现。
%% 为了捕捉任何可能的错误，在一个try...catch 语句里对decode_header进行调用。
%% 还会捕捉到任何由framelength/4里的错误代码所导致的潜在错误。
is_header(N, Bin) ->
  unpack_header(get_word(N, Bin)).

get_word(N, Bin) ->
  {_, <<C:4/binary, _/binary>>} = split_binary(Bin, N),
  C.
unpack_header(X) ->
  try
    decode_header(X)
  catch
    _:_ -> error
  end.

decode_header(<<2#11111111111:11, B:2, C:2, _D:1, E:4, F:2, G:1, Bits:9>>) ->
  Vsn = case B of
          0 -> {2, 5};
          1 -> exit(badVsn);
          2 -> 2;
          3 -> 1
        end,
  Layer = case C of
            0 -> exit(badLayer);
            1 -> 3;
            2 -> 2;
            3 -> 1
          end,
  %% Protection = D,
  BitRate = bitrate(Vsn, Layer, E) * 1000,
  SampleRate = sampleRate(Vsn, F),
  Padding = G,
  FrameLength = frameLength(Layer, BitRate, SampleRate, Padding),
  if
    FrameLength < 21 ->
      exit(frameSize);
    true ->{ok,FrameLength,{Layer,BitRate,SampleRate,Vsn,Bits}}
  end;
decode_header(_)->
  exit(badHeader).

