# Terms of Sale: Draft for Review

**Type:** Prompt · **Area:** Legal & contracts · **License:** CC BY 4.0 · [Spanish original](../../../prompts/legal/asiento-condiciones-venta.md)

Prompt that drafts general sales conditions for a Spanish online shop, with blanks and clauses that need a lawyer. The output is a working draft only.

## What it is and what it does

A prompt that drafts general terms and conditions of sale for a Spanish online store, with marked blanks and clauses that need a lawyer. Before writing, it asks what is sold, to whom, where invoices are issued from, and what payment and shipping methods exist. Input: that information; output: a working text that is not valid until a professional signs it. Paste it into Claude, Codex, Gemini, or a local AI.

> **Note:** this touches a sensitive topic (health, legal, finance or security). Use it as a helper and have a professional review the result before you deliver it.

## The prompt (copy it whole)

```text
Act as a cautious drafter of general terms and conditions of sale for an
online store that sells from Spain.

IMPORTANT, say it at the beginning and at the end of your answer: what you produce is a
working DRAFT for a lawyer or a consultancy to review. It is not a valid
document until someone with professional responsibility signs it.

Before writing anything, ask me only what is essential:
- What exactly is being sold and whether it is a physical product, a digital product, or a service.
- To whom: end consumers, businesses, or both.
- From where invoices are issued and to which countries goods are shipped.
- Payment and shipping methods, with real lead times.
- Whether there are subscriptions, reservations, or deferred payments.

If any answer involves special regulation (minors, healthcare products, food,
alcohol, supplements, financial products, health data), **stop and
tell me** instead of continuing: a specialist is needed there.

Then draft the document with these sections, in plain language and without
verbiage:
1. Who is selling (full identification).
2. Purpose and scope.
3. Purchase process and confirmation.
4. Prices, taxes, and shipping costs.
5. Payment methods.
6. Delivery times and method, and what happens if they are not met.
7. Right of withdrawal: period, how it is exercised, form, and exceptions.
8. Warranty and lack of conformity.
9. Returns and refunds: period and method.
10. Customer service and complaints.
11. Personal data: reference to the privacy policy.
12. Governing law and dispute resolution.

Rules when writing:
- Do not invent deadlines, amounts, or obligations: if I have not given them to you, leave a
  blank marked as [PENDING: ...] and tell me what is missing.
- Mark with [REVIEW WITH LAWYER] each clause where the wording changes depending on
  interpretation or current regulations.
- Do not promise that the text complies with the law. Say what it covers and what it does not.
- Write so that a customer can understand it, not so that it sounds like a law firm.

End with: (a) the list of pending blanks, (b) the list of clauses that
a professional has to review, and (c) the documents that are also needed and that
this text is NOT: legal notice, privacy policy, and cookie policy.
```
