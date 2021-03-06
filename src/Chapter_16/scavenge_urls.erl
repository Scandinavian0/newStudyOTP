%%%-------------------------------------------------------------------
%%% @author liuxu
%%% @copyright (C) 2022, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 26. 1月 2022 4:01 PM
%%%-------------------------------------------------------------------
-module(scavenge_urls).
-author("liuxu").

%% API
-export([urls2htmlFile/2, bin2urls/1]).
-import(lists, [reverse/1, reverse/2, map/2]).

%% 返回一个io列表
urls2htmlFile(Urls, File) ->
  file:write_file(File, urls2html(Urls)).

bin2urls(Bin) ->
  gather_urls(binary_to_list(Bin), []).

urls2html(Urls) -> [h1("Urls"), make_list(Urls)].

h1(Title) -> ["<h1>", Title, "</h1>|n"].

make_list(L) ->
  ["<ul>|n",
    map(fun(I) -> ["<li>", I, "</li>|n"] end, L),
    "</ul>|n"].

%% 从二进制里提取url的代码
gather_urls("<a href" ++ T, L) ->
  {Url, T1} = collect_url_body(T, reverse("<a href")),
  gather_urls(T1, [Url | L]);
gather_urls([_ | T], L) ->
  gather_urls(T, L);
gather_urls([], L) ->
  L.

collect_url_body("</a>" ++ T, L) ->
  {reverse(L, "</a>"), T};
collect_url_body([H | T], L) -> collect_url_body(T, [H | L]);
collect_url_body([], _) ->{[],[]}.

%%  TODO socket_examples:nano_get_url 见后续的17章代码17。1。1的代码

