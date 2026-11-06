# Onboarding and Payment for a CV Order in n8n

**Type:** Automation recipe · **Area:** Jobs & résumé · **License:** CC BY 4.0 · [Spanish original](../../../recetas/n8n/empleo/alta-cobro-encargo-cv-n8n.md)

An n8n automation that takes a client order, creates a Stripe payment, alerts you once it is paid and confirms to the client, until the human work starts.

## What it is and what it does

An n8n automation that collects a customer's order, generates the payment in Stripe, announces the paid order, and confirms to the customer, up to the point where human work begins. Input is a form with the details and the payment; the output is a confirmation to the customer and an internal alert. Google and Stripe accounts have fees and limits; confirm the current rates before charging.

## The recipe, step by step

# Automation: onboarding and payment for a CV order in n8n

## What it solves
When someone wants to hire the CV and cover letter service, this automation collects their details, generates the payment, notifies Nahuel of the paid order, and confirms to the customer, without Nahuel having to watch his phone all day.

## Accounts needed
- n8n (the free plan on n8n Cloud has a monthly execution limit; check the current limit before launching in production, or use self-hosted n8n, which is free but has to be maintained).
- Google, for Drive and Sheets, free with a regular Gmail account.
- Stripe, free to create the account, charges a fee on each payment (check the current rate for Spain on its website before setting prices).
- Telegram (free bot) or Gmail for notifications.

## Nodes, in order
1. Trigger: Webhook that receives a form submission (Typeform, Google Forms with Apps Script, or your own form) with name, email, attached CV, link to the job posting, and which service they want to hire.
2. Google Drive node: creates a folder named after the customer and uploads the received CV into it.
3. HTTP Request node to the Stripe API (or the Stripe node if available): creates a payment link with the amount according to the chosen service.
4. Gmail node: sends the customer the payment link and explains the next step.
5. Second trigger, in a separate workflow or with a different Webhook node: receives the Stripe event when the payment is confirmed (checkout.session.completed).
6. Google Sheets node: adds a row with customer, service hired, amount, date, and status "paid".
7. Telegram node (or Gmail): sends Nahuel an alert with the customer's name, what they bought, and the link to the Drive folder, so he can start the job.
8. Gmail node: sends the customer a confirmation email with the delivery time and what they will receive.

## How to test it without messing up
Turn on Stripe's test mode before touching anything real: generate fake payments with the test cards from its documentation. Fill in the form with made-up data and check that the folder is created correctly in Drive, that the alert reaches Telegram, and that the row in Sheets has the correct data. Only when all of that works without errors, switch the Stripe keys from test to live.

## What NOT to do
Do not enable the live Stripe keys until you have tested the complete flow with the test keys.
Do not store the customer's card details in any node: Stripe handles that, and n8n must never see them.
Do not promise the customer an immediate automatic delivery: the alert to Nahuel is what actually triggers the human work.
