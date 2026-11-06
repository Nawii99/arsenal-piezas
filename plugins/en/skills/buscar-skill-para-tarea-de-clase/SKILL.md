---
name: buscar-skill-para-tarea-de-clase
description: Helps you find a ready-made skill for a classroom task (worksheets, rubrics, presentations, documents), check that it is safe and licensed, and test it before using it. It activates when you ask for a skill, ask whether something already exists, or want to install someone else's.
---

# Find a skill for a classroom task

## What it does
A skill is a folder with a SKILL.md file that teaches Claude Code to do a specific task. This skill does not prepare your material. It helps you decide whether a skill that would work already exists, whether it can be trusted, and whether it fits your class.
Where to put it: save this text as SKILL.md inside the .claude/skills/buscar-skill-para-tarea-de-clase/ folder of your project.
How to ask for it: "Find a skill to make rubrics in Word from my assessment criteria."

## Ask before starting
1. What task do you want to solve? One sentence. Example: "make a review worksheet in PDF from a topic."
2. What grade level and subject is it for?
3. In what format do you want it? Word, PDF, PowerPoint, Excel, or text.
4. Will there be student data in the material? If the answer is yes, work only with made-up data.
5. Are you working on a school computer? You may not be allowed to install things. Ask whoever handles IT.
6. Do you have a list of skills (a link or a folder)? If you do not have one, ask for it. Do not make up links.

## Step by step
1. Restate the task in one sentence and ask for confirmation.
2. Look at what is already installed: the project's .claude/skills folder and the one in your user directory. If one that works is already there, use it and stop.
3. Open the list or repository the user gives you. A curated list is only an index. Nobody has checked for you that what it links to is good or safe.
4. Group what you find by type of task: documents, presentations, spreadsheets, content, assessment. Keep 3 candidates at most.
5. If reading the candidates would fill up the conversation, launch one subagent per candidate. Each reads it separately and returns a summary to you.
6. For each candidate, read the entire SKILL.md and the list of files in its folder. Note what it does, whether it includes scripts, whether it connects to the internet, and whether it asks for keys.
7. Check the license, who maintains it, and the date of the last update. Without a license file, by default you do not have permission to reuse or sell it. Discard it or ask the author.
8. Compare and recommend one. If none works, say so clearly.
9. Only if the user says "yes," copy the folder into the project's .claude/skills/, not the global one. Do not run any script you have not read.
10. Test with a made-up case and show the result before using it with real material.

## What to return
A table with one row per candidate, and below it the recommendation in 3 lines at most.
| Candidate | What it does | What it includes (scripts, internet, keys) | License | Last update | Verdict |
|---|---|---|---|---|---|
Registration record of the chosen one: original URL, license, date checked [DATE], and whether it is open source, free, or paid.
If the user wants, a file mis-skills-de-clase.md with the skills already reviewed, grouped by category. If the file already exists, append at the end and do not delete anything.
If none works: say so and suggest writing a prompt or a skill of your own, in your own words and without copying someone else's text.

## What NOT to do
- Do not install or run anything without the user's approval.
- Do not invent skills, links, or repository names. If you cannot open the list, ask them to paste its contents.
- Do not trust stars or downloads. They are not a security review.
- Do not include names, grades, photos, or reports of students. Many are minors, and the GDPR and Spain's LOPDGDD apply.
- Do not copy the text of someone else's skill into one of your own in order to sell it.
- Do not use the Claude Code mode that skips permissions.

## What a person reviews
The teacher reviews the material before giving it to students: that it is correct, that it fits the curriculum of [YOUR AUTONOMOUS COMMUNITY (REGION)], and that the level is appropriate.
Grades and assessments are always decided by the teacher. The skill only helps with drafts.
If the school has rules about AI or about installing software, those take precedence.

Piece reviewed in October 2026. Lists and licenses change: check the date of everything you install.
