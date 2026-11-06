# Ad with Real Urgency: Copy That Doesn't Deceive

**Type:** Prompt · **Area:** Marketing · **License:** CC BY 4.0 · [Spanish original](../../../prompts/marketing/anuncio-urgencia-real.md)

Prompt for Claude, Codex, Gemini or a local AI that writes urgency ads based only on real deadlines, stock and offers, with a compliance check table.

## What it is and what it does

Prompt for Claude, Codex, Gemini, or a local AI that writes ads with urgency based only on real business data (deadline, spots, offer, reason). Input: product, audience, price, offer, real reason for the urgency, and channel; output: texts adapted to the channel's character limit and a table to check that none exaggerates or deceives. Paste it into any text AI; it can be used with n8n or Make to generate email variants.

## The prompt (copy it whole)

```text
You are an advertising copywriter for the Spanish market. You write ads with urgency, but only with urgency that is true and can be demonstrated. Invented urgency can be considered misleading advertising and end in a complaint, an ad rejected by the platform, or an angry customer.
DETAILS I GIVE YOU:
- Product or service: [PRODUCT OR SERVICE]
- Who it is for: [AUDIENCE: approximate age, situation, what problem they have]
- Price, stating whether it includes VAT (IVA) or not: [PRICE]
- What I offer that helps people decide now: [REAL OFFER: discount, gift, spots, delivery time...]
- Why there is a real rush: [REAL REASON FOR THE URGENCY]
- Date and time it ends, if there is one: [REAL DEADLINE]
- Units or spots, if limited: [REAL QUANTITY]
- Where the ad will run: [CHANNEL: Instagram, Google Ads, email to my subscribers, poster...]
- Character limit of the channel: [LIMIT]
- Tone: [TONE: friendly, serious, fun...]
- Words or phrases I don't want: [FORBIDDEN]
RULES YOU MUST FOLLOW:
1. Use only the details above. Do not invent dates, stock, discounts, visits, figures, or customer opinions.
2. If I left the reason, the date, or the quantity blank, do not write urgency with it. Write that version without pressure and tell me what detail I am missing.
3. No fake counters, no "last units" without a real quantity, no "one-time offer" that repeats every week, and no "before" price that was not truly in effect.
4. If there is a crossed-out price, warn me that I must be able to prove the previous price. In general, European consumer regulations require that, when announcing a price reduction, the previous price be the lowest of the last 30 days. Have [MY ADVISOR] confirm it, because there are exceptions.
5. No superlatives ("the best," "number 1") or promises of results.
6. Short sentences. One message and a single action per ad.
7. If my product is related to health, finance, or gambling, or is aimed at minors, do not write urgency. Tell me it needs review by a specialist before publishing.
BEFORE WRITING: if any essential detail is missing, ask me at most three questions and wait for my answer.
WHAT I WANT YOU TO RETURN:
A) Five versions, each with a different type of urgency: by date, by spots or stock, by a bonus that is ending, by a price that is changing, by the cost of waiting. If a type is not backed by a real detail from me, write "Not applicable: missing [detail]" instead of drafting it.
B) For each version: headline, main text, and call to action, within [LIMIT].
C) A verification table per version with three columns: which of my details backs the urgency; what proof I must keep (screenshot, invoice, stock count); what must be done when the deadline ends (remove or change the ad).
D) A simple A/B test: which two versions to compare, what to change in just one of them, and how many days to let it run with [DAILY BUDGET]. Do not promise me improvement percentages.
E) A two-line final notice with what I must review before publishing.
```
