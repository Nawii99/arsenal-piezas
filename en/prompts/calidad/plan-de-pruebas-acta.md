# Test Plan and Acceptance Report

**Type:** Prompt · **Area:** Quality & testing · **License:** CC BY 4.0 · [Spanish original](../../../prompts/calidad/plan-de-pruebas-acta.md)

Prompt that produces a plain-language test plan table and a one-page acceptance report for a client to sign before the final payment on any software or automation delivery.

## What it is and what it does

Prompt to paste into Claude that generates a test plan of 10 to 20 cases in a table (action, expected result, who runs it) and a one-page acceptance report. Fill in the brackets with the type of deliverable, the client, and what happens if it fails. It is used to close any project with a record of what was tested and what is pending.

## The prompt (copy it whole)

```text
Act as the quality manager of a small agency in Spain. I am going to deliver [WHAT YOU DELIVER: N8N AUTOMATION / ONLINE STORE / CONFIGURED CRM / WEBSITE WITH A FORM] to a client and I want to close the project with a test plan that the client understands and signs.

About the project:
- Client: [TYPE AND SIZE OF BUSINESS]
- What my deliverable does, in one sentence: [EXAMPLE: WHEN AN ORDER COMES IN ON THE STORE, THE INVOICE IS CREATED AND A WHATSAPP NOTICE IS SENT]
- Connected tools: [LIST]
- What happens if it fails: [EXAMPLE: AN ORDER IS LOST / CUSTOMER IS CHARGED TWICE / THE NOTICE DOESN'T ARRIVE]
- Test environment available: [YES, WITH FAKE DATA / NO]

Write:
1. A test plan of between 10 and 20 cases, in a table: number, what we do, what should happen, result (blank), who runs it. Written for someone who doesn't code. Always include: the normal case, an empty field, a name with an accent or ñ, an amount with decimals, the same submission repeated twice in a row, and a cancellation.
2. The cases ordered from most serious to least serious according to what I told you happens if it fails.
3. A one-page acceptance report: what was tested, what remains pending and with what date, what counts as a covered incident and what is new work, and a signature line for both parties. Plain language, no contract jargon.
4. A short message to send the report to the client proposing a 30-minute session to run the tests together.

Conditions:
- If I don't have a test environment, tell me at the start and explain in three lines what risk I take on by testing in production.
- Do not invent functions I have not described to you. If you are missing something to write a case, ask.
- Do not use the words "guarantee" or "zero errors." The report says what was tested, not what will never fail.
- Prices, deadlines, and included support days, in square brackets for me to fill in.
```
