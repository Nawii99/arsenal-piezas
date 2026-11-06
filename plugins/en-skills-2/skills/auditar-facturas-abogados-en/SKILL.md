---
name: auditar-facturas-abogados-en
description: Reviews outside counsel invoices against the engagement letter or quote: rates, hours, expenses, taxes, and trends by matter. Use it when a company wants to check what its law firms are charging before paying or renegotiating.
---

# Outside Counsel Invoice Audit

Where it goes: save it as .claude/skills/auditar-facturas-abogados/SKILL.md inside your working folder. It activates when you ask for something similar; you can also call it by name.

## What it does
It compares what a law firm charges with what was agreed and flags what deserves a question. It is a review of figures. It is not legal advice and does not decide what counts as an improper charge.

## Risks you should know about before starting
- Lawyers' invoices can describe sensitive matters: litigation, dismissals, transactions. This is confidential company information and may be protected by attorney-client privilege (professional secrecy). Before passing the detail to Claude Code, ask permission from whoever is responsible for legal matters at the company. If you do not have it, redact names and descriptions and leave dates, hours, amounts, and matter codes.
- If you are an outside party, sign a confidentiality agreement first and, if there is personal data, a data processing agreement (Article 28 of the GDPR).
- Finding a difference does not prove an error. There may be later or verbal agreements. The firm is always asked first.

## What to ask before starting (all at once)
1. What documents are there? Engagement letter, quote, framework agreement, agreed rates, company rules for legal providers, invoices, and time detail.
2. What period and which matters are being reviewed?
3. How was billing agreed? Hourly, fixed price, by phases, retainer, or success fee. Is there a cap or maximum budget?
4. What is the rate for each category (partner, associate, junior, paralegal)?
5. Are there written rules? For example, no billing for secretarial time, a limit on meeting attendees, or prior approval of expenses. If there are none, I use indicative criteria and say so clearly.
6. Who decides what is asked or negotiated?
7. From what amount do you want manual review? [THRESHOLD IN EUROS]

## Step by step
1. Document inventory: what there is and what is missing. If there is no engagement letter or rates, you can only review form and arithmetic. Say so at the start of the report.
2. Put the data into a table: invoice, date, matter, item, hours, rate, amount, expenses, VAT (IVA), and withholding. Do not make any up.
3. Form checks: mandatory data under Spain's Invoicing Regulation (Real Decreto 1619/2012), numbering, that the arithmetic adds up, VAT (IVA), personal income tax (IRPF) withholding where applicable, and disbursements (suplidos) with receipts.
4. Checks against what was agreed: rate per person versus the agreed one, rate increases mid-matter, total versus quote or cap, phases invoiced in advance, unforeseen or undocumented expenses, and retainer advances (provisiones de fondos) not deducted.
5. Time detail checks, if available: the same work on two invoices; several people at the same meeting; administrative tasks billed as legal work; entries always rounded up; vague descriptions such as "study of the matter"; more than [N] hours per day from the same person; junior training work; low-level tasks billed at partner rate.
6. Present each point from the two previous steps as "to be clarified," not as an error. Only a sum or calculation mistake is an error.
7. Trends: by matter, by month, and by person, with hours, amount, and percentage of the total, versus the budget. Flag deviations above [THRESHOLD IN %]. With few invoices, say there is not enough data to speak of a trend.
8. Amount in question in three columns: certain (calculation error or against a written rate), probable (against a documented rule), and to ask (judgment call). Do not add it up as "savings": it is not recoverable money.
9. Draft message to the firm: neutral tone, numbered questions, and a reasonable deadline of [DEADLINE]. A person at the company sends it.

## What to return and in what format
Markdown with tables, amounts in euros with two decimals, and dates in DD/MM/YYYY. In this order:
1. Six-line summary: scope, documents used, number of invoices, amount reviewed, amount in question across the three columns, and what is missing.
2. Table of findings: number, invoice, what is seen, agreement or rule it relies on, amount, level, and question for the firm.
3. Table of trends.
4. Draft message to the firm.
5. "For a person to decide" list.

## What NOT to do
- Do not say there is fraud, bad faith, or an improper charge. Use "difference" or "to be clarified."
- Do not invent rates, agreements, or rules. Whatever is not in writing is presented as an indicative criterion.
- Do not interpret contracts or give opinions on whether the work was necessary or on case strategy. A lawyer decides that.
- Do not pay, reject, return, or send anything.
- Do not mix data from different companies in the same report.
- Do not promise savings.
- Do not use a finding in an open dispute without the company's lawyer seeing it.

## When to hand over to a person
- Differences above [THRESHOLD IN EUROS].
- Open dispute with the firm or success fees.
- Doubts about attorney-client privilege.
- Firms in another country, where taxes differ.
- Bar associations (colegios de abogados) usually have a channel for fee inquiries: ask the bar association of the firm.
