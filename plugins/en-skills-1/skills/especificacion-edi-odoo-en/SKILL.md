---
name: especificacion-edi-odoo-en
description: Prepares the specification of an EDI integration (EDIFACT or X12) with Odoo from the customer's guide, with mapping tables, validations, test cases, and a go-live plan. Use it when asked to connect Odoo with orders, shipping notices, or invoices via EDI.
---

# EDI specification with Odoo for small businesses

## What it does
It prepares the project blueprint: which EDI message arrives or goes out, what each piece of data means, and where it goes in Odoo.
It installs nothing and does not touch your Odoo. It delivers a document that an Odoo integrator or an EDI operator can implement.
EDI is the exchange of documents between companies in fixed formats: order, confirmation, shipping notice, and invoice. In Europe EDIFACT is widely used (in Spain, the AECOC EANCOM guides). X12 is more common in the US.
| Document | EDIFACT | X12 |
| --- | --- | --- |
| Order | ORDERS | 850 |
| Order confirmation | ORDRSP | 855 |
| Shipping notice | DESADV | 856 |
| Invoice | INVOIC | 810 |
Real risk: an erroneous shipping notice or invoice can lead to returns, payment delays, or penalties from the customer. Check your contract: [PENALTIES].

## What to ask before starting
Ask everything together, as a list, and wait. Without the customer's guide there is no reliable specification: ask for it first.
1. Who the trading partner is, which messages it requires, in what format and version (for example, an EDIFACT or X12 directory version). Ask for the PDF of its implementation guide and sample files.
2. How the messages travel: EDI operator, AS2, SFTP, or email. Whether you already have an operator and who pays for it.
3. Odoo version, whether it is Community or Enterprise, where it is hosted, which modules you use (sales, inventory, invoicing, Spanish localization), and who your integrator is.
4. How you identify customers and products today: location codes (GLN), barcodes (GTIN or EAN), or your own references. Whether there is a cross-reference table.
5. Volume: orders per day or week, peaks, and lines per order.
6. Who resolves errors when an order does not come in, and during what hours.
7. Certification deadlines required by the customer.
8. How you issue invoices today and whether they comply with Spanish regulations on electronic invoicing and invoicing systems: [CONFIRM CURRENT DATES AND OBLIGATIONS WITH YOUR TAX ADVISOR (GESTOR)].

## Step by step
1. Read the partner's guide and summarize it on one page: messages, mandatory and optional data, codes it uses, and response times. Mark doubts with [ASK THE PARTNER].
2. Make a mapping table per message with these columns: message segment or field, what it means in plain language, where it goes in Odoo, transformation rule, mandatory yes or no, example, and doubt.
3. Example of mapping an EDIFACT order: BGM is the customer's order number and goes to the customer reference of the sales order. DTM carries the order date and the requested delivery date. NAD distinguishes buyer, delivery location, and who receives the invoice. LIN, PIA, and IMD identify the product. QTY is the quantity and PRI the price. In X12 850, BEG, N1, PO1, and their companions do the same. Always confirm each one against the guide.
4. Write the input validation rules: the customer exists and is active, the product code exists, the quantity is valid, the price matches the agreed price list (within the agreed tolerance), the delivery date is feasible, the order is not a duplicate, and the credit limit is not exceeded. For each rule say what happens if it fails: reject with a reason or send to human review.
5. Describe the order flow. The message comes in, the order is created as a draft, the rules are validated, and only if everything passes is it confirmed and the confirmation returned. If something fails, it goes to an exceptions inbox with an assigned person. During the first [X] weeks, everything goes through human review (parallel running).
6. Describe the outputs. The shipping notice is generated from the Odoo delivery note, with packages or pallets if the customer requires it. The invoice comes from the confirmed invoice, with amounts, VAT (IVA), and totals that match the order.
7. Define exceptions and retries: duplicates, malformed messages, and technical acknowledgments (CONTRL in EDIFACT; 997 or 999 in X12).
8. Create test cases with made-up data, never real: normal order, unknown product, zero quantity, different price, duplicate order, new address, and corrupt message. For each one, the expected result.
9. Go-live plan: internal tests, tests in the partner's test environment, certification, parallel running, and production. Who approves each step.
10. List of open questions for the integrator and the operator, with [BUDGET] and deadlines to be confirmed.

## What to return and in what format
- A document `especificacion-edi-odoo.md` with: summary, mapping tables per message, validation rules, flows as step lists (no complicated diagrams), test cases, plan, and open questions.
- The test cases also as a semicolon-delimited CSV, to open in Excel.
- Each technical term, explained in parentheses the first time.
- Each piece of data with its source: page of the guide or partner sample. If it is not recorded, write [NOT STATED IN THE GUIDE].

## What a person reviews before implementing
- Your operations or logistics lead: that the flow matches how you really work.
- The Odoo integrator or a developer: that it is feasible and what the exact field names are in your version.
- Your tax advisor (gestor) or administration: the invoices and taxes part.
- The trading partner: who confirms your interpretation of their guide in their test environment. Claude can make mistakes with codes and versions. Everything is checked against the guide.

## What NOT to do
- Do not invent segments, codes, or fields that are not in the guide.
- Do not assume that two customers use the same format even if the message has the same name.
- Do not paste into the chat real orders with contact persons' data (names, phones, emails). The GDPR applies. For testing, made-up data.
- Do not touch the Odoo production database or install modules on it. Everything is tested on a copy.
- Do not enable automatic order confirmation or sending invoices by EDI without a parallel-running period and the sign-off of the responsible person.
- Do not promise that it will be "certified." Certification is granted by the trading partner.
- Do not assume that an Odoo module exists that solves everything. Before recommending one, check what it covers, for which version, and who maintains it: [MODULE AND VERSION].
- Do not store usernames, passwords, or keys (SFTP, AS2, Odoo) in the specification or in the chat.

## Where to save it
Save this file as `.claude/skills/especificacion-edi-odoo/SKILL.md` in your project. Claude uses it when you ask for something similar, or you call it with `/especificacion-edi-odoo`.
Text reviewed in October 2026. Odoo versions and invoicing obligations change: confirm them before closing the project.
