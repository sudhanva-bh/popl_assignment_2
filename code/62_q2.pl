split_numbers(List, Left, Right) :-
    append(Left, Right, List),
    Left = [_|_],
    Right = [_|_].
