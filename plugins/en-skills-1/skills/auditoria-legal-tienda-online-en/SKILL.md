---
name: auditoria-legal-tienda-online-en
description: Audits the legal texts of a Spanish online store (legal notice, terms of sale, returns, privacy, cookies) and produces a failure report ready to deliver to a client. Activates when the user asks to review the legal side of a store or to prepare an audit to sell.
---

## What it does

Turns a basic legal review of an online store into a report with a name on it that you can deliver to a client. It does not replace a lawyer: it detects what is missing or wrong at a glance, which in most small stores is a lot.

## What to ask before starting

1. The store's URL and, if the user has them, the direct URLs of: legal notice (aviso legal), terms of sale, returns policy, privacy policy, and cookie policy. If you can't browse, ask them to paste the text of each page.
2. What the store sells (physical product, digital, services) and whether it sells only in Spain or also abroad.
3. Whether the owner is a freelancer or a company, if they know.
4. Whether the report is for the user themselves or to hand to a client (this changes the tone, not the content).

## Step by step

1. **Legal notice (aviso legal)**: check that the owner's name or company name, NIF (Spanish tax ID), postal address, and a contact email appear. This is the first thing that is missing in small stores.
2. **Terms of sale**: check that they exist and cover prices including IVA (Spanish VAT), shipping costs before payment, delivery times, and what happens if the order arrives wrong.
3. **Returns**: check that the 14 calendar-day right of withdrawal for consumers is communicated, who pays for return shipping, and whether the applicable exceptions are mentioned (personalized products, items sealed for hygiene reasons, digital content already downloaded).
4. **Privacy**: check that the policy says who the data controller is, what the data is used for, how long it is kept, who it is shared with (payment gateway, couriers, email marketing), and how to exercise rights.
5. **Cookies**: check that there is a banner with a real option to reject (not just "accept") and a policy that lists the cookies. A banner that doesn't let you reject is among the most frequently reported failures.
6. **Checkout**: check that the total price including IVA is shown before paying and that there is a checkbox or notice for accepting the terms.
7. **Invoices**: ask whether the store issues an invoice when the customer requests one. It must be able to issue one.
8. Classify each finding as **Serious** (the text is missing or something clear is breached), **Improvable** (exists but incomplete), or **OK**.

## What to return and in what format

A Markdown report with: cover page (store, date, who is auditing), a 3-sentence summary, a findings table (area, status, what is missing, why it matters in one jargon-free sentence), and a final list of fixes ordered by severity. That final list is the one the user can quote as a second service, item by item.

## What NOT to do

- Don't cite specific articles of laws or penalty amounts if you are not completely sure; write "[confirm with a professional]".
- Don't draft the corrected texts inside the report: that is the next service, don't give it away here.
- Don't state that the store "complies with the law" or that the report "guarantees" anything. Always say it is an indicative review and that doubtful cases must be seen by a lawyer.
- Don't invent the content of pages you could not read: mark them as "Not reviewed" in the table.
