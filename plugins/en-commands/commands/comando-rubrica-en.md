---
name: comando-rubrica-en
description: Generates an evaluation rubric (criteria x levels) for a specific task. Activates with /comando-rubrica-en followed by the description of the task and the grade level.
---

# /comando-rubrica-en

Task to evaluate: $ARGUMENTS

Create a rubric that the teacher can use as is to grade that task. If $ARGUMENTS is missing the grade level or the type of task, ask before writing anything. If the rest is missing, use what is indicated by default.

## How you build it

1. Extract from the task between 4 and 6 criteria. Each criterion is ONE observable thing ("Speaks while looking at the audience", not "Communication"). If the user mentions a curriculum competency, use it as a criterion but translated into something observable.
2. Use 4 levels with these names, from highest to lowest: Excellent (4), Good (3), In progress (2), Needs help (1). If the user asks for another scale or names, respect them.
3. Write each cell as a description of what IS SEEN, not an adjective. Bad: "Good pronunciation". Good: "Everything is understandable; hesitates on one or two words".
4. Write the Excellent column first, then Needs help, and fill in the two intermediate ones as real steps between the two. This way you don't end up with four nearly identical cells.
5. Add a final "Weight" column with a percentage. By default, an equal split. If the user says what is more important, adjust and check that it adds up to 100.
6. Below the table, indicate how to convert to a grade from 0 to 10: sum of (level x weight) divided by 4. Give an example with numbers.
7. Add a student version: the same criteria in the first person and in language appropriate to their age ("I look at my classmates when I speak"). It serves so that they know what is asked of them BEFORE doing the task and so that they can self-assess.

## What you return

- Title: "Rubric: [task] - [grade level]".
- Markdown table: first column criteria, then the 4 levels, last column Weight.
- Grade formula with an example.
- Student version (list with [ ] checkboxes to tick).
- Two warning sentences for the teacher: which criterion is the most subjective and a suggestion so that two teachers grade similarly (for example, grading the first two assignments together).

If the user asks for a file, save it as `rubrica-[tarea].md`. The table can be pasted directly into Google Docs or Word and it becomes a real table.

## What NOT to do

- Don't put more than 6 criteria. Nobody uses a rubric with 10 rows when grading 25 assignments.
- Don't use empty adjectives in the cells (good, fair, adequate, correct) without saying what is observed.
- Don't mix two different things in one criterion ("spelling and creativity").
- Don't invent references to specific decrees, education laws, or competency codes. If the user wants them, they paste them and you incorporate them.
- Don't penalize in the rubric things the task didn't ask for.
- Don't assume the grade level. A 1st-grade rubric and a final-year high school one are nothing alike.
