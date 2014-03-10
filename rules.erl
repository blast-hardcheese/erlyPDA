-module(rules).
-export([
         build_rules/1,
         match/2
        ]).

find_match({State, Next, Top}) ->
    fun({{RuleState, RuleNext, RuleTop}, Transition}, Acc) ->
        if
            (State == RuleState) and (Next == RuleNext) and (Top == RuleTop) -> Transition;
            true -> Acc
        end
    end.

match(Current, Rules) ->
    lists:foldl(find_match(Current), {failure, Current}, Rules).

% {Current, Transition}
build_rules(Path) ->
    {ok, Rules} = file:consult(Path),
    Rules.
