# Sell and Deliver Course Packages with n8n

**Type:** Automation recipe · **Area:** Education · **License:** CC BY 4.0 · [Spanish original](../../../recetas/n8n/educacion/automatizacion-venta-paquetes-curso.md)

n8n workflow that takes a course package order, charges via Stripe, generates course material with AI and emails it, with a human check before sending.

## What it is and what it does

An n8n flow that collects an order from a form, charges with Stripe, generates the course material with an AI, and sends it by Gmail. Input is the order with confirmed payment; the output is the material by email and a record in Google Sheets. Requires Stripe, pay-per-use API, and n8n accounts. A person reviews the material before each delivery.

## The recipe, step by step

# Automation: selling and delivering course packages

A flow designed to sell the 'create your course package' service without having to do everything by hand each time. It charges, generates the material, and delivers it on its own.

## Accounts needed
- Tally or Google Forms, for the order form (free plan is enough).
- Stripe, to charge (creating an account is free, charges a fee per transaction, around 1.5% plus 0.25€ on European payments).
- An account with access to the Claude API or similar, to generate the material (paid by usage, check the current price before setting your rate).
- Gmail or an SMTP server, to send the material by email (the free Gmail plan allows about 500 sends per day).
- Google Sheets, to keep the order record (free).
- n8n self-hosted (free, you maintain it) or n8n Cloud (temporary free trial, then paid plans).

## Nodes, in order
1. Trigger: Webhook or Tally/Google Forms node, which fires when someone submits the order (course topic, level, number of students, email).
2. Stripe node (Create Payment Link or Checkout Session): generates a payment link with the price calculated according to what the customer selected in the form.
3. Send Email node: sends the payment link to the customer, and the flow stops there until they pay.
4. Stripe Trigger node (it verifies the webhook signature): listens for the 'checkout.session.completed' event. If you use a generic Webhook, first verify the Stripe-Signature header with the endpoint's "signing secret". Before continuing, check that payment_status is paid and store the event id so the material is not generated or sent twice if it arrives repeated.
5. HTTP Request node: calls the AI's API with the course package generation prompt, using the JSON product sheet with the form data.
6. Function or Code node: formats the text the AI returns and prepares it to be converted into a PDF.
7. PDF conversion node (an external service or a template): generates the final document that is delivered.
8. Send Email node: sends the PDF to the customer as the delivery of their order.
9. Google Sheets node (Append Row): saves the order, the price charged, the date, and whether it has been delivered.

## How to test it without messing up
- Turn on Stripe's test mode first of all: that way you don't charge real money while testing the flow.
- Fill in the form yourself with your own email as the customer and check that the payment link, the payment-received notice, and the final PDF arrive.
- Always review the PDF the AI generates before sending it to a real customer: it may have errors that need to be fixed by hand.
- Don't turn on Stripe's live mode until you have completed at least three end-to-end tests without failures.
