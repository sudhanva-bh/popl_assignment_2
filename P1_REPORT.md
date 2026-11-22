# P1 Report — Department Assignment Puzzle

## P1.b: Solution Count

Running the query:
```prolog
count_solutions([1,2,3,4,5,6,7,8], N).
```

produced:
```
N = 3.
```

This means that **three distinct assignments** satisfy all eight original clues.



Therefore, the original puzzle does not have a unique solution. The eight clues are insufficient to determine exactly one assignment of departments, programming languages, and project preferences to the four friends.



An additional clue is needed to eliminate the ambiguity and obtain a unique solution, as required in P1.c.
