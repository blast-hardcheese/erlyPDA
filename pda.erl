#!/usr/bin/env escript

main([]) ->
    test("0000111"),
    test("00111"),
    test("00000000111111"),
    test("00001110"),
    test("").

test(Input) ->
    case parse(Input, p0, [z0]) of
        ok -> io:format("~p conforms to the language!~n", [Input]);
        failure -> io:format("~p does not conform to the language.~n", [Input])
    end.

parse(_, _, []) ->
    failure;

parse([], State, Stack) ->
    Top = hd(Stack),
    case rule(State, 'e', Top, Stack) of
        {ok, _, []} -> ok;
        _ -> failure
    end;

parse(Input, State, Stack) ->
    Head = hd(Input),
    Top = hd(Stack),
    Rest = tl(Input),

    io:format("rule(~p ~p ~p ~p) -> ", [State, Head, Top, Stack]),
    Res = rule(State, Head, Top, Stack),
    io:format("~p~n", [Res]),
    case Res of
        {ok, _, []} -> ok;
        {ok, NextState, NextStack} -> parse(Rest, NextState, NextStack);
        {failure, _, _} -> failure
    end.

transition(NextState, 'e', Stack) ->
    {ok, NextState, tl(Stack)};

transition(NextState, Top, Stack) ->
    Top = hd(Stack),
    {ok, NextState, Stack}.

transition(State, Push, Last, Stack) ->
    Top = hd(Stack),
    if
        Last == Top -> {ok, State, [Push | Stack]};
        true -> {failure, State, Stack}
    end.

rule(p0, 'e', z0, Stack) -> transition(p0, 'e', Stack);
rule(p0, $0, z0, Stack)  -> transition(p1, $0, z0, Stack);
rule(p0, $0, $0, Stack)  -> transition(p1, $0, $0, Stack);
rule(p1, $0, $0, Stack)  -> transition(p2, $0, $0, Stack);
rule(p2, $0, $0, Stack)  -> transition(p3, $0, $0, Stack);
rule(p3, $0, $0, Stack)  -> transition(p0, $0, Stack);
rule(p0, $1, $0, Stack)  -> transition(p4, 'e', Stack);
rule(p4, $1, $0, Stack)  -> transition(p4, 'e', Stack);
rule(p4, 'e', z0, Stack) -> transition(p4, 'e', Stack);
rule(State, _, _, Stack) -> {failure, State, Stack}.
