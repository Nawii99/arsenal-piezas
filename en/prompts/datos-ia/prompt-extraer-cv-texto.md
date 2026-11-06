# Extract Data from a CV Pasted as Text

**Type:** Prompt · **Area:** Data & AI · **License:** CC BY 4.0 · [Spanish original](../../../prompts/datos-ia/prompt-extraer-cv-texto.md)

Prompt for any AI chat that turns pasted CV text into a candidate profile, with a confidence level for each extraction.

## What it is and what it does

Prompt for Claude, Codex, Gemini, or a local AI that, given the text of a CV, returns an organized candidate profile without inventing data: name, email, phone, city, last three positions, education, languages, and skills, with high, medium, or low confidence. Input: the text; output: a profile. Example: a text with an incomplete phone number is marked with low confidence. This is personal data: have a professional review it.

## The prompt (copy it whole)

```text
You are an assistant that organizes résumés for a recruitment agency. I am going to paste the text of a CV, exactly as it came out of OCR, so it may have recognition errors (swapped letters, odd line breaks).

Your task:
1. Correct only the obvious OCR errors (for example an 'l' that should be a '1', or words split by a line break). Do not invent or change data that is not clear.
2. Produce a candidate profile with these sections: Full name, Email, Phone, City, Years of experience (approximate number), Last 3 positions (with company and dates), Education (degree and institution), Languages (with level if stated), Key skills (maximum 8).
3. If a piece of data does not appear in the text, write 'Not stated' in that section. Do not leave it blank or fill it with a guess.
4. At the end, add a line 'Extraction confidence: high / medium / low' according to how legible the text I gave you was.
5. If you detect that the text is badly broken (sentences that make no sense, many stray words), say so before the profile instead of trying to fill it in anyway.

Respond only with the profile, with no additional explanations before or after.

CV text:
[PASTE THE CV TEXT HERE]
```
