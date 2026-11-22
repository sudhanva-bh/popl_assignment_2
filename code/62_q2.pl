split_numbers(List, Left, Right) :-
    append(Left, Right, List),
    Left = [_|_],
    Right = [_|_].

apply_operator(+, Left, Right, Value) :-
    Value is Left + Right.

apply_operator(-, Left, Right, Value) :-
    Value is Left - Right.

apply_operator(*, Left, Right, Value) :-
    Value is Left * Right.

apply_operator(/, Left, Right, Value) :-
    Right =\= 0,
    0 is Left mod Right,
    Value is Left // Right.
