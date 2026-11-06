---
name: adaptar-curriculum-oferta
description: Tailors a plain-text résumé to a specific job posting, highlighting relevant keywords and achievements. It activates when the user pastes their résumé and a job posting and asks to tailor it.
---

# Tailor a Résumé to a Job Posting

## What it does
It takes a résumé you have already written and a specific job posting, and returns a version of the résumé reordered and rewritten for that particular posting. It does not invent experience you do not have.

## What to ask before starting
- Ask for the full résumé as text (have them paste it, not a PDF you cannot read).
- Ask for the full text of the posting, not just the title.
- Ask whether they want the order of the sections touched or only the content.
- Ask whether there is any detail they do not want to appear (age, photo, etc.).

## Step by step
1. Read the posting and extract a list of the keywords it repeats: tools, duties, requirements ("required," "preferred").
2. Read the résumé and mark which experience and achievements match those keywords.
3. Rewrite the professional summary or profile, if there is one, in 2-3 lines using the language of the posting, without copying whole sentences from it.
4. Reorder the experiences: the one most relevant to the posting goes first, even if it is not the most recent, unless the industry is very strict about chronological order.
5. In each experience, adjust the 2-3 lines of achievements so they use the same words as the posting, as long as what is said is true.
6. Check that no tool, figure, or responsibility has been invented that was not already in the original résumé.
7. Mark in square brackets any missing detail that the user should fill in.

## What to return
- The complete tailored résumé, in plain text, ready to paste into a document.
- Below it, a short list of the 5-8 most important changes that were made and why.

## What NOT to do
- Do not invent experience, job titles, companies, or figures that are not in the original résumé.
- Do not copy literal sentences from the posting as if they were the person's own achievements.
- Do not force in every keyword if it does not truly fit: a résumé that makes no sense to a person will not pass the interview either, even if it gets past the ATS.
- Do not change contact details, dates, or education without the user confirming.
