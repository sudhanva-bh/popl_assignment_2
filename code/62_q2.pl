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

precedence(+, 1).
precedence(-, 1).
precedence(*, 2).
precedence(/, 2).

needs_parentheses(left, ParentOp, op(ChildOp, _, _)) :-
    precedence(ParentOp, ParentLevel),
    precedence(ChildOp, ChildLevel),
    ChildLevel < ParentLevel.

needs_parentheses(right, ParentOp, op(ChildOp, _, _)) :-
    precedence(ParentOp, ParentLevel),
    precedence(ChildOp, ChildLevel),
    ChildLevel =< ParentLevel.

format_expression(num(N), String) :-
    number_string(N, String).

format_expression(op(Op, Left, Right), String) :-
    format_expression(Left, LeftString),
    format_expression(Right, RightString),

    ( needs_parentheses(left, Op, Left) ->
        format(string(FormattedLeft), "(~s)", [LeftString])
    ;
        FormattedLeft = LeftString
    ),

    ( needs_parentheses(right, Op, Right) ->
        format(string(FormattedRight), "(~s)", [RightString])
    ;
        FormattedRight = RightString
    ),

    format(string(String), "~s~w~s",
           [FormattedLeft, Op, FormattedRight]).

generate_equation(List, Equation) :-
    split_numbers(List, LeftNumbers, RightNumbers),
    expression(LeftNumbers, LeftTree, Value),
    expression(RightNumbers, RightTree, Value),
    format_expression(LeftTree, LeftString),
    format_expression(RightTree, RightString),
    format(string(Equation), "~s=~s", [LeftString, RightString]).

all_equations(List, Equations) :-
    findall(Equation, generate_equation(List, Equation), All),
    sort(All, Equations).

count_equations(List, N) :-
    all_equations(List, Equations),
    length(Equations, N).
