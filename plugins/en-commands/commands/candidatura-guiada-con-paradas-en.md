---
name: candidatura-guiada-con-paradas-en
description: Takes a job posting from start to finish in six stages with a stop at each one (screening, research, tailoring the résumé, writing the cover letter, preparing the application, and following up). It never sends anything for you.
---
# Guided job application, with stops

Arguments received: $ARGUMENTS
(This is the job posting, pasted, in a file, or as a link. Or the word "seguimiento" (follow-up) to review pending applications.)

## Where to save it
Save this file as `.claude/commands/candidatura-guiada.md` in your job-search folder and type `/candidatura-guiada-con-paradas-en` followed by the job posting.

## What it does
It chains all the work of a job application into a single command. It prepares the documents and hands them to you so you can review and send them yourself. Between one stage and the next it stops and waits for your "ok".

## Why it doesn't send on its own
- Job portals and LinkedIn often prohibit bots, mass scraping of postings, and automated applications in their terms. Automating can cost you your account. Read each portal's terms.
- Sending many identical applications is noticeable. Better to send few, well reviewed ones.
- An application sent with false data or with another company's name cannot be undone.
- That is why this command does not log in to any portal, does not fill in forms, and does not send emails.

## Before starting, ask
1. The résumé and profile, in files or pasted. If it is for someone else, have they given written permission?
2. Target position, city or remote, minimum salary, and what they would not accept (shifts, commuting, type of contract).
3. Submission channel: email, InfoJobs, LinkedIn, or the company's website.
4. Language of the documents.
5. The maximum number of applications per day they want to send. Suggest few.
6. If `candidaturas/seguimiento.csv` exists, read it so you don't repeat a company and to see how many have gone out today. Warn if the limit is reached.
7. If there is no job posting, do not look for one by crawling portals. Ask what they are looking for and suggest search keywords and places to look manually.

## The six stages
Do one stage, show the result, and wait for "ok" or changes.

### 1. Screen
- Compare the posting with the profile: essential requirements met, those not met, and whether the salary and conditions fit.
- Red flags: no company name, commission-only pay without saying so, asking for money, ID photos, or bank details before hiring, promises of easy income. If there is any, recommend not continuing.
- Give a decision (go ahead, hesitate, or discard) with three reasons. If it is discard, stop here.

### 2. Research the company
- Use what the person pastes or the company's official website, if internet access is enabled. State the source of each fact.
- What it does, approximate size if known, recent news, and one specific reason for wanting to join. If something is not known, write "not known".

### 3. Tailor the résumé
- Create a copy at `candidaturas/YYYY-MM-DD-company/cv.md`. Do not touch the original.
- You may only reorder, summarize, and highlight what is already there. Prioritize what the posting asks for. Do not add anything that is not in the profile.
- Show in a short list what you moved or cut.

### 4. Cover letter and draft of the submission
- Write the letter, 180 to 250 words and in plain text, with the reason from stage 2 and two real achievements.
- Prepare the email or the form text: subject, short body, and list of attachments.
- If Gmail is connected through MCP, you may leave the email as a draft. Do not send it.
- Your part ends here. The person reviews it and sends it.

### 5. Log
- When the person confirms they have sent it, add a row to `candidaturas/seguimiento.csv`.
- Separate the columns with semicolons, so that Excel in Spanish-locale setups opens it correctly: submission date; company; position; link; channel; status; follow-up date; notes.
- The follow-up date is the submission date plus [WAITING DAYS] business days. Suggest 7 and let the person decide.

### 6. Follow up
- It is launched with `/candidatura-guiada-con-paradas-en seguimiento`. Read the CSV and list the applications whose date has passed and that still have no reply.
- For each one, draft a short, friendly message for the person to send. Only one reminder per application. If there is no reply after the reminder, suggest closing it.
- If the person says they have already received a reply, update the status.

## What to return
- When stage 4 is done: a folder `candidaturas/YYYY-MM-DD-company/` with `cv.md`, `carta.txt`, and `correo.txt`. In the chat, a 5-line summary with the decision, the requirements not covered, what to check by hand, and the submission channel.
- In stage 6: a numbered list with the ready message under each application.
- The résumé is delivered as text to paste into your template. This command does not generate Word or PDF.

## What NOT to do
- Do not send emails, messages, or forms. Not LinkedIn messages either.
- Do not ask for or store passwords for any portal.
- Do not crawl portals or scrape. You work with the postings the person gives you.
- Do not invent experience, degrees, languages, or figures in the résumé or the letter.
- Do not reuse a letter for another company without redoing the reason and the achievements.
- Do not continue with a posting that shows signs of a scam.
- Do not send more than one reminder per application.
- Do not store the résumé or personal data outside the project folder.

## If you use it for someone else
- Ask for written authorization to process their résumé and data, and delete them when the engagement ends.
- Each submission is approved and made by the person. You do not send on their behalf.
- Do not charge per application sent: it pushes toward sending many poor ones and promising results. Charge for the preparation.
- If, besides preparing documents, you act as an intermediary between candidates and companies, you may need authorization as a placement agency (in Spain, "agencia de colocación"). Check with an advisor or a labor lawyer [TO BE CONFIRMED].
