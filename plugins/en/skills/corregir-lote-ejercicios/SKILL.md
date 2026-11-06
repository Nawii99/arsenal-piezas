---
name: corregir-lote-ejercicios
description: Grades a batch of student exams or exercises against a rubric and returns a grade and feedback for each one. Activates when the user asks to grade several assignments at once.
---

# Grade a batch of exercises

## What it does
Automatically grades a group of student exams, exercises, or assignments by comparing each one with a grading rubric. It gives a grade and a comment per student, and a summary of the whole group.

## What to ask before starting
- Where the student files are (folder, and in what format: PDF, Word, text, scanned photos)
- Where the grading rubric is, or whether it needs to be created first
- The grading scale (0-10, pass/fail, letters)
- Whether names need to be anonymized in the final result
- Whether the files contain data about minors, so it is not shared outside this conversation

## Step by step
1. Read the rubric and confirm the criteria and their weights before touching any exam.
2. Open each student file one by one, in the same order as they appear in the folder.
3. For each one, apply each rubric criterion separately, without skipping any.
4. If part of the exercise is blank or missing, score it as 0 on that criterion and note it.
5. Calculate the final grade according to the rubric's formula, normally a weighted sum.
6. Write a brief, constructive comment for the student, and a separate one only for the teacher with doubts or incidents.
7. Repeat with all the files before generating the final summary.

## What to return and in what format
- A Markdown table with: student name, final grade, and a reference to the original file.
- A report per student below the table, with the breakdown by criterion and the two comments.
- A group summary: average grade, how many pass, and which criterion was failed most often overall.

## What NOT to do
- Don't invent or complete answers that the student did not write.
- Don't change the rubric's weights or criteria even if they seem unfair to you.
- Don't give a grade if you can't read the file: say so and ask for it to be reviewed by hand.
- Don't share or upload student data anywhere outside this task.
- Don't grade with a rubric different from the one the teacher gave you without warning first.
