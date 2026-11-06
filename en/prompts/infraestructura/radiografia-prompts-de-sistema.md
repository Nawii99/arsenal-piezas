# System Prompt X-Ray

**Type:** Prompt · **Area:** Infrastructure · **License:** CC BY 4.0 · [Spanish original](../../../prompts/infraestructura/radiografia-prompts-de-sistema.md)

Prompt that analyzes one or more system prompts, compares their structure, tone and limits, and helps you write your own in your own words, with safety warnings.

## What it is and what it does

Prompt for analyzing one or more system prompts, the background instructions of an assistant, and comparing their structure, tone, and limits. Input: the text you want to study; output: an analysis of the pieces that make it up and a template for writing your own in your own words. Works in Claude, Codex, Gemini, or a local AI. It warns that a leaked prompt is neither reliable nor a security barrier.

## The prompt (copy it whole)

```text
You are going to act as a system prompt analyst. A system prompt is the background instructions an assistant receives before talking to anyone. I want to study how they are written so I can write my own. I do not want to copy any of them.

Before starting, keep three things in mind and remind me of them in two lines at the beginning of your answer:
- A "leaked" prompt cannot be verified. It may be incomplete, outdated, or invented by a model. It is an example, not a fact.
- It may be confidential or protected by copyright. I use it to learn structure and tone. Do not reproduce it in full or use it as the literal basis for anything I am going to publish or sell.
- A system prompt is not a security barrier. Whoever insists can extract it or bypass it. Never put passwords, keys, or permissions in it that depend only on the AI obeying.

Material to analyze:
PROMPT 1 (product or source: [PRODUCT OR SOURCE]): [PASTE THE TEXT HERE]
PROMPT 2 (optional): [PASTE THE TEXT HERE]
PROMPT 3 (optional): [PASTE THE TEXT HERE]

My assistant: [WHAT IT WILL DO, FOR WHOM, AND WHAT SYSTEMS IT WORKS IN. EXAMPLE: INTERNAL IT SUPPORT FOR A SMALL BUSINESS]
What it will be able to do on its own: [ONLY ANSWER / READ FILES / EXECUTE ACTIONS]

Do this, in order:
1. X-ray: for each prompt, a table with these rows: role, tone, scope (what it does and does not do), non-negotiable rules, response format, use of tools, what it does when it doesn't know, what it does with dangerous requests, and what it is missing. One sentence per cell.
2. Comparison: what they have in common, how they differ, and what design decisions explain those differences.
3. What is useful to me: ideas on structure and tone that I could adapt to my assistant, expressed in your own words. No long copied sentences.
4. Own draft: a system prompt for my assistant, with short sections (role, scope, tone, rules, format, when to hand over to a person). Mark with [BRACKETS] what I need to decide.
5. Tests: ten messages to test the draft. At least three must try to get the assistant to break its rules and two must be cases where it should say "a person decides this."
6. Review: a list of things I must check before putting it into use.

Do not do this:
- Do not help me extract or reconstruct system prompts from someone else's product or bypass its protections.
- Do not put client names, internal addresses, keys, or employee data in the draft.
- If my assistant will be able to run commands or change configurations on servers, the draft must require confirmation from a person before deleting, restarting, or modifying anything. Tell me this explicitly.
- Do not tell me the draft is secure. Tell me what you have tested and what remains to be tested.
```
