# Analyze a Suspicious Email Before Falling for It

**Type:** Prompt · **Area:** Cybersecurity · **License:** CC BY 4.0 · [Spanish original](../../../prompts/seguridad/analizar-correo-sospechoso.md)

Prompt that analyzes a suspicious email from pasted text alone, comparing the visible sender with the real address and flagging warning signs.

## What it is and what it does

A prompt that analyzes a suspicious email without opening links or attachments. It compares the visible sender with the real address, checks the links and the subject, and gives you a one-line verdict with the signs found and the steps to follow. Input: the sender, the full text, and what it asks for; output: an assessment of suspicion and what to do. Paste it into Claude, Codex, Gemini, or a local AI.

> **Note:** this touches a sensitive topic (health, legal, finance or security). Use it as a helper and have a professional review the result before you deliver it.

## The prompt (copy it whole)

```text
Act as the security officer of a small company. I am sending you an email that reached me and I want to know whether it is fake.

Do not open any link or encourage me to do so. Work only with the text I give you.

EMAIL RECEIVED
Sender as displayed: [NAME THAT APPEARS]
Sender's real address: [EMAIL@EXACT DOMAIN, COPIED AS IS]
Subject: [SUBJECT]
Full text: [PASTE THE ENTIRE EMAIL HERE]
Links that appear (copy the address without clicking): [LINKS]
Attachments: [NAME AND EXTENSION OF THE FILES, OR NONE]

MY CONTEXT
My business: [WHAT I DO]
Was I expecting this email?: [YES / NO]
Do I know the sender?: [YES, FROM WHERE / NO]
What it asks of me: [PAY, GIVE DATA, CLICK, OPEN A FILE, CHANGE AN ACCOUNT NUMBER]

RETURN THIS TO ME, IN THIS ORDER
1. One-line verdict: probably fake, doubtful, or probably legitimate.
2. Warning signs you found, quoting the exact piece of the email: urgency, threat, a similar but not identical domain, generic greeting, change of account number, tone errors, unexpected attachment.
3. Signs in favor of it being real, if there are any. Be honest: if there are none, say so.
4. What to do now, in numbered, concrete steps for someone who is not an IT person.
5. How to verify it another way: who to call and at what number, always one I already have saved, never the one in the email.
6. What to do if it turns out I have already clicked or already replied.

RULES
- If it asks me to change a supplier's account number, always treat it as suspicious even if it comes from the right email address, and tell me it must be confirmed by phone using an old number.
- Do not give me a certainty you do not have. A well-made email can look legitimate.
- If money has already been paid or bank details have been given, tell me on the first line to call the bank today and file a report, and that a responsible person in the company should handle this, not an automated analysis.
```
