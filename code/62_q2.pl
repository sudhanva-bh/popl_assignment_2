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

expression([N], num(N), N).

expression(Numbers, op(Op, LeftTree, RightTree), Value) :-
    split_numbers(Numbers, LeftNumbers, RightNumbers),
    expression(LeftNumbers, LeftTree, LeftValue),
    expression(RightNumbers, RightTree, RightValue),
    apply_operator(Op, LeftValue, RightValue, Value).
