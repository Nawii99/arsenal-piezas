---
name: auditor-rag-documentos
description: Audits a question-and-answer system over documents (RAG): chunking, search, answers, and hallucinations. It is activated when you need to check whether a chat over documents answers correctly before showing it to a client.
---

## What it does

Takes a system that answers questions about a client's documents and tests it with a bank of questions. Returns a report with numbers, concrete examples of failure, and what to change to improve it. It changes nothing on its own.

## Before starting, ask

1. Which documents feed the system and whose they are.
2. Who is going to use the chat: internal staff or end customers.
3. Whether there is personal data or contracts inside. If there are, they are not copied outside the client's team without written permission.
4. How it is set up now: what chunks, what vector database, what model answers.
5. What happens if the system is wrong: is it a nuisance or is there money, health, or contracts at stake.

## Step by step

1. Inventory: count documents, formats, pages, and how many are scanned without text. Scanned documents without OCR are the leading cause of empty answers.
2. Review the chunking. Look at 10 random chunks. Flag problems if a chunk cuts a sentence in half, if it mixes two sections, or if it doesn't carry along the section title.
3. Check that each chunk stores where it comes from: file, page, and section. Without that it can't be cited and can't be audited.
4. Build a bank of 30 questions with the client: 20 that do have an answer in the documents, 5 that are answered by combining two documents, and 5 whose answer is NOT there (the traps).
5. Run the 30 questions. For each one record: answer given, document cited, whether the citation is real, and whether the answer is correct.
6. Produce three numbers: hits out of the 20 direct ones, hits out of the 5 combined ones, and how many of the 5 traps it answered instead of saying "I don't know". The last one is the most important: if it makes things up, it is not shown to a client.
7. Classify each failure as: did not find the chunk, found the chunk and answered wrong, or made it all up. Each cause is fixed differently.
8. Propose at most five changes, ordered by effort and effect. For example: run OCR on the scanned ones, chunk by sections, keep titles, force citations, or answer "not stated in the documents" when there is no relevant chunk.

## What to return

- Table with the 30 questions and their result.
- The three percentages and the three types of failure counted.
- Five proposed changes with estimated effort.
- Fixed sentence: "No number in this report authorizes using the system without supervision for decisions about people, contracts, or money."

## What NOT to do

- Do not touch the client's configuration during the audit.
- Do not send documents or fragments to outside services without written permission.
- Do not accept an answer as good without opening the cited document.
- Do not present a percentage without saying how many questions it is based on.
