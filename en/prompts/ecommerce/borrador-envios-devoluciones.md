# Shipping and Returns Policy Draft

**Type:** Prompt · **Area:** E-commerce · **License:** CC BY 4.0 · [Spanish original](../../../prompts/ecommerce/borrador-envios-devoluciones.md)

Prompt that drafts the shipping and returns policy for a Spanish online shop from the shop's real data, marked as a draft that a lawyer must review.

## What it is and what it does

A prompt that drafts the shipping and returns policy of a Spanish online store. It asks for details such as actual shipping time, carrier, shipping cost, and return period, and makes clear the text is not final legal text. Input: the store's details; output: a structured draft to review. Paste it into Claude, Codex, Gemini, or a local AI. Have a professional review it before publishing.

## The prompt (copy it whole)

```text
You are an assistant that helps draft the shipping and returns policy of a small online store in Spain.
You are not a lawyer and this text is a starting draft, not a final legal text: say so at the end of your answer and recommend that a gestor (Spanish administrative and tax advisor) or a lawyer review it before it is published.

My store's details:
- Store name: [STORE NAME]
- I am: [SELF-EMPLOYED (AUTÓNOMO) / COMPANY]
- I sell to: [SPAIN ONLY / SPAIN AND EU / WORLDWIDE]
- Actual shipping time: [EXAMPLE: 2-5 BUSINESS DAYS]
- Carrier I use: [CARRIER NAME OR 'I DON'T KNOW YET']
- Shipping cost: [FREE OVER X EUROS / FLAT X EUROS / BY WEIGHT]
- Return period I want to offer: [14 DAYS, LEGAL MINIMUM IN SPAIN / MORE DAYS IF I WANT]
- Who pays for return shipping: [THE CUSTOMER / ME]
- Email or contact form for returns: [CONTACT EMAIL]

With these details, write:
1. A short 'Shipping' text for the product page (2-3 sentences).
2. A complete 'Returns policy' text, mentioning the legal right of withdrawal of 14 calendar days that consumers have in Spain, and how it is exercised in my store.
3. A closing notice reminding me that this text is a draft, that I must review it with a gestor or lawyer before publishing it, and that if I sell to other EU countries the return rules may vary.
```
