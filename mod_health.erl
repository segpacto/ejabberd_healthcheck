%%% ---------------------------------------
%%% Health check for SSL, MySql on ejabberd
%%% ---------------------------------------

-module(mod_health).

-export([process/2]).
-export([get_all_status/0]).

-include("ejabberd.hrl").
-include("logger.hrl").
-include("jlib.hrl").
-include("ejabberd_http.hrl").

-import(lists, [duplicate/2, flatlength/1]).


% application constants
-define(MYSQL, mysql).
-define(EJABBERD, ejabberd).
-define(SSL, ssl).
%% add additional applications

process([], #request{method = 'GET', path = [<<"healthcheck">>]}) ->
    StatusList = get_all_status(),
    StatusLength = flatlength(StatusList),
    ExpectedStatusListResult = duplicate(StatusLength, true),
    if
        StatusList == ExpectedStatusListResult ->
            {204, [], <<"">>};
        true ->
            {503, [], <<"">>}
    end.

get_all_status() ->
  	EJABBERDStatus = lists:keymember(?EJABBERD, 1, application:which_applications()),
  	MYSQLStatus = lists:keymember(?MYSQL, 1, application:which_applications()),
  	SSLStatus = lists:keymember(?SSL, 1, application:which_applications()),
  	?DEBUG("MOD_HEALTHCHECK checking status of Ejabberd : ~p\nMYSQL : ~p\nSSL : ~p", [EJABBERDStatus,MYSQLStatus,SSLStatus]),
    [EJABBERDStatus, MYSQLStatus, SSLStatus].
