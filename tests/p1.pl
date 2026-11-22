
:- use_module(library(plunit)).
:- use_module(library(aggregate)).

:- consult('../code/62_q1.pl').

:- begin_tests(p1).

% The three verified solutions satisfying clues 1 through 8.

original_solution(1, [
    p('Alex', design, java, 'AI'),
    p('Ben', development, javascript, web),
    p('Carla', research, 'c++', data),
    p('Dana', testing, python, embedded)
]).

original_solution(2, [
    p('Alex', design, java, embedded),
    p('Ben', development, javascript, web),
    p('Carla', testing, python, 'AI'),
    p('Dana', research, 'c++', data)
]).

original_solution(3, [
    p('Alex', testing, python, embedded),
    p('Ben', development, javascript, web),
    p('Carla', design, java, 'AI'),
    p('Dana', research, 'c++', data)
]).

all_original_clues(Solution) :-
    forall(
        between(1, 8, N),
        clue(N, Solution)
    ).

% Candidate generation

test(candidate_count) :-
    aggregate_all(count, candidate_solution(_), N),
    assertion(N =:= 13824).

test(candidate_unique) :-
    findall(S, candidate_solution(S), Solutions),
    sort(Solutions, Unique),
    length(Unique, 13824).

test(candidate_structure) :-
    candidate_solution(S),
    assertion(S = [
        p('Alex', _, _, _),
        p('Ben', _, _, _),
        p('Carla', _, _, _),
        p('Dana', _, _, _)
    ]),
    !.

test(candidate_attributes_unique) :-
    candidate_solution(S),
    findall(D, member(p(_, D, _, _), S), Ds),
    findall(L, member(p(_, _, L, _), S), Ls),
    findall(P, member(p(_, _, _, P), S), Ps),
    sort(Ds, [design, development, research, testing]),
    sort(Ls, ['c++', java, javascript, python]),
    sort(Ps, ['AI', data, embedded, web]),
    !.

% Individual clue checks against verified solutions

test(clue_1_valid) :-
    forall(original_solution(_, S), clue(1, S)).

test(clue_2_valid) :-
    forall(original_solution(_, S), clue(2, S)).

test(clue_3_valid) :-
    forall(original_solution(_, S), clue(3, S)).

test(clue_4_valid) :-
    forall(original_solution(_, S), clue(4, S)).

test(clue_5_valid) :-
    forall(original_solution(_, S), clue(5, S)).

test(clue_6_valid) :-
    forall(original_solution(_, S), clue(6, S)).

test(clue_7_valid) :-
    forall(original_solution(_, S), clue(7, S)).

test(clue_8_valid) :-
    forall(original_solution(_, S), clue(8, S)).

% Negative checks for individual clues

test(clue_1_rejects_ai_in_research) :-
    forall(
        (candidate_solution(S), member(p(_, research, _, 'AI'), S)),
        \+ clue(1, S)
    ).

test(clue_1_rejects_dana_ai) :-
    forall(
        (candidate_solution(S), member(p('Dana', _, _, 'AI'), S)),
        \+ clue(1, S)
    ).

test(clue_2_rejects_development) :-
    forall(
        (candidate_solution(S), member(p('Alex', development, _, _), S)),
        \+ clue(2, S)
    ).

test(clue_2_rejects_cpp) :-
    forall(
        (candidate_solution(S), member(p('Alex', _, 'c++', _), S)),
        \+ clue(2, S)
    ).

test(clue_3_rejects_wrong_language) :-
    forall(
        (candidate_solution(S), member(p(_, testing, java, _), S)),
        \+ clue(3, S)
    ).

test(clue_4_rejects_wrong_project) :-
    forall(
        (candidate_solution(S), member(p('Ben', _, _, data), S)),
        \+ clue(4, S)
    ).

test(clue_4_rejects_testing) :-
    forall(
        (candidate_solution(S), member(p('Ben', testing, _, web), S)),
        \+ clue(4, S)
    ).

