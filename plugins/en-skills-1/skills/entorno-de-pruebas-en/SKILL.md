---
name: entorno-de-pruebas-en
description: Rules for testing marketing tools (CRM, email, payments, n8n, spreadsheets) without touching real customers or money. Use it when the user is about to run, import, send, or charge something for the first time, or says they want to test a flow, a sequence, or an integration.
---

# Safe testing environment

## 1. The one rule
Nothing is run against real data until it has worked once against fake data. If there is no testing environment, the first step is to set one up. Never test in production out of haste.

## 2. What to ask before touching anything
- Which tools are involved? (CRM, email, payments, spreadsheet, WhatsApp, n8n).
- Does any of them send messages or charge money? Those are the dangerous ones.
- Is there already a test copy or are we going to set one up now?
- Who will receive the test messages? It must be the user themselves, never a customer.

## 3. How to set it up, tool by tool
- Google Sheets or Airtable: duplicate the sheet and put `TEST -` in front of the name. The flow points to the copy. When it works, the link is switched to the real one and nothing else is touched.
- Brevo, Mailchimp, MailerLite, and similar: create a list or audience called `TEST` with 3 emails that are yours (use aliases such as yourname+test1@yourdomain.com if your email supports them). Sequences are tested against that list.
- HubSpot, Pipedrive, Zoho: they have no free sandbox on the basic plans. Alternative: import fake contacts (`/datos-falsos` command) with a `TEST` field or tag so they can all be deleted at once with a filter.
- Stripe: turn on test mode (switch in the dashboard). The keys start with `sk_test_` and `pk_test_`. Test card: 4242 4242 4242 4242, any future date, and any CVC. No real money moves.
- Shopify: create a test order with the dummy gateway (Bogus Gateway) from the payment settings, or use a development store if you have a partner account.
- WhatsApp Business API: you only send to your own number until the flow is finalized. Mass sends to numbers that have not written to you before can get the account blocked.
- LinkedIn, Instagram, TikTok: there is no test mode. Automating messages or actions on these networks can cost you the account. If the flow posts or writes, test with a node that only displays the text, and publish by hand.
- n8n: duplicate the flow and name the copy `TEST - name`. Use the step-by-step execute button. Pin a node's output data so you do not call the API again every time you test the next one. For the API you do not want to touch yet, set up the `api-de-mentira-n8n` recipe.

## 4. Data used
Only made-up data with `@example.com` emails and phone numbers with 555. Never a CSV exported from the real CRM even if it is small. If the user offers real data for testing, tell them no and generate fake data.

## 5. Checklist before going live
1. The flow has worked from start to finish at least 3 times with fake data, including a case with an empty field and another with a misspelled email.
2. It has been checked which list, sheet, card, or account each node points to. One by one, out loud if needed.
3. The test data has been deleted from the real tool or is marked for deletion.
4. The first real send goes to a small batch (5 or 10 contacts) and you wait to see the results before launching the rest.
5. There is a way to stop the flow in 10 seconds: the user knows where the deactivate button is.

## 6. What NOT to do
- Do not test an email sequence by sending it to a single real customer because they are trustworthy.
- Do not use real Stripe keys in an n8n flow that is still being built.
- Do not leave the fake contacts in the real CRM: they contaminate the statistics and end up in a send.
- Do not consider a flow tested if it has only been run with the happy case. Failures come from empty fields, accents, and duplicates.
- Do not promise the customer that the flow will never fail. Promise that it has been tested with these specific cases, and list which ones.
