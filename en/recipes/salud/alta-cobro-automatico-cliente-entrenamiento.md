# Automatic Onboarding and Payment for an Online Training Client

**Type:** Automation recipe · **Area:** Health & fitness · **License:** CC BY 4.0 · [Spanish original](../../../recetas/n8n/salud/alta-cobro-automatico-cliente-entrenamiento.md)

n8n workflow that, on a confirmed Stripe payment, reads the Typeform questionnaire, generates a training plan, emails it and logs the client in a sheet.

## What it is and what it does

An n8n flow that, when a payment is confirmed in Stripe, reads the Typeform questionnaire, generates the training plan, sends it by Gmail, and saves the client record in Google Sheets. Input is the payment and the answers; the output is the plan by email and a new-client row. Requires Stripe, Typeform, Google, and n8n accounts. Because it involves personal and health data, a professional reviews each plan.

> **Note:** this touches a sensitive topic (health, legal, finance or security). Use it as a helper and have a professional review the result before you deliver it.

## The recipe, step by step

## What this automation does
When a new client pays for their training plan, the plan is generated automatically, sent to them by email, and their record is saved in a spreadsheet that works as a CRM.

## Accounts you need
- n8n (cloud version with a free trial, or free self-hosted if you install it yourself).
- Typeform, free plan up to 10 responses per month; if you expect more clients, a paid plan.
- Stripe, no monthly fee, charges a fee per transaction in Spain (approx. 1.4% + 0.25 euros with European cards).
- Gmail or Google Workspace account, free.
- Google Sheets, free with any Google account.

## Nodes, in order
1. Trigger: 'Stripe Trigger' with the 'checkout.session.completed' event, so it starts only when the payment is confirmed, not before.
2. HTTP Request node to Typeform (or the native Typeform node) to fetch the answers to the onboarding questionnaire the client filled in before paying, matching by their email.
3. AI node (HTTP Request to the Claude API, or n8n's AI node) to which you pass the client's data with the prompt from the 'plan-entrenamiento-vendible' skill to generate the plan.
4. 'Convert to File' or 'HTML to PDF' node to turn the plan text into a PDF with your logo.
5. Gmail node, 'Send Email', with the PDF attached and a welcome message to the client.
6. Google Sheets node, 'Append Row', to save in your clients sheet: name, email, sign-up date, amount paid, and date of the next payment if it is a subscription.
7. Gmail or Telegram node to notify you that a new client has come in.

## How to test it without messing up
Use Stripe's test mode (card 4242 4242 4242 4242) to simulate a payment without actually charging. Check that the email arrives with the correct PDF and that the new row appears in the sheet before activating the flow with real payments.

## What NOT to do
- Do not send the plan before the payment is confirmed: always use the payment-completed event, not the 'checkout started' one.
- Do not put the client's health data (injuries, medication) into tools you don't control or into shared sheets without permission; it is sensitive data under the GDPR (RGPD).
- Do not automate sending through WhatsApp with the personal app: use the official WhatsApp Business API or Gmail, because sending automated mass messages from a regular WhatsApp can get your number blocked.
