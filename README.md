# CS F301 Principles of Programming Languages Assignment 2

## Branch and file ownership

`main` holds the shared setup, including this layout, `AGENTS.md`, `.gitignore`, both language skills, and the records of the interactions that produced them. After both skills are integrated and verified, create all four problem branches from the same shared setup commit on `main`.

Replace `GROUPID` in the solution filenames with the actual group ID when creating them. The test filenames below keep each problem's single test file easy to find.

| Branch | Solution | Test file | Exact prompts | Response and interaction records | Report |
| --- | --- | --- | --- | --- | --- |
| `problem/p1` | `code/GROUPID_q1.pl` | `tests/p1.pl` | `prompts/P1.md` | `logs/P1/` | `P1_REPORT.md` |
| `problem/p2` | `code/GROUPID_q2.pl` | `tests/p2.pl` | `prompts/P2.md` | `logs/P2/` | |
| `problem/s1` | `code/GROUPID_q3.rkt` | `tests/s1.rkt` | `prompts/S1.md` | `logs/S1/` | |
| `problem/s2` | `code/GROUPID_q4.rkt` | `tests/s2.rkt` | `prompts/S2.md` | `logs/S2/` | |

| Shared skill | Skill file | Exact prompt | Response and interaction records |
| --- | --- | --- | --- |
| Prolog | `skills/prolog-dev/SKILL.md` | `prompts/skills/prolog-dev.md` | `logs/skills/prolog-dev/` |
| Scheme | `skills/scheme-dev/SKILL.md` | `prompts/skills/scheme-dev.md` | `logs/skills/scheme-dev/` |

Keep tracked changes on each problem branch within its row. Create the files when the corresponding work begins. Keep temporary grader-style runners and diagnostics in the ignored `scratch/` directory. Check the assignment statement for the grader's invocation and output requirements before designing each test file.

## Interaction records

Use sequential IDs such as `P1-001` for problem interactions and `PROLOG-001` or `SCHEME-001` for the shared skills. Append problem prompts in chronological order under their interaction IDs in the corresponding prompt file. Preserve the exact prompt text inside each entry. The first shared skill prompt can be read directly from its prompt file. If a skill needs a follow-up, preserve the first prompt verbatim and append the follow-up under its own interaction ID.

In the corresponding log directory, store the external response verbatim as `<interaction-id>.response.md`. Record the prompt location, files changed, and actual test commands and outcomes in `<interaction-id>.md`. Add an `Interaction: <interaction-id>` trailer to the associated commit. The trailer links the record to the commit using `git log` without putting the commit's own hash into its contents.

## Running the programs

Run commands from the repository root. Ensure SWI-Prolog (`swipl`) and Racket (`racket`) are in your PATH.

### P1: Department Assignment Puzzle (`code/62_q1.pl`)
- **Run main:**
  ```bash
  swipl -q -f code/62_q1.pl -g main -t halt
  ```
- **Count solutions (clues 1–8 vs 1–9):**
  ```bash
  swipl -q -f code/62_q1.pl -g "count_solutions([1,2,3,4,5,6,7,8], N), writeln(N)" -t halt
  swipl -q -f code/62_q1.pl -g "count_solutions([1,2,3,4,5,6,7,8,9], N), writeln(N)" -t halt
  ```
- **Run tests:**
  ```bash
  swipl -q -f tests/p1.pl -g run_tests -t halt
  ```

### P2: Arithmetic Equations (`code/62_q2.pl`)
- **Generate one equation / all equations / count equations:**
  ```bash
  swipl -q -f code/62_q2.pl -g "generate_equation([4,2,5,3], E), writeln(E)" -t halt
  swipl -q -f code/62_q2.pl -g "all_equations([4,2,5,3], Es), writeln(Es)" -t halt
  swipl -q -f code/62_q2.pl -g "count_equations([4,2,5,3], N), writeln(N)" -t halt
  ```
- **Run tests:**
  ```bash
  swipl -q -f tests/p2.pl -g run_tests -t halt
  ```

### S1: Binary Tree Traversals (`code/62_q3.rkt`)
- **Verify silent load:**
  ```bash
  racket code/62_q3.rkt
  ```
- **Evaluate traversals / height & leaves:**
  ```bash
  racket -e '(enter! "code/62_q3.rkt") (print-inorder (quote (4 (2 (1 () ()) (3 () ())) (6 (5 () ()) (7 () ())))))'
  racket -e '(enter! "code/62_q3.rkt") (print-all-traversals (quote (4 (2 (1 () ()) (3 () ())) (6 (5 () ()) (7 () ())))))'
  racket -e '(enter! "code/62_q3.rkt") (print-height-and-leaves (quote (4 (2 (1 () ()) (3 () ())) (6 (5 () ()) (7 () ())))))'
  ```
- **Run tests:**
  ```bash
  racket tests/s1.rkt code/62_q3.rkt
  ```

### S2: Conditional Insert (`code/62_q4.rkt`)
- **Verify silent load:**
  ```bash
  racket code/62_q4.rkt
  ```
- **Run with stdin (`print-insert-result`):**
  ```bash
  echo "42 ((1 2) (3 4 5) (6) ()) 3" | racket -e '(enter! "code/62_q4.rkt") (print-insert-result)'
  ```
- **Direct call (`insert-if-short`):**
  ```bash
  racket -e '(enter! "code/62_q4.rkt") (display (insert-if-short 7 (quote ()) 3)) (newline)'
  ```
- **Run tests:**
  ```bash
  racket tests/s2.rkt code/62_q4.rkt
  ```

### Run all tests
```bash
swipl -q -f tests/p1.pl -g run_tests -t halt && swipl -q -f tests/p2.pl -g run_tests -t halt && racket tests/s1.rkt code/62_q3.rkt && racket tests/s2.rkt code/62_q4.rkt
```
