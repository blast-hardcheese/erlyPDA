#!/usr/bin/env escript

main([Input, RulesPath]) ->
    test(Input, RulesPath);

main([]) ->
    test("0000111"),
    test("00111"),
    test("00000000111111"),
    test("00001110"),
    test("").

test(Input) ->
    test(Input, "1.rules").

test(Input, RulesPath) ->
    Rules = rules:build_rules(RulesPath),
    case parse(Input, p0, [z0], Rules) of
        ok -> io:format("~p conforms to the language!~n", [Input]);
        failure -> io:format("~p does not conform to the language.~n", [Input])
    end.

parse(_Input, _State, [], _Rules) ->
    failure;

parse([], State, Stack, Rules) ->
    Top = hd(Stack),
    case rule(State, e, Top, Stack, Rules) of
        {ok, _, []} -> ok;
        _ -> failure
    end;

parse(Input, State, Stack, Rules) ->
    Head = [hd(Input)],
    Top = hd(Stack),
    Rest = tl(Input),

    io:format("rule(~p ~p ~p ~p) -> ", [State, Head, Top, Stack]),
    Res = rule(State, Head, Top, Stack, Rules),
    io:format("~p~n", [Res]),
    case Res of
        {ok, _, []} -> ok;
        {ok, NextState, NextStack} -> parse(Rest, NextState, NextStack, Rules);
        {failure, _, _} -> failure
    end.

applyNext({failure, {State, _Next, _Top}}, Stack) ->
    {failure, State, Stack};

applyNext({transition, NextState, e}, Stack) ->
    {ok, NextState, tl(Stack)};

applyNext({transition, NextState, _Preserve}, Stack) ->
    {ok, NextState, Stack};

applyNext({transition, NextState, Push, _Existing}, Stack) ->
    {ok, NextState, [Push | Stack]}.

rule(State, Head, Top, Stack, Rules) ->
    applyNext(rules:match({State, Head, Top}, Rules), Stack).
