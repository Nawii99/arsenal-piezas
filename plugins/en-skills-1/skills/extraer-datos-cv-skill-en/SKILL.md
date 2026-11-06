---
name: extraer-datos-cv-skill-en
description: Extracts structured data from a CV (PDF, Word, or scanned image) and leaves it ready in a table or JSON. Activates when someone asks "extract the data from this CV", "turn this CV into a table", or "pull the contact details and experience from this resume".
---

## What it does
Takes a CV (PDF, Word, or photo/scan) and extracts the key data: name, phone, email, city, years of experience, previous positions, education, and languages. It leaves them in a table or in a simple JSON that can be pasted into Excel or Google Sheets.

## Before starting, ask
- Is the CV a PDF with selectable text, a photo/scan, or a Word file?
- What fields exactly do you need? If not specified, use the basic list: name, contact, experience, education, languages.
- Is the result to be read by a person (table) or by another program (JSON)?
- Is there more than one CV at a time? If there are several, say so before processing them one by one so they don't get mixed up.

## Step by step
1. If the CV is a PDF with selectable text or a Word file, extract the text directly, without OCR.
2. If the CV is a photo or a scanned PDF (image), run the text through OCR. For Spanish, use Tesseract OCR (free, open source) with the "spa" language pack installed, or Google Drive's built-in OCR if you can't install anything.
3. Review the text the OCR produced by hand: proper names and phone numbers are what fail most.
4. Locate each block of the CV: contact details, work experience, education, languages, and others (certificates, driver's license, etc.).
5. Turn each block into table rows: one row per work experience, with company, position, start date, and end date.
6. If a piece of data does not appear in the CV, leave the field empty or write "not stated". Do not invent it.

## What to return
A Markdown table with columns Field | Value, or one row per experience if there are several. If JSON is requested, a flat object with those same keys, without unnecessary nesting.

## What NOT to do
- Don't invent data that is not in the CV: not the age, not the expected salary, not the national ID number (DNI) if it is not written there.
- Don't treat the national ID number (DNI), the full date of birth, or the photo as just another data point: they are sensitive personal data (GDPR). Keep only what is needed for the selection process and delete it when it is no longer needed.
- Don't upload the CV to a free online OCR without first checking its data policy: many store the document on their servers.
- Don't mix CVs from several people in the same table without a column saying who each row belongs to.
