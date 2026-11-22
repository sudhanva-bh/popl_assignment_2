
---
name: scheme-dev
description: Develop, test, and review Scheme solutions for CS F301 Assignment 2 (S1 and S2) using Racket 8.x and the assignment's restricted built-ins.
---

# Scheme Development Guidelines

## Environment
- Use Racket 8.x with `#lang racket/base`.
- S1: `id_q3.rkt`; S2: `id_q4.rkt`. Replace `id` with the group ID.
- Follow the assignment's exact function signatures, behavior, and output format.
- Source files must contain only definitions. No top-level function calls, test executions, or output on loading.
- The grader appends its own calls to the source files.

## Allowed Built-ins
Only use:
- Definitions and control: `define`, `lambda`, `let`, `let*`, `letrec`, named `let`, `if`, `cond` (with `else`), `and`, `or`, `not`, `begin`, `quote` (`'`).
- Lists: `cons`, `car`, `cdr`, `list`, and compositions of `car`/`cdr` up to four levels (`cadr`, `caddr`, `cddr`, etc.).
- Predicates and lookup: `null?`, `pair?`, `eq?`, `assq`, `assoc`.
- Arithmetic/comparison: `+`, `-`, `*`, `<`, `>`, `<=`, `>=`, `=`, `max`.
- Output: `display`, `newline`.
- Input: `read` (S2 only).

Everything else is forbidden, including `set!`, vectors, hash tables, strings, `do`, `for`, `length`, `append`, `reverse`, `map`, `filter`, `member`, `memq`, `list-ref`, and `list-tail`.

Implement required operations as recursive helpers using only permitted constructs. Do not import libraries.

## Coding Conventions
- Use descriptive, lowercase, hyphen-separated function names.
- Preserve the exact names and argument order required by the assignment.
- Prefer pure functions, structural recursion, and immutable lists.
- Pass state explicitly through function arguments; avoid mutation and global state.
- Define clear base cases before recursive cases.
- Prefer tail recursion with accumulators when natural, especially for large lists.
- Use concise `;` comments to explain non-obvious recursion or invariants.
- For each function, identify its input, output, base case, and recursive behavior before implementing it.
- Keep helper functions small and avoid unnecessary abstractions.

## Problem-Specific Rules
- S1: Trees are `()` or `(value left right)`. Visit left before right. Empty-tree height is 0; leaf count excludes empty trees. Match the exact traversal order and required newlines.
- S2: Process every level of nested lists, including the top-level list. Measure each list's original top-level length before insertion. Empty lists are eligible when `n > 0`. Preserve atoms and existing element order.
- S2's final implementation must define `insert-if-short` once, using `make-inserter`, with custom `my-length` and `my-map`.

## Running and Testing
Run from the repository root:

```bash
racket code/id_q3.rkt
racket code/id_q4.rkt
```

These commands should finish without output or errors when no grader calls are appended.

- Keep tests separate from submission source files.
- Test using temporary copies with calls appended, or separate test harnesses.
- Use the assignment's examples and additional edge cases.
- S1: Test empty, single-node, balanced, skewed, and symbol-valued trees.
- S2: Test empty lists, nested empty lists, atoms, boundary lengths, `n = 0`, depth 100, and lists of 10,000 elements.
- Compare exact output, including parentheses, order, whitespace, line count, and trailing newlines.
- Report test results accurately; never claim execution without running the tests.

## AI Self-Review Checklist
Before answering, verify:

- [ ] Racket 8.x and `#lang racket/base` compatibility.
- [ ] Every built-in is explicitly permitted for the relevant problem.
- [ ] No prohibited helpers, mutation, loops, or library imports.
- [ ] Correct function names, signatures, and return values.
- [ ] Correct recursion base cases and termination.
- [ ] Correct handling of empty lists and nested structures.
- [ ] Original list lengths are used where required.
- [ ] List ordering is preserved without accidental reversal.
- [ ] No unintended top-level execution or printing.
- [ ] Exact output formatting and newlines.
- [ ] Relevant examples and edge cases tested.
- [ ] No unnecessary changes outside the requested unit of work.

## Common AI Failure Modes
Watch for:
- Accidentally using convenient but forbidden Racket functions.
- Confusing `()` with a nonempty list or using `eq?` for numeric comparison.
- Incorrect `car`/`cdr` access on empty lists or atoms.
- Reversing results while constructing lists with `cons`.
- Measuring list lengths after insertion instead of before.
- Missing nested empty lists or modifying atoms.
- Incorrect traversal order or missing output newlines.
- Stack overflow or excessive repeated traversal on large inputs.
- Adding test calls or debug output to submission files.
- Producing code that looks valid but was never executed.

## Workflow
Handle only the specific function, test file, or review requested in the current prompt. Consult the relevant assignment problem statement for exact requirements. Do not implement unrelated tasks or anticipate subsequent requests.

Follow the assignment's decomposition rule: one prompt corresponds to one unit of work, with commits reflecting incremental development.

Before responding, apply the checklist, run applicable tests when the environment permits, and briefly report the changes and verification results.
