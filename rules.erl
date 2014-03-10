-module(rules).
-export([
         build_rules/1,
         match/1
        ]).

find_match({State, Next, Top}) ->
    fun({{RuleState, RuleNext, RuleTop}, Transition}, Acc) ->
        if
            (State == RuleState) and (Next == RuleNext) and (Top == RuleTop) -> Transition;
            true -> Acc
        end
    end.

%match({State, Next, Top}) ->
match(Current) ->
    match(Current, build_rules("rules.txt")).

match(Current, Rules) ->
    lists:foldl(find_match(Current), {failure, Current}, Rules).

% {Current, Transition}
build_rules(_Path) ->
    [
        {{p0, e, z0},    {transition, p0, e}},
        {{p0, "0", z0},  {transition, p1, "0", z0}},
        {{p0, "0", "0"}, {transition, p1, "0", "0"}},
        {{p1, "0", "0"}, {transition, p2, "0", "0"}},
        {{p2, "0", "0"}, {transition, p3, "0", "0"}},
        {{p3, "0", "0"}, {transition, p0, "0"}},
        {{p0, "1", "0"}, {transition, p4, e}},
        {{p4, "1", "0"}, {transition, p4, e}},
        {{p4, e, z0},    {transition, p4, e}}
    ].
