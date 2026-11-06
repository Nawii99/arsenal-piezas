---
name: extraer-datos-cv
description: Extracts the key data from a person's resume or document and leaves it in a table, with privacy limits and mandatory human review.
---

## What it does

Reads one or more resumes (PDF, Word, scanned image) and pulls the same fields from each one, so you can compare them in a table instead of reading them one by one.

It does not score candidates. It does not reject anyone. It only organizes what is on the page.

## What to ask before starting

1. In which folder the files are and how many there are.
2. Which fields you want: name, contact, years of experience, positions, tools, languages, city, availability.
3. What it is for: comparing candidates, building a database, or preparing interviews.
4. Whether the files can be processed on the computer or have to be sent to an outside service.

If the user doesn't answer number 4, assume they can NOT be sent outside and use only what runs on their own computer.

## Step by step

1. List the files in the folder and say how many there are and in what format.
2. If any is an image or a scanned PDF, warn: it needs OCR. Propose doing it locally with Tesseract (free, already included in many systems) or with a reader on the computer itself. Don't upload the file to any website without explicit permission.
3. Extract the agreed fields from each file. Leave empty whatever doesn't appear. Never fill it in by deduction.
4. Mark as "doubtful" any data you read poorly or that is blurry.
5. Return a CSV table with one row per person and one column per field, plus an "archivo_origen" (source file) column.
6. Write a summary below: how many files, how many empty fields, which ones gave problems.

## What to return

- The CSV, ready to open in Excel or Google Sheets.
- The list of files that could not be read properly and why.
- A sentence reminding that the table is supporting material, not a decision.

## What NOT to do

- Don't upload resumes, national ID documents (DNI), payslips, or client documents to any outside service without the explicit permission of the person responsible for that data. They are personal data and in Spain whoever processes them is accountable.
- Don't invent data that is not in the document, not even "probable" data.
- Don't give a score, a ranking, or a "recommended / not recommended". Rejecting or calling someone is decided by a person, reading the original resume.
- Don't keep copies of the files outside the user's folder.
- Don't use data such as age, photo, nationality, or marital status to sort the table.

## Real cost and risk

Local extraction is free but slower and fails more often with crooked scanned PDFs. If you use a pay-per-use API model, count between 1 and 3 cents per resume; at 500 resumes that is about 10-15 euros. The big risk is not the cost, it is processing people's data without a legal basis: if the data isn't yours, ask for written permission first.
