---
name: factura-consulta-sanitaria-en
description: Generates the content of an invoice for healthcare services in Spain (VAT-exempt or with VAT depending on the service) from the minimum data. Activated with /factura-consulta-sanitaria-en followed by the data, or without data so that it asks for it.
---

## What it does

Drafts the complete content of an invoice with all the mandatory fields of Spanish Royal Decree 1619/2012, applying the Spanish VAT (IVA) exemption under article 20.Uno.3 of Law 37/1992 when it applies and warning when it does not.
It returns text to paste into your invoicing software or template. It does not issue the invoice: you do that from your software, which handles the numbering.

## What to ask before starting

If they don't come with the command, ask for this data in a single message:

1. Your issuer details: full name or company name, tax ID (NIF), address, profession, and professional registration number. (Only the first time; afterwards tell them to save it in a file in the project folder and have it read from there.)
2. Patient details: name, NIF, address. If the patient doesn't provide a NIF and the amount is under €400, a simplified invoice can be made without their details, but many ask for it with a NIF for the insurer or to claim deductions where a deduction exists. Ask.
3. Service: what was done (no clinical detail: "physiotherapy session", not "treatment of L4-L5 hernia"), date, number of sessions, and amount per session.
4. Invoice number and series: your software gives them to you. If you don't have software, leave it as [NUMBER] and warn that numbering must be consecutive and without gaps.

## Step by step

1. Decide whether the service is VAT-exempt. The rule: care provided to individuals by medical or healthcare professionals (qualified under Law 44/2003 on the regulation of healthcare professions) is exempt when it consists of diagnosis, prevention, or treatment of illness. Exempt examples: physiotherapy, podiatry, dentistry, speech therapy, psychology by a general health psychologist or clinical psychologist, nursing, dietitian-nutritionist in health treatment. Examples with 21% VAT: purely aesthetic treatments, coaching, workshops, product sales, reports for third parties that are not care (expert opinions).
2. If in doubt, don't resolve it yourself: put the invoice as exempt with a clear notice at the end saying 'CONFIRM WITH YOUR TAX ADVISOR WHETHER THIS SERVICE IS EXEMPT'. A badly made invoice can be corrected; an invented tax criterion is expensive.
3. Draft the invoice with these fields, in this order:
   - Number and series.
   - Issue date and operation date if different.
   - Issuer: name, NIF, address, profession, and professional registration number.
   - Recipient: name, NIF, address.
   - Description: description without clinical data, dates, number of sessions, unit price.
   - Taxable base.
   - VAT: if exempt, the line says exactly 'Operación exenta de IVA según el artículo 20.Uno.3 de la Ley 37/1992' (VAT-exempt operation under article 20.Uno.3 of Law 37/1992). If not, 21% rate and amount.
   - Personal income tax (IRPF) withholding: only if the recipient is a company or a professional (a clinic that subcontracts you, a mutual insurance fund). Never applied to a private patient. General rate 15%; 7% during the year you register as self-employed and the following two years if you have requested it.
   - Total payable.
   - Payment method and account or means.
4. Add at the foot: 'Keep this invoice. Invoices must be kept at least 4 years for tax purposes and 6 years under the Commercial Code'.
5. Finish with two short notices addressed to the user, not to the patient: (a) invoicing software must comply with the Spanish tax agency's Verifactu system and [CHECK WITH YOUR TAX ADVISOR FROM WHAT DATE IT AFFECTS YOU]; a Word or Excel template may stop being valid; (b) if payment is in cash, remember the legal limit of €1,000 when one of the parties is a professional.

## What to return

- The invoice in plain text, with the fields aligned, ready to copy.
- One line saying: 'Exempt' or 'With 21% VAT' and why, in one sentence.
- The two notices from step 5.

Nothing more. Do not explain the entire law every time.

## What NOT to do

- Do not invent the invoice number. If you don't have it, use brackets.
- Do not put diagnoses, pathologies, or specific treatments in the description. It is health data and the invoice ends up with an insurer, a company, or in a shared drawer.
- Do not apply IRPF withholding to private individuals.
- Do not decide yourself whether a doubtful service is exempt. Warn and continue.
- Do not issue invoices dated earlier than the last one issued.
- Do not add 'handling fees' or surcharges that the user has not mentioned.
