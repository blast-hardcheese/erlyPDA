erlyPDA
=======

Initial attempt at implementing a pushdown automaton in Erlang.

    rule(p0 48 z0 [z0]) -> {ok,p1,[48,z0]}
    rule(p1 48 48 [48,z0]) -> {ok,p2,[48,48,z0]}
    rule(p2 48 48 [48,48,z0]) -> {ok,p3,[48,48,48,z0]}
    rule(p3 48 48 [48,48,48,z0]) -> {ok,p0,[48,48,48,z0]}
    rule(p0 49 48 [48,48,48,z0]) -> {ok,p4,[48,48,z0]}
    rule(p4 49 48 [48,48,z0]) -> {ok,p4,[48,z0]}
    rule(p4 49 48 [48,z0]) -> {ok,p4,[z0]}
    "0000111" conforms to the language!

    rule(p0 48 z0 [z0]) -> {ok,p1,[48,z0]}
    rule(p1 48 48 [48,z0]) -> {ok,p2,[48,48,z0]}
    rule(p2 49 48 [48,48,z0]) -> {failure,p2,[48,48,z0]}
    "00111" does not conform to the language.

    rule(p0 48 z0 [z0]) -> {ok,p1,[48,z0]}
    rule(p1 48 48 [48,z0]) -> {ok,p2,[48,48,z0]}
    rule(p2 48 48 [48,48,z0]) -> {ok,p3,[48,48,48,z0]}
    rule(p3 48 48 [48,48,48,z0]) -> {ok,p0,[48,48,48,z0]}
    rule(p0 48 48 [48,48,48,z0]) -> {ok,p1,[48,48,48,48,z0]}
    rule(p1 48 48 [48,48,48,48,z0]) -> {ok,p2,[48,48,48,48,48,z0]}
    rule(p2 48 48 [48,48,48,48,48,z0]) -> {ok,p3,[48,48,48,48,48,48,z0]}
    rule(p3 48 48 [48,48,48,48,48,48,z0]) -> {ok,p0,[48,48,48,48,48,48,z0]}
    rule(p0 49 48 [48,48,48,48,48,48,z0]) -> {ok,p4,[48,48,48,48,48,z0]}
    rule(p4 49 48 [48,48,48,48,48,z0]) -> {ok,p4,[48,48,48,48,z0]}
    rule(p4 49 48 [48,48,48,48,z0]) -> {ok,p4,[48,48,48,z0]}
    rule(p4 49 48 [48,48,48,z0]) -> {ok,p4,[48,48,z0]}
    rule(p4 49 48 [48,48,z0]) -> {ok,p4,[48,z0]}
    rule(p4 49 48 [48,z0]) -> {ok,p4,[z0]}
    "00000000111111" conforms to the language!

    rule(p0 48 z0 [z0]) -> {ok,p1,[48,z0]}
    rule(p1 48 48 [48,z0]) -> {ok,p2,[48,48,z0]}
    rule(p2 48 48 [48,48,z0]) -> {ok,p3,[48,48,48,z0]}
    rule(p3 48 48 [48,48,48,z0]) -> {ok,p0,[48,48,48,z0]}
    rule(p0 49 48 [48,48,48,z0]) -> {ok,p4,[48,48,z0]}
    rule(p4 49 48 [48,48,z0]) -> {ok,p4,[48,z0]}
    rule(p4 49 48 [48,z0]) -> {ok,p4,[z0]}
    rule(p4 48 z0 [z0]) -> {failure,p4,[z0]}
    "00001110" does not conform to the language.

    [] conforms to the language!
