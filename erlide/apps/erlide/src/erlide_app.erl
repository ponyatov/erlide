%%%-------------------------------------------------------------------
%% @doc erlide public API
%% @end
%%%-------------------------------------------------------------------

-module(erlide_app).

-behaviour(application).

-export([start/2, stop/1]).

start(_StartType, _StartArgs) ->
    erlide_sup:start_link().

stop(_State) ->
    ok.

%% internal functions
