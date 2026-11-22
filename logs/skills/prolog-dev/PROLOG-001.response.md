---
name: prolog-dev
description: Develop, test, debug, and review Prolog solutions for CS F301 Assignment 2 (P1 and P2), following SWI-Prolog restrictions and assignment requirements.
---

# Prolog Development Guidelines

## 1. Environment and Restrictions

- Use **SWI-Prolog 9.x**.
- Allowed libraries: `lists`, `apply`, `yall`, `aggregate`.
- Do not use `assert`, `retract`, or global variables (`b_setval`, `nb_setval`).
- Do not use initialization directives or call `halt/0` manually.
- Files must contain only predicate definitions and necessary comments.
- Do not print anything unless explicitly required.
- For P2, never construct a string and parse it back into a Prolog term for evaluation.
- Follow all problem-specific restrictions in the assignment.

## 2. Coding Conventions

- Use descriptive `snake_case` predicate names and meaningful variable names.
- Follow standard Prolog naming: lowercase atoms and predicate names, uppercase variables.
- Use `%` comments to explain non-obvious logic, constraints, and predicate behavior.
- Write predicates declaratively, expressing relationships rather than relying unnecessarily on procedural control.
- Prefer clear recursion, pattern matching, and unification.
- Use cuts (`!`) only when logically justified and when they do not remove valid solutions.
- Avoid unnecessary helper predicates, duplicate clauses, and hard-coded answers.
- Ensure predicates terminate for all required inputs.

## 3. Running and Testing

Run the main predicate:

```bash
swipl -q -f id_q1.pl -g main -t halt
```

Run individual predicates:

```bash
swipl -q -f id_q1.pl -g "<goal>" -t halt
```

Replace `id_q1.pl` with `id_q2.pl` for P2.

Testing requirements:

- Test the exact examples provided in the assignment.
- Add independent edge cases and failure cases.
- Verify output formatting, ordering, and data types.
- Check that failing queries terminate normally without errors or infinite loops.
- Ensure all required solutions are generated without unintended duplicates.
- Keep test files separate from submitted solution files.

## 4. Problem-Specific Guidance

### P1 — Department Assignment Puzzle

- Represent solutions using `p(Name, Dept, Lang, Project)` terms.
- Preserve the required friend ordering and exact atom representations.
- Implement each clue independently as `clue(N, Solution)`.
- Ensure `count_solutions/2` respects exactly the supplied active clues.
- Derive solutions from constraints rather than hard-coding assignments.
- Document clue 9 using `% CLUE 9:` immediately above its clause.
- Ensure clue 9 satisfies all restrictions specified in the assignment.

### P2 — Arithmetic Equations

- Preserve the original order of all input numbers.
- Use exactly one equality operator.
- Support valid binary expression trees and parentheses.
- Reject division by zero and non-exact division at every intermediate step.
- Generate canonical strings using the specified precedence and associativity rules.
- Ensure `generate_equation/2` fails cleanly when no solution exists.
- Ensure `all_equations/2` returns a duplicate-free list sorted using `sort/2`.
- Ensure `count_equations/2` agrees with the number of distinct equations.

## 5. Self-Review Checklist

Before answering, verify:

- [ ] Code runs under SWI-Prolog 9.x.
- [ ] Only permitted libraries and language features are used.
- [ ] No prohibited predicates, global state, or initialization directives.
- [ ] Predicate names, arities, and argument conventions match the specification.
- [ ] Recursion has valid base cases and terminates.
- [ ] Variables are correctly scoped and unified.
- [ ] Backtracking produces all intended solutions without unintended duplicates.
- [ ] No incorrect cuts or premature failures eliminate valid solutions.
- [ ] All assignment examples and relevant edge cases pass.
- [ ] Output formatting, atom/string types, and ordering are exact.
- [ ] No unwanted output occurs when loading the file.
- [ ] No answers or expected results are hard-coded.

Common AI-generated Prolog mistakes to watch for include incorrect unification, confusing `=` with `is`, accidental variable reuse, missing base cases, infinite recursion, incorrect cut placement, unintended duplicate solutions, and inconsistent atom/string handling.

## 6. AI Prompt and Workflow Rules

- **One prompt = one unit of work:** one predicate, one test file, or one review.
- Never implement an entire assignment problem in a single prompt.
- Work incrementally, keeping each change independently understandable and testable.
- Assume the current conversation already contains the relevant problem statement and its constraints.
- Do not assume context from other conversations.
- Restrict each response to the unit explicitly requested.
- Preserve existing correct functionality when making changes.
- Record prompts verbatim in the appropriate `prompts/P1.md` or `prompts/P2.md`.
- Keep Git commits incremental, reflecting actual problem-solving progress.
- Apply this skill's self-review checklist before providing code or a review.