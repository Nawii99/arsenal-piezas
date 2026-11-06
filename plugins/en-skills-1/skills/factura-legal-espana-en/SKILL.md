---
name: factura-legal-espana-en
description: Reviews or drafts a Spanish invoice with all mandatory fields (numbering, NIF, IVA, IRPF withholding, exemption mentions). Activates when the user says invoice, to invoice, issue an invoice, payment note, or pastes an invoice to review.
---

# Legal invoice for a freelancer in Spain

## What it does
Takes the data of a sale (or an already-made invoice) and returns an invoice with everything required by Spain's Invoicing Regulation (Royal Decree 1619/2012). If something is missing, it says so field by field. It is not tax advice: for unusual cases (foreign clients, exemptions, equivalence surcharge) it refers you to your accountant (gestor).

## What to ask before starting
Only what is not already in the message. Never invent tax data.
1. Who issues it? First and last name or company name, NIF (Spanish tax ID), registered address.
2. Who receives it? Name or company name, NIF/CIF, address. If it is a private individual without a NIF and the amount is under €400 including IVA, a simplified invoice (ticket) can be issued.
3. What is being sold? Clear description, quantity, unit price before IVA.
4. What IVA applies? 21% standard, 10% or 4% reduced, or exempt (state why: for example regulated education, healthcare, article 20 of the IVA Law).
5. Is there IRPF withholding? Only if the issuer is a freelancer (natural person) and the client is a company or freelancer. 15% standard; 7% during the year of registration and the following two. If the client is a private individual, there is no withholding.
6. What number comes next? Invoices are numbered consecutively within each series, with no gaps. Ask for the last number issued.
7. Issue date and, if different, the date the work was done.
8. Payment method and deadline (IBAN, Bizum, bank transfer, due date).

## Step by step
1. List the data received and mark what is missing. If the NIF of either party is missing, stop: without a NIF there is no complete invoice.
2. Calculate taxable base = sum of lines before IVA.
3. Calculate IVA amount = base × rate. If there are several rates, one IVA line for each rate.
4. If withholding applies, calculate withholding = base × percentage. The withholding is subtracted from the total to pay, but IVA is calculated on the base, not on the base minus withholding.
5. Total to pay = base + IVA − withholding.
6. Add the mandatory mentions when applicable: "Operation exempt from IVA under article [X] of Law 37/1992", "Reverse charge" (EU business client with a VAT number), "Corrective invoice for no. [X]" if it corrects another.
7. Assemble the invoice using the format below and go through the final checklist.

## What to return
First the invoice in plain text ready to copy into Word, Google Docs, or the invoicing software. Then the checklist.

INVOICE NO. [SERIES]-[NUMBER]
Issue date: [DD/MM/YYYY]
Operation date: [only if different]

ISSUER
[Name or company name]
NIF: [NIF]
[Full address]

CLIENT
[Name or company name]
NIF: [NIF]
[Full address]

ITEM | QUANTITY | UNIT PRICE | AMOUNT
[Description] | [n] | [x €] | [x €]

Taxable base: [x €]
IVA [21]%: [x €]
IRPF withholding [15]%: −[x €]
TOTAL TO PAY: [x €]

Payment method: [bank transfer to IBAN ES..]
Due date: [DD/MM/YYYY]
[Legal mentions if applicable]

Checklist (check each one):
- Consecutive number, no gaps compared with the previous one
- NIF and address of both parties
- A description that is understandable without asking questions
- Base, IVA rate, IVA amount, and total shown separately
- Withholding only if the issuer is a natural person and the client is a company/freelancer
- Mention of exemption or reverse charge if there is no IVA
- Issue date within the deadlines: at the latest the 16th of the month following the operation if the client is a company

## Warnings that go inside the response
- An issued invoice is not deleted or edited. If you make a mistake, a corrective invoice is issued that cancels or corrects it.
- Keep all issued and received invoices for at least 4 years (tax statute of limitations), preferably 6 because of the Commercial Code.
- The Verifactu system (invoicing with verifiable registration with the AEAT, the Spanish tax agency) has obligation dates that have changed several times. Before choosing invoicing software, check the date in force for your case on the AEAT website: [check sede.agenciatributaria.gob.es]. An Excel or Word file will not comply with it.

## What NOT to do
- Don't invent NIFs, addresses, or invoice numbers. If they are missing, leave them in brackets and say so.
- Don't apply withholding to invoices to private individuals or to clients outside Spain.
- Don't charge IVA on an invoice to a company in another EU country without checking that it has a VAT number (ROI). If you don't know, say so and refer to the accountant (gestor).
- Don't accept an IVA exemption just because the user says so: ask for the article or refer to the accountant (gestor).
- Don't mix series or restart the numbering mid-year without a reason.
- Don't turn a quote or a pro forma invoice into an invoice without changing the title and assigning a number: a pro forma has no tax validity.
