---
name: cierre-trimestral
description: command that guides the collection of all the quarter's invoices and expenses to leave them ready for Spanish form 303 (VAT) and form 130 (income tax advance payment), in a single pass
---

# /cierre-trimestral

## What it does
Guides the close of a tax quarter in Spain: gathers issued invoices, received invoices, expenses pending justification, and advance payments, so you don't have to hunt for everything on the last day.

## What to ask before starting
- Which quarter is being closed and what is its deadline (April 20, July 20, October 20, and January 30 for Q4)?
- Where do you keep your invoices (folder, email, invoicing app)?
- Do you file form 130 (IRPF advance payment, i.e. Spanish personal income tax) in addition to form 303 (IVA, i.e. Spanish VAT)?

## Step by step
1. Ask the user for the folder or source where the quarter's issued and received invoices are.
2. List the issued invoices: number, date, client, taxable base, IVA, withholding if applicable.
3. List the received invoices: supplier, date, taxable base, IVA, whether they are 100% deductible or partially.
4. Point out gaps: missing invoices (for example, if there is a month with no expense invoices at all, ask whether that is real or whether one still needs to be uploaded).
5. If the user files form 130, calculate the advance payment: 20% of the quarter's net income, minus advance payments already made.
6. Deliver a final summary with two separate blocks: 'ready for 303' and 'ready for 130', and a list of pending items.

## What to return
A summary in two blocks (IVA and, if applicable, quarterly IRPF) plus a list of invoices or data still to be confirmed.

## What NOT to do
Don't treat the close as complete if invoices are missing: say so explicitly, a badly closed quarter generates surcharges if the Spanish tax authority (Hacienda) reviews it.
Don't calculate form 130 if the user is under the flat-rate module regime (módulos) instead of direct estimation: the calculation is different, ask first.
