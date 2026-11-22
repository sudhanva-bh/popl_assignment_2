---
name: prolog-dev
description: Conventions, run/test commands, self-review checklist and AI failure modes for writing SWI-Prolog 9.x code for CS F301 Assignment 2 (id_q1.pl, id_q2.pl). Use before writing, testing or reviewing any Prolog file in this repo.
---

# prolog-dev

## 1. Language and version
- SWI-Prolog 9.x. Standard Prolog plus SWI built-ins only.
- Allowed libraries: `lists`, `apply`, `yall`, `aggregate`. Nothing else.
- Files contain **only definitions** (clauses, plus `:- use_module(library(...))` for the allowed libraries). Nothing runs on load.

## 2. Hard restrictions (assignment)
- No `assert*`, `retract*`, or global variables (`b_setval`, `nb_setval`, `nb_getval`, `b_getval`).
- No `initialization` directive of any kind (`:- initialization(...)`).
- Never call `halt/0` yourself. The grader runs `-t halt`.
- No top-level goals/directives that print or call predicates on load.
- Print nothing except what the problem specifies (no debug `format`, `print`, `writeln`, `portray_clause` left behind).
- P2: do not build a string and parse it back into a term to evaluate it. Evaluate on the term/tree.

## 3. Naming and formatting
- Predicates and atoms: `snake_case`. Variables: `CamelCase`; `_` for singletons, `_Name` for intentionally unused named variables.
- Required names come from the assignment (`clue/2`, `main/0`, `count_solutions/2`, `generate_equation/2`, `all_equations/2`, `count_equations/2`). Do not rename them or change arity.
- One clause per line-group, head at column 0, body indented 4 spaces, one goal per line, `.` ends the last goal.
- Comment above each predicate: `% pred(+Arg, -Arg): one-line declarative reading.` Use mode markers `+` in, `-` out, `?` either.
- Keep clauses of one predicate together (no discontiguous warnings). The file must load with **zero warnings**.
- Follow special comment formats the assignment requires exactly (e.g. `% CLUE 9:` on the line directly above its clause).

## 4. Declarative style and variable binding
- Write each predicate as a statement of what is true: "`Solution` is valid if ...". Read every clause aloud as logic before writing it.
- Prefer pure relations, pattern matching in heads, and recursion on list structure (`[]` / `[H|T]`).
- Generate-and-test: **generate first, constrain after**. Put the goal that binds a variable before any goal that needs it bound (`is/2`, `</2`, `=:=/2`, `\=`, `\+`, `dif/2` with unbound args).
- Know the binding state of each variable at each goal. Arguments declared `+` must be bound by the caller; do not rely on accidental binding.
- Negation `\+ G` and `forall/2` only test; they bind nothing. Use them with already-bound terms.
- Use `permutation/2`, `member/2`, `nth0/nth1`, `select/3`, `findall/3`, `aggregate_all/3`, `sort/2`, `msort/2`, `sumlist`/`sum_list` from allowed libraries where they fit.
- Use `=`/`==` correctly: `=` unifies, `==` compares without binding, `=:=` compares arithmetic values, `is` evaluates the right-hand side.
- Cut sparingly. Only use `!` (or `->`) where determinism is required, placed after the guard that makes it safe. A cut must not change the declarative meaning of the clauses it is in.

## 5. Running the Prolog files and tests
The grader runs (from the directory holding the file; `id` = group ID):
```
swipl -q -f id_q1.pl -g main -t halt                  # runs main/0
swipl -q -f id_q1.pl -g "<goal>" -t halt              # runs any other predicate
swipl -q -f id_q2.pl -g "<goal>" -t halt
```
- Use the same flags for local checks. Quote the goal; inside it, use single quotes for atoms, e.g. `-g "count_solutions([1,2,3,4,5,6,7,8], N), write(N), nl"`.
- Test files live in `tests/` (one per problem). Run a test file the same way, loading the solution with `-f`, e.g. `swipl -q -f code/id_q2.pl -g "run_tests" -t halt` if the test file defines `run_tests`, or `swipl -q -f code/id_q2.pl -s tests/test_q2.pl -g run_tests -t halt`.
- A test file may print PASS/FAIL lines (it is not graded output), but must never be loaded by the solution file.
- Report a test result only after running it and reading the output. A goal that fails or raises under `-g` exits non-zero; check the exit code and any warnings, not only stdout.
- If `swipl` is unavailable, say so. Do not claim anything passed.

