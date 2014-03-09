#!/usr/bin/env escript

main([]) ->
    io:format("Parse: ~p~n", [parse("0000111", p0, ['z0'])]),
    test("0000111"),
    test("00111"),
    test("00000000111111"),
    test("").

test(_Input) ->
    failure.

buildAtom(Input) -> list_to_atom([Input]).

parse(Input, State, Stack) ->
    Head = buildAtom(hd(Input)),
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

transition(State, _, Stack) -> {failure, State, Stack}.

transition(State, Push, Last, Stack) ->
    Top = hd(Stack),
    if
        Last == Top -> {ok, State, [Push | Stack]};
        true -> {failure, State, Stack}
    end.

rule(p0, 'e', 'z0', Stack) -> transition(p0, 'e', Stack);
rule(p0, '0', 'z0', Stack) -> transition(p1, '0', 'z0', Stack);
rule(p0, '0', '0', Stack)  -> transition(p1, '0', '0', Stack);
rule(p1, '0', '0', Stack)  -> transition(p2, '0', '0', Stack);
rule(p2, '0', '0', Stack)  -> transition(p3, '0', '0', Stack);
rule(p3, '0', '0', Stack)  -> transition(p0, '0', Stack);
rule(p0, '1', '0', Stack)  -> transition(p4, 'e', Stack);
rule(p4, '1', '0', Stack)  -> transition(p4, 'e', Stack);
rule(p4, 'e', 'z0', Stack) -> transition(p4, 'e', Stack).
