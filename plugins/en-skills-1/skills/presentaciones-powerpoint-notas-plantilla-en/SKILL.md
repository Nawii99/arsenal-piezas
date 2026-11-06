---
name: presentaciones-powerpoint-notas-plantilla-en
description: Creates or edits PowerPoint (.pptx) presentations with speaker notes and, if one exists, the company template. Use it when you ask for a presentation, a client proposal, a results report, or changes to a .pptx you already have.
---

# PowerPoint presentations with notes and template

## What it does
It builds a .pptx file that opens in PowerPoint, Keynote, or Google Slides. It can start from scratch, from your template, or from an existing presentation you want to touch up. If you ask, each slide carries its speaker notes.

## Before starting, ask and wait for the answer
1. Do we need to create a new presentation or edit an existing one? If it exists, in which folder is it?
2. Who is it for and what should that person do when it ends? (approve a quote, understand a report, sign up for something...)
3. How long is it when spoken aloud? At most, one slide per minute.
4. Do you have a template or brand guidelines (colors, typefaces, logo)? If not, propose a palette of 2 or 3 colors and a single typeface.
5. What material do you already have? Texts, figures, images, a document. Missing figures are not invented: they are left flagged.
6. Do you want speaker notes? Short or developed?
7. Is there personal or confidential data about other people in the material? If so, remove what is not needed before giving it to the tool.

## Step by step
1. Summarize in 3 lines what you understood and wait for approval before creating anything.
2. Propose the outline as a numbered list with the title of each slide. The title should state the conclusion (for example, "We can cut spending by [X]%") and not just the topic ("Spending"). Wait for approval.
3. Prepare the environment. Claude Code may need to install a Python library called python-pptx to write .pptx files. It will ask for your permission: accept that and nothing you do not understand.
4. If there is a template, use its slide layouts instead of drawing boxes by hand. That way the brand looks right and can be changed later. Always work on a copy of the template.
5. Build the slides with these rules:
  - One idea per slide.
  - Maximum 5 or 6 lines of text and 18-point or larger font in the body.
  - Good contrast between text and background.
  - One chart, one message. Tables only if they help.
  - Images carry alt text (a short description).
  - Each figure carries its source and date, small at the bottom.
6. Speaker notes: for each slide, what to say in 2 to 4 sentences, how to link to the next one and, if there are figures, where they come from. Do not repeat word for word what is already on the slide.
7. If it is an edit, change only what was asked. Respect existing formatting, order, and notes. Save under another name (for example, report-v2.pptx).
8. Check the result. If LibreOffice is installed, convert it to PDF or images and look for cut-off, overlapping, or off-slide text. If you cannot check it visually, say so clearly and ask the user to open it.

## What to return
- The path of the new .pptx file. If there was an edit, the original is left intact.
- A table with: number, title, main message, and whether it has notes.
- The list of gaps: figures, names, dates, and prices flagged as [DATA TO CONFIRM].
- If it is a proposal with prices: indicate on each price whether it includes VAT or excludes VAT.
- A warning if you could not check the visual appearance.

## What NOT to do
- Do not invent figures, clients, testimonials, logos, or success stories. If a piece of data is missing, leave a clearly visible [DATA TO CONFIRM].
- Do not overwrite the original file or the template.
- Do not fill the slide with paragraphs to be read aloud. Long material goes in the notes or an appendix.
- Do not use logos, photos, or typefaces belonging to others without a license. If you use stock images, note where they are from.
- Do not email the file or upload it anywhere. You do that.
- Do not leave internal comments or opinions about the client. Speaker notes travel inside the file: if you share the .pptx, whoever opens it will see them.

## What a person reviews before using it
- All figures, names, dates, and prices, against their source.
- That the speaker notes and the file properties (author, comments) contain nothing internal if you are going to send it.
- That the commitments (deadlines, prices, terms) were decided by you and not by the tool.

## How to activate it
Save this text as SKILL.md inside a folder named after the skill, in .claude/skills/ of your project. Then, in Claude Code, write something like: "Prepare a 10-slide presentation for [CLIENT] with speaker notes."
