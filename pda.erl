#!/usr/bin/env escript

main([]) ->
    test("0000111"),
    test("00111"),
    test("00000000111111"),
    test("").

test(_Input) ->
    failure.