## 6. Self-review checklist (apply before answering)
**Correctness**
- [ ] File loads with no warnings (singleton, discontiguous, undefined procedure).
- [ ] Every predicate matches the assignment's name, arity, argument order, and term/atom/string types (e.g. quoted atoms `'Alex'`, `'AI'`, `'c++'`; P2 output is an SWI **string**, not atom or code list).
- [ ] Each clause reads correctly as a logical statement.
- [ ] All given examples in the assignment produce exactly the stated results.

**Determinism / solutions**
- [ ] `main/0`, `generate_equation/2`: succeed with one solution as specified; `generate_equation/2` **fails** (no error, no loop) when none exists.
- [ ] No unwanted choice points left in `main/0` (it must not leave an open choice or backtrack into extra output).
- [ ] `count_*`/`all_*` collect with `findall/3` (or `aggregate_all/3`); `all_equations/2` is deduplicated and `sort/2`-ed; no-solution case yields `[]`.
- [ ] No duplicate solutions from different derivations unless the assignment counts them as distinct.

**Edge cases**
- [ ] Empty list, one-element list, two-element list (P2).
- [ ] Division: exact only, divisor never zero, applies to every sub-expression; negative sub-results allowed; no unary minus; no digit concatenation.
- [ ] Both sides of `=` have equal integer value; `=` appears exactly once, with a non-empty expression on each side.
- [ ] Empty/unsatisfiable `Active` list in `count_solutions/2` behaves sensibly (all candidates counted for `[]`).

**Output formatting**
- [ ] `main/0` prints exactly four lines in the exact format `Alex = [research, python, AI]` (`", "` separator inside brackets, `AI` unquoted in print). Nothing else is printed.
- [ ] Equation strings: no spaces, canonical parenthesization rules from the assignment, numbers in decimal.
- [ ] Nothing printed by any other predicate or at load time. Check `write` vs `print` vs `format ~w`/`~a`/`~q` (`~q` adds quotes; `~w` does not).

**Restrictions**
- [ ] None of: `assert*`, `retract*`, `b_/nb_setval`, `initialization`, `halt`, extra libraries.

## 7. Common AI failure modes in Prolog
- **Accidental instantiation:** a helper binds an output variable early (e.g. `Sol = [p(_,_,_,_)|_]` with shared variables, or calling a test goal with unbound args). Fix: bind/enumerate first, test later; check `+`/`-` modes.
- **Incorrect backtracking:** cut in the wrong place, or `->` without an else that makes the predicate fail unexpectedly; `\+` on an unbound goal; relying on `once/1` to hide a modeling bug.
- **Duplicate solutions:** the same equation reached through several derivations or `select/3` / `append/3` splits; list collected without `sort/2` where `all_equations/2` requires deduplication.
- **Unsafe arithmetic:** using `/` where integer-exact division is required (SWI may return a float or rational, or raise an error); `X/0` errors; `=` instead of `=:=`/`is`; float comparison of values; evaluating non-ground terms (instantiation error). Check divisibility with `mod`/`rem` and non-zero divisor **before** dividing; use `//` only after exactness is proven.
- **Unintended output:** leftover `write`/`format` debug lines, `print_message` noise, directives that run goals on load, an `initialization(main)` directive, or calling `halt` inside the file.
- **Wrong term types:** unquoted `ai`/`alex` instead of `'AI'`/`'Alex'`; `c++` not quoted; atom/code-list instead of an SWI string (`format(string(S), ...)`, `string_concat/3`, `number_string/2`).
- **Non-termination:** unbounded recursion with left recursion or generating before bounding; missing base case for `[]`/`[X]`.
- **Hard-coding:** writing the puzzle's answer into `main/0` instead of deriving it from the clues; clues that mention friends by name when forbidden (clue 9).
- **Over-engineering:** extra predicates, libraries, or features nobody asked for; changing completed predicates while working on another.
- **Reporting untested results:** claiming correct output without having run `swipl`.
