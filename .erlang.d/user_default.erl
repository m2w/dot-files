-module(user_default).
-compile([export_all]).

-author("moritz@tibidat.com").

-include_lib("include/webmachine_logger.hrl").
-include_lib("include/wm_reqstate.hrl").
-include_lib("include/wm_reqdata.hrl").

%%--------------------------------------------------------------------
%% Utility Wrappers
%%--------------------------------------------------------------------
make() ->
    make:all([load]).

print(Val) when is_list(Val) ->
    io:format(Val);
print(Val) ->
    io:format("~p", [Val]).
println(Val) when is_list(Val) ->
    print(Val ++ "~n");
println(Val) ->
    io:format("~p~n", [Val]).

%%--------------------------------------------------------------------
%% Shortcuts for the lazy
%%--------------------------------------------------------------------
cmd(Command) ->
    pn(os:cmd(Command)).

p(Val) ->
    print(Val).
p(S, Args) ->
    io:format(S, Args).

pn(Val) ->
    println(Val).
pn(S, Args) ->
    p(S ++ "~n", [Args]).

bug() ->
    debugger:start().

debug(Mod) ->
    dbg:start(),
    dbg:tracer(),
    dbg:tpl(Mod, '_', [{'_', [], [{return_trace}]}]),
    dbg:p(all, c).
debug(Mod, Fun) ->
    dbg:start(),
    dbg:tracer(),
    dbg:tpl(Mod, Fun, '_', [{'_', [], [{return_trace}]}]),
    dbg:p(all, c).
dbg_safe(Mod, Fun, Lim) ->
    dbg:start(),
    dbg:tracer(process,
	       {fun (_, N) when N >= Lim  ->
			dbg:stop_clear();
		    (Msg, N) ->
			io:format("~p~n", [Msg]),
			N+1
		end,
		0
	       }),
    dbg:tpl(Mod, Fun, '_', [{'_', [], [{return_trace}]}]),
    dbg:p(all, c).

debug_off() ->
    dbg:stop_clear().

%% the code for reloading modules is taken from
%% https://github.com/ibnHatab/femto_test/blob/63bf244d70e9724d597259aa0d1370ae94fa38b0/apps/eunit_tools/src/user_default.erl
l() ->
    [c:l(M) || M <- mm()].

mm() ->
    modified_modules().

modified_modules() ->
    [M || {M, _} <- code:all_loaded(),
	  module_modified(M) == true].

module_modified(Module) ->
    case code:is_loaded(Module) of
	{file, preloaded} ->
	    false;
	{file, Path} ->
	    CompileOpts =
		proplists:get_value(compile, Module:module_info()),
	    CompileTime = proplists:get_value(time, CompileOpts),
	    Src = proplists:get_value(source, CompileOpts),
	    module_modified(Path, CompileTime, Src);
	_ ->
	    false
    end.

module_modified(Path, PrevCompileTime, PrevSrc) ->
    case find_module_file(Path) of
	false ->
	    false;
	ModPath ->
	    case beam_lib:chunks(ModPath, ["CInf"]) of
		{ok, {_, [{_, CB}]}} ->
		    CompileOpts =  binary_to_term(CB),
		    CompileTime = proplists:get_value(time,
						      CompileOpts),
		    Src = proplists:get_value(source, CompileOpts),
		    not (CompileTime == PrevCompileTime)
			and (Src == PrevSrc);
		_ ->
		    false
	    end
    end.

find_module_file(Path) ->
    case file:read_file_info(Path) of
	{ok, _} ->
	    Path;
	_ ->
	    case code:where_is_file(filename:basename(Path)) of
		non_existing ->
		    false;
		NewPath ->
		    NewPath
	    end
    end.

la() ->
    FiltZip = lists:filter(
		fun({_Mod, Path}) when is_list(Path) ->
			case string:str(Path, "/kernel-") +
			    string:str(Path, "/stdlib-") of
			    0 -> true;
			    _ -> false
			end;
		   (_) -> false
		end,
		code:all_loaded()),
    {Ms, _} = lists:unzip(FiltZip),
    lists:foldl(fun(M, Acc) ->
			case shell_default:l(M) of
			    {error, _} ->
				Acc;
			    _ ->
				[M|Acc]
			end
		end, [], Ms).

%%--------------------------------------------------------------------
%% Add minimal documentation for the custom functions
%% Note that all methods are exported but only the "API" is actually
%% documented, this is by design.
%%--------------------------------------------------------------------
help() ->
    shell_default:help(),
    pn("** Custom Utilities **"),
    pn("debug_off()          -- Terminate the current trace."),
    pn("debug(M)             -- Trace all calls to the module."),
    pn("debug(M, F)          -- Trace all calls to M:F (any arity)."),
    pn("dbg_safe(M, F, N)    -- Trace all calls to M:F (any arity),"
       "but automatically terminate after N events."),
    pn("la()                 -- (re)load all modules."),
    pn("l()                  -- reload all changed modules."),
    pn("mm()                 -- list all changed modules."),
    pn("** Custom Shortcuts **"),
    pn("make()               -- Run Emake in the current directory."),
    pn("p[n](Val)            -- Wrappers around io:format."),
    pn("p[n](Fmt, Args)      -- Wrappers around io:format."),
    pn("cmd(CmdString)       -- Runs CmdString using os:cmd."),
    pn("d()                  -- Fires up the debugger."),
    true.
