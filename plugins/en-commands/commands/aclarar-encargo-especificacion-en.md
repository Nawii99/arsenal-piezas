---
name: aclarar-encargo-especificacion-en
description: Interviews you in rounds to turn a client's vague idea into a written specification, with scope, measurable requirements, and open questions. Use it before quoting or starting a job.
---
<!-- Installation: save this file as .claude/commands/aclarar-encargo.md inside your project, or in ~/.claude/commands/ to use it in all of them. Then type /aclarar-encargo-especificacion-en followed by the client's idea. -->
# Clarify the engagement
This command acts as an interviewer. You tell it what the client has said and it draws out what is missing. At the end it gives you a one- or two-page document that the client can read and approve.
Starting idea: $ARGUMENTS
## Before starting
If no idea is written above, ask for it in one sentence and wait. Don't start without it.
Ask these questions in a single short message: 1) Is it for a client of yours or for you? 2) What material already exists (emails, audio files, links, previous quotes)? 3) Is there a real deadline and where does it come from? 4) What rate or hours do you want to use? If there is none, leave [YOUR RATE].
## Step by step
1. Summarize the idea in three lines, using the client's words, and ask: "Is this what they want?" Correct it until they say yes.
2. Interview in rounds. Maximum five questions per round and one topic per round, in this order: problem and goal; who will use it; how it is done today; what would be a success and how it would be measured; what is out of scope; deadline and maximum budget; constraints (tools already in use, personal data, regulations); who decides and who approves.
3. At the end of each round, write in two lines what you understood. Mark each piece of data as STATED (the client said it), ASSUMED (you take it as given), or PENDING (nobody knows yet).
4. Hunt down the soft words: "fast", "modern", "easy", "nice-looking", "more sales". Ask what they mean in numbers or with an example. If there is no way to measure it, note it as PENDING.
5. Hunt down contradictions (for example, small budget and large scope) and put them on the table tactfully. Don't decide yourself.
6. When no big gaps remain, write the specification in the format below.
7. Before giving it to the user, check that every requirement has a way to verify it is done, and tell them what is still pending.
## What to return
A Markdown document with these sections, in this order:
- Summary: three lines.
- Goal: what changes if the work goes well and how it will be measured.
- Who uses it: real people or roles, not "everyone".
- In scope: numbered list (R1, R2...), each requirement with "Considered done when...".
- Out of scope: what has been discussed and will NOT be done.
- Assumptions: everything marked ASSUMED.
- Open questions: everything marked PENDING, with who should answer.
- Risks: what can break the deadline or the cost.
- Changes: how a new request will be handled ([YOUR PROCESS]; for example: it is noted, quoted separately, and approved in writing).
- Next step: a single action, with a date.
At the end, add a five-line summary to send to the client by email and ask them to reply "agreed" or with their corrections.
## What NOT to do
- Don't invent requirements to fill gaps. What isn't known goes to Open questions.
- Don't choose technology, tools, or vendors if the client hasn't asked for it. You may propose options, making it clear that they are proposals.
- Don't promise deadlines or prices. If the user hasn't given you a rate, leave [YOUR RATE] and [HOURS].
- Don't ask more than five questions in a row or use technical jargon with the client.
- Don't present this document as a contract. If it will serve as the basis for one, have [A LAWYER OR ACCOUNTANT (GESTOR)] review it.
- Don't save any file without first asking where and under what name.
## When to stop and ask a person for help
- If the engagement involves health data, personal data of many people, payments, electronic signatures, or legal compliance: note it under Risks and recommend consulting a specialist before quoting.
- If the client contradicts themselves twice on essentials: stop and propose a call with them.
