# From CV Folder to Spreadsheet, Automatically

**Type:** Automation recipe · **Area:** Data & AI · **License:** CC BY 4.0 · [Spanish original](../../../recetas/n8n/datos-ia/cv-drive-a-sheets.md)

n8n recipe that takes each CV saved to a Drive folder, extracts its data with AI and appends a row to Google Sheets.

## What it is and what it does

An n8n recipe that, every time a CV is uploaded to a Google Drive folder, downloads it, extracts its text, asks an AI for the data with a fixed schema, and adds a row to a Google Sheets sheet with all the candidates. Input is the file; the output is one row per CV in the sheet. Example: a CV sent by email and saved in Drive shows up as a row. Using the AI API has a per-use cost. This is personal data: have a professional review it.

## The recipe, step by step

# From CV folder to spreadsheet

## What it does
Every time a new CV is uploaded to a Google Drive folder, the automation converts it to text, asks an AI to extract the data with a fixed schema, and adds a row to a Google Sheets sheet with all the candidates.

## Accounts needed
- Google account (Drive, Docs, and Sheets): free, with the normal limits of a personal or Workspace account.
- n8n: free if you install it yourself (self-hosted); paid if you use n8n Cloud, once its temporary free trial has ended.
- An AI model with an API (for example OpenAI): not free, charges per use; processing a CV costs cents, but it adds up if there are many.

## Node by node
1. Trigger: "Google Drive Trigger" node, "On file created" event, pointing to the "Incoming CVs" folder.
2. "Google Drive - Download" node: downloads the file that triggered the flow.
3. "Google Drive - Copy" node: copies the file converting it to Google Docs; this conversion works as free OCR if the CV is an image or a scanned PDF.
4. "Google Docs - Get" node: gets the already converted text of the document.
5. AI node (for example "OpenAI" or "HTTP Request" to the API you use): you pass it the text using the CV extraction schema as instructions, so that it always returns the same JSON.
6. "Set" or "Code" node: splits the returned JSON into individual fields (name, email, current company, years of experience, etc.).
7. "Google Sheets - Append row" node: adds a new row in the "Candidates" sheet with those fields.
8. "IF" node before step 7: if the JSON comes back incomplete or the AI node fails, send the row to a separate "Review manually" sheet instead of the main sheet.

## How to test it without messing up
Before connecting it to the real folder, create a test Drive folder and a copy of the spreadsheet. Upload two or three sample CVs (one PDF, one scanned, one with an unusual format) and check row by row that the data is correct before pointing the flow at the real folder. Don't process real candidate CVs until you have verified that no sensitive data (health, religion) is stored in the sheet.
