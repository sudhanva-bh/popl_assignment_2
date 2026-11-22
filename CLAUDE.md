# CLAUDE.md — CS F301 Assignment 2

Source of truth: `PPL_Assignment_2_Final.pdf`. If anything here conflicts with the PDF, the PDF wins.

## Skills
- Before any Prolog work, read and follow `skills/prolog-dev/SKILL.md`.
- Before any Scheme work, read and follow `skills/scheme-dev/SKILL.md`.

## Decomposition
- One prompt = one unit of work (one predicate, one function, one test file, or one review).
- Never implement an entire problem in one step.
- Make only the changes requested in the current prompt. No extra functionality, no unnecessary dependencies.
- Do not overwrite completed work without explaining why.

## Assignment compliance
- Follow all language restrictions, output requirements, and edge cases in the assignment PDF.
- Keep code, tests, and documentation consistent with each other; update all affected ones when one changes (within the scope of the current prompt).

## Git
- Never run `git commit`, `git push`, `git reset`, or anything that rewrites history.
- The user commits and pushes from their own terminal.

## Commit boundaries
At every logical commit boundary, stop and:
1. Show the changed files.
2. Explain what is ready.
3. Suggest a commit message.
4. Wait for the user to commit and push.

Do not continue until the user explicitly types `continue`.

## Honesty about testing
- Never claim tests passed unless you actually ran them and observed the result.
- If tests were not run (or could not be), say so plainly.
