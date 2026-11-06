# Automatic Sale Alert with Stripe Payment Links

**Type:** Automation recipe · **Area:** E-commerce · **License:** CC BY 4.0 · [Spanish original](../../../recetas/n8n/ecommerce/aviso-venta-stripe-payment-links.md)

n8n recipe that records each Stripe Payment Link sale in a spreadsheet and sends you an email and Telegram alert at the moment of payment.

## What it is and what it does

An n8n recipe that, when someone pays with a Stripe payment link, saves the sale in a spreadsheet and alerts you by email and Telegram. It doesn't require setting up a store. Inputs are the payment link and a Stripe webhook; the outputs are the sales record and the alert at the moment of payment. Stripe charges a fee on each payment, and the rates are checked on its website.

## The recipe, step by step

Goal: every time someone pays with a Stripe payment link (Payment Link), n8n saves the sale in a spreadsheet and alerts you by email and Telegram, without setting up a full store.
Accounts needed and free limit: Stripe (free account, no monthly fee, charges a fee on each payment, see the current rate on the Stripe website), n8n (free self-hosted plan, or the n8n Cloud trial plan), Google account with Google Sheets (free), Telegram (free, you need to create a bot with @BotFather).
1. In Stripe, create a Payment Link for your product (Stripe Dashboard > Payment Links > Create). You don't need to program anything for this.
2. In n8n, add a Webhook node as the trigger. Copy the URL it generates.
3. In Stripe, go to Developers > Webhooks, add an endpoint with that URL and select the event 'checkout.session.completed'.
4. Go back to n8n and add an IF node after the Webhook: check that the 'type' field of the event equals 'checkout.session.completed', to discard other events that Stripe may send.
5. Add a Google Sheets node (Append Row operation) connected to the true output of the IF: save date, buyer's email, amount, and product, reading that data from the webhook body.
6. Add a Gmail node (Send Email) to confirm the purchase to the customer's email, using the email field from the webhook.
7. Add a Telegram node (Send Message) pointing to your own chat, so it alerts you on every sale, with the amount and the product.
8. Save and activate the workflow in n8n before testing it: a Webhook does not work in test mode without being activated.
How to test it without messing up: turn on test mode (Test mode) in Stripe, pay your own Payment Link with a Stripe test card (number 4242 4242 4242 4242, any future date and CVC), and check that the row reaches the spreadsheet and the email and Telegram alerts arrive.
Only when you see the whole test flow work, switch the Payment Link and the Webhook to live mode (Live mode) in Stripe.
Important notice: in live mode, Stripe charges a fee on each real sale; check the current rate in your country before setting your prices.
