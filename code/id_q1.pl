:- use_module(library(lists)).

% candidate(-Solution): Solution is a list of four p(Name, Dept, Lang, Project)
% terms in the order Alex, Ben, Carla, Dana, where the four departments, the
% four languages and the four projects are each a permutation of their values.
candidate([ p('Alex',  D1, L1, P1),
            p('Ben',   D2, L2, P2),
            p('Carla', D3, L3, P3),
            p('Dana',  D4, L4, P4) ]) :-
    permutation([research, development, design, testing],   [D1, D2, D3, D4]),
    permutation([python, java, 'c++', javascript],          [L1, L2, L3, L4]),
    permutation(['AI', web, embedded, data],                [P1, P2, P3, P4]).

% CLUE 1: The friend who prefers the AI project does not work in research and is not Dana.
clue(1, Solution) :-
    memberchk(p(Name, Dept, _, 'AI'), Solution),
    Name \== 'Dana',
    Dept \== research.

% CLUE 2: Alex does not work in development and does not prefer C++.
clue(2, Solution) :-
    memberchk(p('Alex', Dept, Lang, _), Solution),
    Dept \== development,
    Lang \== 'c++'.

% CLUE 3: The friend working in the testing department likes Python.
clue(3, Solution) :-
    memberchk(p(_, testing, Lang, _), Solution),
    Lang == python.

% CLUE 4: Ben prefers the web project and does not work in the testing department.
clue(4, Solution) :-
    memberchk(p('Ben', Dept, _, Project), Solution),
    Project == web,
    Dept \== testing.

% CLUE 5: The friend who prefers Java works in the design department.
clue(5, Solution) :-
    memberchk(p(_, Dept, java, _), Solution),
    Dept == design.
