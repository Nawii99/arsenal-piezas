# Tax Calendar for a New Freelancer in Spain

**Type:** Prompt · **Area:** Finance · **License:** CC BY 4.0 · [Spanish original](../../../prompts/finanzas/calendario-fiscal-autonomo.md)

Prompt for any AI text model that builds a Spanish freelancer's quarterly and annual tax filing calendar in plain language, to verify with the tax agency.

## What it is and what it does

Prompt to paste into any text AI (Claude, Codex, Gemini, or a local AI) that generates the calendar of quarterly and annual tax forms for a self-employed person (autónomo) in Spain, explained without jargon. Input: the registration date, the activity, the income estimation regime, and the invoicing software; output: a list of forms (303, 130, 115, and 390 or 190 if they apply) with what each one is and its deadlines for the current year. The dates must be checked with the Spanish Tax Agency (Agencia Tributaria).

> **Note:** this touches a sensitive topic (health, legal, finance or security). Use it as a helper and have a professional review the result before you deliver it.

## The prompt (copy it whole)

```text
Act as an advisor who explains self-employed (autónomo) accounting in Spain to someone who knows nothing about the subject.

These are my details:
- Date I registered as self-employed (autónomo): [REGISTRATION DATE]
- Activity I carry out: [DESCRIBE YOUR ACTIVITY]
- IAE heading (the Spanish business activity tax classification) if you know it (if not, write "I don't know"): [HEADING OR I DON'T KNOW]
- I mainly invoice: [BUSINESSES / INDIVIDUALS / BOTH]
- I am under the following income estimation regime: [SIMPLIFIED DIRECT / NORMAL DIRECT / MODULES / I DON'T KNOW]
- I use invoicing software: [YES, WHICH / NO, I KEEP AN EXCEL / I DON'T KEEP ANYTHING YET]

I want you to explain to me, in simple words and without taking anything for granted:

1. Which tax forms (modelos) I have to file each quarter and each year, with their deadlines.
2. What each form is in one sentence (what the 303 is for, the 130 or 131, the 115 if it applies, and the annual summaries 390 and 190 if they apply).
3. A calendar with the specific dates of the current year for my case.
4. What happens if I miss a deadline (approximate surcharge, without giving it as an exact figure if you do not know it).
5. What documents I need to have saved before each filing.

At the end, tell me in one clear sentence whether, given my situation, it is worth having a gestor (administrative and tax advisor) or whether I can handle it myself with a simple tool, explaining why.

Do not use technical terms without explaining them the first time you use them.
```
