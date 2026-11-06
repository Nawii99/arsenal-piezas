---
name: extraccion-datos-cv-en
description: Extracts structured data (name, contact, experience, education, languages) from résumés in PDF, image, or Word using OCR and open-source parsers, designed to be sold as a service to recruitment agencies and freelance HR professionals.
---

# Résumé data extraction for a paid service

## What it does
It takes one or more résumés (PDF, JPG, PNG, or Word) and pulls out a structured table: name, email, phone, city, years of experience, positions, companies, education, languages, and skills.
It serves as the basis of a service that you charge to recruitment agencies or freelancers who receive many résumés and do not have time to read them one by one.

## What to ask before starting
- Are the résumés PDFs with selectable text, scanned, or phone photos? It changes the OCR tool you need.
- How many résumés per batch? If it is more than 50 at a time, warn that the process takes a while and may fail on some.
- Has the client asked the candidates for consent to process their data? It is a legal requirement (GDPR), not optional.
- Which specific fields does the client want? Not everyone needs the same, some only want phone and position.

## Step by step
1. If the résumé is a PDF with selectable text, extract the text directly with a library such as pdfplumber or pdf-parse. OCR is not needed.
2. If it is an image or a scanned PDF, run it through OCR. Tesseract OCR is free and local; ocr.space or Google Cloud Vision have an API with a limited free tier.
3. With the text now flat, apply a résumé parser. There are open-source projects such as pyresparser, or a prompt to an LLM with the JSON schema from the 'extraccion-cv-json' piece in this same pack.
4. Normalize dates, phones, and emails to a single format, for example DD/MM/YYYY and the +34 prefix for Spain.
5. Dump the result into a table (CSV or Google Sheet) with one row per candidate.
6. Manually review a sample, at least 1 in every 10 résumés, before delivering. OCR and the parser fail more than it seems, especially with résumés that have columns or creative layouts.

## What to return
A table or Google Sheet with one row per résumé and fixed columns, plus a notice of how many résumés could not be processed properly and why (scan quality, odd format, unsupported language).

## How to charge for it
Per-batch model: a fixed price for every 50 or 100 résumés processed, not per hour. Charge the agency, not the candidate.
Another option: a monthly subscription if the client receives résumés continuously, for example [PRICE] euros per month for up to [NUMBER] résumés; adjust the price to your real case, there is no standard figure.
Always tell the client what error rate to expect. Do not promise 100% accuracy; it runs between 85% and 95% depending on the quality of the incoming résumés.

## What NOT to do
- Do not process résumés unless the client confirms they have a legal basis to process them (GDPR). If they do not, do not continue.
- Do not keep the résumés or the extracted data longer than agreed with the client; they are sensitive personal data.
- Do not promise 100% accuracy. OCR fails with small print, columns, and résumés with graphic design.
- Do not deliver without human review of a sample. A misread phone number can cost the client a candidate.
- Do not use this process to automatically discard candidates without human review; it can amount to algorithmic discrimination.
