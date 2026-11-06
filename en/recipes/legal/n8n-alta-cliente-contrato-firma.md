# Client Onboarding with Contract and Remote Signature

**Type:** Automation recipe · **Area:** Legal & contracts · **License:** CC BY 4.0 · [Spanish original](../../../recetas/n8n/legal/n8n-alta-cliente-contrato-firma.md)

n8n recipe for client onboarding: a form generates a contract from a Google Docs template, sends it for e-signature and tracks who signed.

## What it is and what it does

An n8n recipe for onboarding a new client without losing your afternoon: the client fills in a form and the flow generates the contract from your Google Docs template, sends it out for electronic signature, and records in Google Sheets who has already signed. You sign your part when the alert arrives. Requires an account with an electronic signature service.

> **Note:** this touches a sensitive topic (health, legal, finance or security). Use it as a helper and have a professional review the result before you deliver it.

## The recipe, step by step

What it does: when you close a new client, you send them a link. They fill in their details, n8n generates the contract from your Google Docs template, sends it out for electronic signature, and records everything in a Google Sheets sheet. You only sign your part when the alert arrives.

Accounts you need:
- n8n (paid Cloud or free self-hosted; the native form is included).
- Google (Docs, Drive, and Sheets): free with a personal account.
- An electronic signature service with an API. Documenso has a free plan with a monthly signature limit ([check the current limit at documenso.com]); Signaturit is the Spanish option but is paid. A simple electronic signature is valid in Spain for commercial contracts between companies and freelancers (autónomos): what matters is keeping the evidence (the signature certificate the service generates).

Before setting anything up: create your contract template in Google Docs (you can generate it with the draft prompt from this same arsenal and have a lawyer review it ONCE). Write the blanks as {{nombre_cliente}}, {{nif}}, {{importe}}, {{fecha_inicio}}.

Nodes, in order:
1. Form Trigger (n8n form). Fields: name or company name, tax ID (NIF), address, signer's email, service hired, amount excluding VAT (IVA), start date. Mark all of them as required: a contract with empty blanks is useless.
2. IF: checks that the NIF is between 8 and 9 characters long and that the amount is a number. If it fails, a branch that alerts you by email and ends. Don't generate contracts with broken data.
3. Google Docs — Create from template operation (or Google Drive: Copy file and then Google Docs: Update to replace the {{blanks}}). File name: Contract - {{nombre_cliente}} - {{fecha}}.
4. Google Drive — Export as PDF the newly created document.
5. HTTP Request to the signature service (Documenso has no native node: use its REST API with your key in the header). Upload the PDF and create the request with two signers: the client's email and yours. The service takes care of sending the signature emails.
6. Google Sheets — Append row: date, client, NIF, amount, link to the PDF, status "sent for signature".
7. Gmail — alert to yourself: "Contract sent to {{nombre_cliente}}, review and sign your part". That way the last human eye is yours, before your signature, not after.
8. (Optional) Second flow with a Webhook Trigger pointing to the signature service's "document completed" webhook, which updates the Sheets row to "signed" and forwards you the signature certificate. Always keep that certificate: it is your proof if there is a dispute.

What NOT to automate: the decision about whom you sign with and for how much. The flow prepares and sends; don't add a step that signs for you automatically.

How to test it without messing up:
1. Fill in the form with made-up data and your own email as the "client".
2. Check the generated PDF: that no {{blank}} has been left unreplaced. It is the most common failure and the ugliest in front of a client.
3. Sign it yourself from the email you received and verify that the Sheets row is updated and the certificate arrives.
4. Delete the test document from the signature service so you don't use up the free quota.
5. Only then send the form link to a real client.
