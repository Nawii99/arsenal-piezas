---
name: explica-codigo
description: Explains in plain language the code of a tutorial or sample project, for someone who doesn't program. Usage - /explica-codigo file-or-folder
---

## What it does
Reads the file or folder you give it (for example, a sample game downloaded from a tutorial) and explains it as if to someone who has never programmed.

## Before starting
If the user hasn't indicated a file, ask which one they want to understand. If it is a folder with many files, list what is there and ask whether they want the general summary or to go into a specific one.

## Step by step
1. Read the entire code before explaining anything.
2. Start with a 3-sentence summary: what it is, what it does when you open it, and what you can touch without risk.
3. Divide the code into meaningful blocks (screen, buttons, score...) and explain each block in one or two sentences, without jargon. Use everyday comparisons: a variable is a labeled box, a function is a recipe.
4. Point out with line numbers the 3 or 4 things the user can change on their own to practice: texts, colors, number of questions.
5. Warn about what they should NOT touch if they don't want to break it, also with line numbers.

## What to return
A 3-sentence summary, explanation by blocks, a list of safe changes with the exact line, and a list of areas better left alone. All in English, in a friendly, direct tone.

## What NOT to do
- Do not rewrite or improve the code: this command only explains. If you see a bug, mention it at the end in one line, without fixing it on your own.
- Do not drop terms like callback, DOM, or asynchronous without a one-sentence explanation next to them.
- Do not summarize so much that the explanation is useless: every block of the code must appear.
