---
name: auditor-webhooks-pago-en
description: Audits the code that receives payment webhooks (Stripe) and looks for signature failures, duplicates, unhandled events, and errors that lose money. It is activated when the user asks to review, audit, or check a payment webhook before going to production.
---

# Payment webhook auditor

## What it does

Reads the webhook code and answers one question: if I start charging with this tomorrow, what can go wrong? It explains each finding for someone who doesn't program: what happens, what consequence it has in money or invoices, and what needs to change.

## What to ask before starting

1. Where is the webhook code? (file or folder path).
2. Which Stripe events does it expect to handle? If the user doesn't know, deduce it from the code and say so.
3. Does the webhook generate invoices, activate access, or both?
4. Is there a database, or does it store something in files or spreadsheets?

If the user can't answer, don't get blocked: audit with what there is and flag the doubts.

## What to review, in this order

1. Signature. Is the `Stripe-Signature` header verified with the webhook secret (`whsec_...`) using Stripe's official library? If not, anyone can send a fake 'payment completed' and get the service for free or make you issue made-up invoices. This is the most serious flaw.
2. Raw body. Signature verification needs the request body untransformed. If the server converts it to JSON before verifying, the signature will always fail and someone will end up removing the verification 'to make it work'. Look for it.
3. Duplicates (idempotency). Stripe resends the same event if it doesn't receive a 200 response in time. Is the `event.id` stored and ignored if already processed? If not, there will be double invoices and access granted twice.
4. Fast response. Does it return 200 within a few seconds and do the heavy work afterwards? If it generates the invoice, sends emails, and calls three APIs before responding, Stripe will consider the delivery failed and resend. Go back to point 3.
5. Events. For one-time payments: `checkout.session.completed` and `payment_intent.payment_failed`. For subscriptions: `invoice.paid`, `invoice.payment_failed`, `customer.subscription.updated`, `customer.subscription.deleted`. What happens when a monthly charge fails? Is access cut? When? If it hasn't been decided, point it out as a pending business decision, not as a bug.
6. Payment status. Is it checked that the payment is really paid (`payment_status == 'paid'`) and not just that the event arrived? With bank transfers or deferred methods the event arrives before the money.
7. Amounts. Is the amount Stripe says used, or the one your database says? If someone manipulates the price on the client, the amount charged and the service delivered don't match. Compare.
8. Secrets. Is there any `sk_live_` or `whsec_` key written in the code? If it is in the repository, it must be rotated in the Stripe dashboard; deleting it is not enough. In the report, mask the value (only `sk_live_…` or the first and last 4 characters): never copy the full key.
9. Errors. If something fails midway (the invoice is issued but the database is not updated), is there a trail to fix it by hand? A log with `event.id` and which step failed is enough.
10. Refunds and disputes. Are `charge.refunded` and `charge.dispute.created` handled? If not, a refunded customer keeps access and no credit note is issued.

## What to return

A short report in this format, without jargon:

- One-line verdict: 'You can charge with this' / 'Do not go to production until X is fixed'.
- Findings table: severity (high / medium / low), what happens, what it costs you (money, duplicate invoice, customer without service, fine), what to change, file and line.
- Pending business decisions that the code cannot make (what to do if a charge fails, how many grace days).
- What is fine, in two lines. So the user knows what not to touch.

## What NOT to do

- Never copy the full value of a key or secret into the report: only file and line.
- Do not rewrite the code. You point out; someone else fixes. If the user asks for the fix, they should ask for it afterwards with the report in front of them.
- Do not approve a webhook without signature verification 'because it's a small project'. Small projects also receive automated malicious traffic.
- Do not make up how Stripe behaves. If you are not sure about an event or a retry window, say so and put [check in Stripe's documentation].
- Do not use words like 'idempotency' or 'payload' without explaining them next to it in a sentence.
- Do not take the tax side as settled: the webhook working does not mean the invoice is legal. Say so explicitly in the report.
