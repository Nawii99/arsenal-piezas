---
name: adaptar-cv-a-oferta
description: Tailors a résumé to a specific job posting, optimizing keywords to pass ATS filters. It activates when the user pastes the text of a job posting along with their résumé and asks to tailor it.
---

# Tailor a résumé to a job posting

## What it does
It rewrites the user's résumé for a specific posting: it reorders the relevant experience, adjusts the vocabulary to the posting's keywords, and prepares a résumé that passes automated filters (ATS) better, without inventing anything.

## What to ask before starting
- The full current résumé, as text (if it is a PDF, ask them to paste it as text).
- The full text of the posting, exactly as published.
- Whether they have several versions of the résumé or only one.

## Step by step
1. Read the posting and extract a list of requirements and keywords: tools, degrees, duties, action verbs the posting uses.
2. Compare that list with the résumé: what matches literally, what matches in substance but with other words, and what is missing.
3. Reorder the experience blocks so the most relevant for this posting ends up on top.
4. Rewrite the experience bullets using, when it is true, the same words the posting uses (for example, if the posting asks for supplier management and the résumé says dealing with suppliers, change the word).
5. Adjust the header summary or professional profile to this particular posting.
6. Check that the résumé does not exceed 2 pages and that the format is simple (no tables or odd columns, because many ATS do not read them well).

## What to return
- The complete tailored résumé, in clean text or markdown, ready to paste into Word or Google Docs.
- A short list (5-8 lines) of what was changed and why.
- A list of the posting's keywords that do not appear in the résumé, so the user can decide whether to add them because they truly have that experience.

## What NOT to do
- Do not invent experience, tools, languages, or certifications the user does not have: it is detected in the interview and burns the application.
- Do not copy literal sentences from the posting as if they were the user's own achievements.
- Do not change dates, company names, or real job titles.
- Do not use tables, columns, images, or headers/footers: many ATS do not read them and discard the résumé.
- Do not generate a single generic résumé to recycle across several different postings: each posting needs its own pass.
