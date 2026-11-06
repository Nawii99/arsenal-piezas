---
name: hojas-de-calculo-revisables-en
description: Creates or edits Excel (.xlsx) and CSV files with formulas that recalculate, clear formatting, and simple charts, always on a copy. Use it when you ask for a spreadsheet, a template, a sales or expense table, or to fix a messy Excel or CSV.
---

# Reviewable spreadsheets

Installation: save this text in a file named SKILL.md inside the .claude/skills/hojas-de-calculo-revisables/ folder of your project. Claude Code uses it when you ask for a spreadsheet; if you want to force it, name it in your request.

## What it does
- Creates .xlsx and .csv files from scratch or from the data you give it.
- Edits a file you already have, but always working on a copy.
- Puts in real formulas, not pasted numbers, so the sheet updates itself when you change a value.
- Gives readable formatting and adds simple charts only if they help make a decision.
- When finished, it tells you what it checked and what you need to look at yourself.

## Before starting, ask
1. What decision or calculation do you want to get from this sheet? If it isn't clear, the sheet will come out confusing.
2. Where does the data come from? A file, pasted text, an export from another tool.
3. Where will you open it? Excel, Google Sheets, LibreOffice, or your phone.
4. If it is a CSV, for what program? In Spain, Excel expects a semicolon as separator and a decimal comma; otherwise everything ends up in a single column.
5. Is there personal data (names, emails, phone numbers, tax IDs)? If there is, work only on your own computer and with the essential columns.
6. Is there VAT, withholding, or other taxes? Ask which rate applies in each case; don't assume it.

## Step by step
1. Look at the data before touching anything: columns, rows, empty cells, dates in mixed formats, numbers stored as text, duplicates. Tell the user in five lines at most.
2. Make a copy of the file with another name (for example, ventas_v2.xlsx). The original is not touched.
3. Split the work into tabs: Data (what gets typed), Calculations (the formulas), and Summary (what gets read). If the sheet is very simple, one is enough.
4. Put the assumptions in labeled cells (for example, "VAT rate") and make the formulas point to those cells. Never write a 21 inside a formula.
5. Write formulas. Inside the file they are stored with English names (SUM, IF, VLOOKUP) even if your Excel displays them in Spanish (SUMA, SI, BUSCARV). Claude handles it; you won't notice.
6. Use ROUND wherever there is money, to two decimals, so what you see matches what is summed.
7. Postal codes with a leading zero (08001), phone numbers, and tax IDs are stored as text, not as numbers, or the zero is lost.
8. Format: dates as dd/mm/yyyy, amounts with two decimals and the € symbol, frozen header, readable widths, and few colors.
9. Charts only if they answer a specific question. Clear title, labeled axes, no 3D effects.
10. If the deliverable is a CSV: semicolon separator, decimal comma, UTF-8 with BOM so accents and the ñ display properly, and no formulas (a CSV only stores values).
11. Recalculate and check. A file created by code does not contain calculated results until a spreadsheet program opens it. If LibreOffice is on the computer, ask it to open the file, recalculate, and look for errors (#REF!, #DIV/0!, #NAME?, #VALUE!). Cross-check two or three totals against a calculation done separately.
12. If it could not be recalculated, say so clearly. On an Android phone some previews show empty cells; open the file with the Excel app or with Google Sheets.

## What to return
- The path of the created or edited file.
- A short table with three columns: tab, what it is for, and which cells are filled in by hand.
- The assumptions used and in which cell they are.
- The checks done and their result (for example, "0 formula errors; the sales total matches the separately calculated sum").
- What could not be checked.
- What a person should review before using the sheet.

## What NOT to do
- Don't overwrite the original.
- Don't invent data to fill gaps. If a value is missing, leave the cell empty and mark it.
- Don't paste the result of a formula as a fixed number without warning.
- Don't use macros (VBA, .xlsm files) or links to other files unless expressly requested: they open up security risks and don't work on a phone.
- Don't copy into a cell a text that starts with =, +, - or @ if it comes from forms or third parties: Excel may execute it as a formula. Store it as text.
- Don't present a sheet password as data protection. Excel's protection is easy to bypass and is not suitable for sensitive data.
- Don't upload customer data to external websites or paste it into services you did not choose yourself.
- Don't treat tax calculations as reliable. Excel supports 1,048,576 rows per sheet; if there is more data, split the file or use a database.

## When to ask a person
- If the sheet will be used for taxes (Spanish forms 303, 130, or others), for invoicing, or for calculating payroll, have your accountant (gestor) review it before using it: VAT rate, withholdings, rounding, and periods.
- If it contains personal data, have the person responsible for data protection confirm which columns are unnecessary and who may open it.
- If you are going to make an important money decision based on the sheet, have another person redo a calculation by hand.