test(clue_5_rejects_java_outside_design) :-
    forall(
        (candidate_solution(S), member(p(_, research, java, _), S)),
        \+ clue(5, S)
    ).

test(clue_6_rejects_embedded) :-
    forall(
        (candidate_solution(S), member(p('Carla', _, _, embedded), S)),
        \+ clue(6, S)
    ).

test(clue_6_rejects_development) :-
    forall(
        (candidate_solution(S), member(p('Carla', development, _, _), S)),
        \+ clue(6, S)
    ).

test(clue_7_rejects_java) :-
    forall(
        (candidate_solution(S), member(p('Dana', research, java, _), S)),
        \+ clue(7, S)
    ).

test(clue_7_rejects_wrong_department) :-
    forall(
        (candidate_solution(S), member(p('Dana', design, _, _), S)),
        \+ clue(7, S)
    ).

test(clue_8_rejects_wrong_department) :-
    forall(
        (candidate_solution(S), member(p(_, design, _, data), S)),
        \+ clue(8, S)
    ).

test(clue_8_rejects_javascript) :-
    forall(
        (candidate_solution(S), member(p(_, research, javascript, data), S)),
        \+ clue(8, S)
    ).

% Original solutions and solve/1

test(all_verified_solutions_satisfy_clues) :-
    forall(
        original_solution(_, S),
        all_original_clues(S)
    ).

test(solve_returns_exactly_three) :-
    findall(S, solve(S), Solutions),
    findall(S, original_solution(_, S), Expected),
    msort(Solutions, Sorted),
    msort(Expected, ExpectedSorted),
    assertion(Sorted == ExpectedSorted).

% Counts with different active clue lists

test(count_no_clues) :-
    count_solutions([], N),
    assertion(N =:= 13824).

test(count_only_clue_1) :-
    count_solutions([1], N),
    assertion(N =:= 7776).

test(count_only_clue_4) :-
    count_solutions([4], N),
    assertion(N =:= 2592).

test(count_only_clue_9) :-
    count_solutions([9], N),
    assertion(N =:= 3456).

test(count_original_eight) :-
    count_solutions([1,2,3,4,5,6,7,8], N),
    assertion(N =:= 3).

test(count_all_nine) :-
    count_solutions([1,2,3,4,5,6,7,8,9], N),
    assertion(N =:= 1).

% Clue 9 must keep only the second verified solution

test(clue_9_accepts_solution_2) :-
    original_solution(2, S),
    once(clue(9, S)).

test(clue_9_rejects_solution_1) :-
    original_solution(1, S),
    \+ clue(9, S).

test(clue_9_rejects_solution_3) :-
    original_solution(3, S),
    \+ clue(9, S).

test(unique_solution_after_clue_9) :-
    findall(
        S,
        (solve(S), clue(9, S)),
        Solutions
    ),
    original_solution(2, Expected),
    assertion(Solutions == [Expected]).

% Exact output verification for main/0.
% Accept any of the three original solutions.
% Every expected string includes the final newline.

expected_output(
    "Alex = [design, java, AI]\nBen = [development, javascript, web]\nCarla = [research, c++, data]\nDana = [testing, python, embedded]\n"
).

expected_output(
    "Alex = [design, java, embedded]\nBen = [development, javascript, web]\nCarla = [testing, python, AI]\nDana = [research, c++, data]\n"
).

expected_output(
    "Alex = [testing, python, embedded]\nBen = [development, javascript, web]\nCarla = [design, java, AI]\nDana = [research, c++, data]\n"
).

test(main_exact_output) :-
    with_output_to(string(Output), main),
    assertion(expected_output(Output)).

test(main_four_lines) :-
    with_output_to(string(Output), main),
    split_string(Output, "\n", "", Lines),
    assertion(Lines = [_, _, _, _, ""]).

test(main_final_newline) :-
    with_output_to(string(Output), main),
    string_concat(_, "\n", Output).

test(main_no_extra_output) :-
    with_output_to(string(Output), main),
    assertion(expected_output(Output)).

:- end_tests(p1).
