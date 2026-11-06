# Make (make.com): Overdue Invoice Reminder from a Sheet

**Type:** Automation recipe · **Area:** Finance · **License:** CC BY 4.0 · [Spanish original](../../../recetas/make/finanzas/make-recordatorio-facturas-vencidas-sheets.md)

Make.com scenario that checks an invoice sheet every Monday and drafts Gmail reminders for overdue invoices. It flags those 30+ days late for your own decision and never sends or collects payments.

## What it is and what it does

A Make (make.com) scenario that every Monday reads your invoice sheet in Google Sheets and prepares in Gmail a reminder draft for invoices overdue by 7 to 29 days. Invoices 30 days or more overdue get nothing: you receive an alert so you can decide yourself. Inputs are invoices with status and date; the outputs are drafts, marks in the sheet, and a summary. It neither sends nor charges.

> **Note:** this touches a sensitive topic (health, legal, finance or security). Use it as a helper and have a professional review the result before you deliver it.

## The recipe, step by step

WHAT IT DOES
Every Monday, the scenario reads your invoice sheet. For each pending, overdue invoice it does one of two things, depending on the days overdue.
Between 7 and 29 days overdue: it prepares a friendly draft in Gmail (only once per invoice) and records in the sheet that the draft is prepared.
At 30 days or more: it does not write to the customer. It sends you an email so you decide what to do. As long as the invoice remains pending, that alert will reach you every Monday.
WHAT YOU NEED
A Make account (make.com). Check on its website how many operations or credits your plan includes.
A Google account with Google Sheets and Gmail.
A sheet called «Invoices» with these columns in row 1, in this order: Number, Client, Email, Amount, Due date, Status, Draft prepared, Days overdue.
Due date must be a real date. Status only accepts «Pending» or «Paid».
In Days overdue put a formula, for example =IF(F2="Pending",MAX(0,TODAY()-E2),0), and drag it down. That way the sheet does the date calculations and not Make.
If your spreadsheet is set to Spanish, the functions are called SI and HOY and the arguments are separated by semicolons. Format that column as Number, or Sheets may display it as a date.
THE MODULES, IN ORDER
Scenario schedule: click the clock on the first module, under Run scenario choose «Days of the week», check Monday and set 09:00.
Module 1 · Google Sheets › Search Rows (or Search Rows (Advanced), if Make offers that one).
- Connection: your Google account. Spreadsheet ID: «Select from My Drive» and the sheet. Sheet name: Invoices. Table contains headers: Yes.
- Filter: column Status, operator Equal to, value Pending.
- Maximum number of returned rows: a number larger than the pending invoices you expect.
- If the date comes out as a strange number, in the module's advanced settings choose to return the value as it appears in the sheet (Formatted value / Formatted string).
Filter between module 1 and 2. Name: «Overdue (7 days or more)». Condition: Days overdue, numeric operator «Greater than or equal to», 7.
Module 2 · Router (Flow Control › Router). Two routes.
Route A, between 7 and 29 days, only once. Filter, all conditions at once: Days overdue «Less than» 30; Draft prepared «Does not exist»; Email «Exists». Modules: Gmail › Create a Draft and then Google Sheets › Update a Row.
- If «Does not exist» doesn't behave well with empty cells in your test, use «Equal to» with an empty value.
- Gmail › Create a Draft. To: click Add item and drag the invoice's Email. Subject: «Reminder for invoice » and the number.
- Content: «Hi [Client]. I'm writing to remind you that invoice [Number], for [Amount] euros, was due on [Due date]. If you have already paid it, please ignore this message and apologies for the inconvenience. If you need me to resend it, let me know. Best regards, [YOUR NAME]». Drag each field from module 1. If the Amount cell already includes the € symbol, remove the word «euros».
- Google Sheets › Update a Row. Spreadsheet and Sheet name: the same ones. Row number: the «Row number» from module 1. Draft prepared: today's date, {{formatDate(now; "YYYY-MM-DD"; "Europe/Madrid")}}
- Leave the rest of the fields empty, especially Days overdue, which contains a formula. After the test, check that nothing in that row has been erased.
Route B, 30 days or more. Filter: Days overdue «Greater than or equal to» 30. Module: Gmail › Send an Email.
- To: your email. Subject: «Invoice more than 30 days overdue». Content: number, client, amount, and days overdue. End with «You decide how to proceed».
HOW TO TEST IT
Add to the sheet ONE test invoice with your own email, Status Pending, and a due date 10 days ago.
Click Run once. A draft should appear in Gmail and the date in the Draft prepared column of that row.
Check that the amount and date in the draft match the sheet.
To test route B, change that row's due date to 40 days ago and clear Draft prepared. You should receive an alert yourself, not a draft.
Clear the contents of Draft prepared in that row if you want to repeat the test, and when you finish mark the test invoice as Paid.
If everything goes well, activate Scheduling and click Save.
HOW MUCH IT COSTS
Each run uses one operation to search rows and about 2 or 3 more for each invoice that passes the filter. Check it in the history after the test.
With one run a week, the cost depends on the number of pending invoices. Check on its website how many operations or credits your plan includes.
WHAT NOT TO DO
Don't turn the draft into an automatic send. A person reads it and sends it.
Don't add late-payment interest, threats, or formal claims to the text. That is for an accountant or lawyer.
Don't put the IBAN or unnecessary data in the email.
Don't pass extra personal data through the sheet. Name, email, number, and amount are enough.
WHAT TO CHECK BY HAND BEFORE ACTIVATING IT
The figures. A person must check amounts, dates, and client of each draft before sending it, because it is money and it is a relationship with a customer.
That the invoice has not already been paid at the bank before sending the reminder.
That the sheet is updated when a payment comes in. If not, the scenario will remind about invoices already paid.
That the text respects the arrangement you have with each customer.
That serious non-payment cases are handled by your accountant or advisor, not by the scenario.
That the sheet is only seen by whoever needs it: it contains customers' names and emails. Also check on its website how long Make keeps the execution history.
