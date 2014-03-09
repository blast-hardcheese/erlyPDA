#!/usr/bin/env escript

main([]) ->
    io:format("Rule: ~p~n", [rule(p0, '0', 'z0', ['z0'])]),
    test("0000111"),
    test("00111"),
    test("00000000111111"),
    test("").

test(_Input) ->
    failure.

transition(_, _, _) -> failure.
transition(_, _, _, _) -> failure.

rule(p0, 'e', 'z0', Stack) -> transition(p0, 'e', Stack);
rule(p0, '0', 'z0', Stack) -> transition(p1, '0', 'z0', Stack);
rule(p0, '0', '0', Stack)  -> transition(p1, '0', '0', Stack);
rule(p1, '0', '0', Stack)  -> transition(p2, '0', '0', Stack);
rule(p2, '0', '0', Stack)  -> transition(p3, '0', '0', Stack);
rule(p3, '0', '0', Stack)  -> transition(p0, '0', Stack);
rule(p0, '1', '0', Stack)  -> transition(p4, 'e', Stack);
rule(p4, '1', '0', Stack)  -> transition(p4, 'e', Stack);
rule(p4, 'e', 'z0', Stack) -> transition(p4, 'e', Stack).
