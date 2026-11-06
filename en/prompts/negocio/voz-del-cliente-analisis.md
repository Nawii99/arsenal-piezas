# Voice of the Customer: What They Really Want, Based on What They Have Already Told You

**Type:** Prompt · **Area:** Business · **License:** CC BY 4.0 · [Spanish original](../../../prompts/negocio/voz-del-cliente-analisis.md)

Prompt for Claude, Codex, Gemini or a local AI that extracts needs, desires, objections and literal quotes from anonymised customer texts.

## What it is and what it does

Prompt for Claude, Codex, Gemini, or a local AI that analyzes real customer texts (reviews, emails, messages, or surveys, already anonymized) and extracts needs, desires, objections, and verbatim phrases, always with a supporting quote. Input: the business, the decision you want to make, and the texts without personal data; output: a report organized by topic with quotes. Paste it into any text AI; it can be fed from a Google Sheets spreadsheet with n8n or Make.

## The prompt (copy it whole)

```text
Act as a customer research analyst. I am going to paste real texts from my customers. I want to know what they truly need and want according to what they have said, not according to what I assume.
MY BUSINESS: [WHAT I SELL AND TO WHOM]
WHAT I WANT TO DECIDE WITH THIS: [DECISION: for example, what new service to offer, what to improve, or what text to put on the website]
TYPE OF MATERIAL: [REVIEWS / EMAILS / WHATSAPP MESSAGES / CALL TRANSCRIPTS / SURVEY RESPONSES]
APPROXIMATE NUMBER OF TEXTS: [NUMBER]
TEXTS:
[PASTE THE TEXTS HERE, WITHOUT NAMES, PHONE NUMBERS, EMAILS, OR ADDRESSES]
BEFORE PASTING (you do this, not Claude): remove personal data. Do not paste health data, data about minors, or messages from people who do not know they will be analyzed. Check in the tool's settings whether it stores your conversations. If you have doubts about the GDPR (RGPD), ask [YOUR GESTOR OR ADVISOR].
RULES:
1. Work only with the texts I give you. Do not use general statistics or assume things about "customers in general."
2. Every claim carries at least one verbatim quote in quotation marks. If there is no quote, it is a hypothesis and you mark it as HYPOTHESIS.
3. Count how many texts mention each topic (for example, "4 of 23"). If you are not sure of the count, say so.
4. If there are fewer than [MINIMUM NUMBER OF TEXTS: for example, 10], warn me that the conclusions are very fragile.
5. Distinguish what the customer says they want from what they are trying to achieve. Mark that second part as INTERPRETATION.
6. Do not agree with me by default. If the texts contradict my idea, tell me clearly.
7. If something essential is missing, ask me at most three questions before starting.
WHAT YOU RETURN:
1) Five-line summary.
2) Table with these columns: topic | how many texts mention it | verbatim quote | what the customer is trying to achieve | type (need, desire, fear, or objection).
3) The ten words or phrases customers repeat most, exactly as they write them, to use on my website and in my ads.
4) The three objections that most hold back the purchase, each with its quote.
5) What can NOT be concluded from this material: who it does not represent and what is missing.
6) Five questions for an interview of about 20 minutes with a real customer, to check the hypotheses.
7) Recommendation for my decision [DECISION], with a confidence level (high, medium, or low) and the reason.
```
