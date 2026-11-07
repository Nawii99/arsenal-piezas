---
name: barreras-agente-pacientes-en
description: Reviews a project that touches patient data and proposes guardrails and an activity log for Claude Code, without touching anything. Use it before letting the agent work on code for a clinic or any system with health data.
---
# Agent guardrails and logging in projects with patient data

Arguments received: $ARGUMENTS
(This is the path of the folder to review. If empty, use the current folder.)

## Where to save it
Save this file as `.claude/commands/barreras-agente-pacientes.md` in the project and type `/barreras-agente-pacientes-en`.

## What it does
Looks at how Claude Code is configured in the project and tells you, in plain language, what the agent can do today with patient data and what it lacks to be under control. Then it writes a proposal of guardrails and an activity log for a person to apply.
What it is NOT: it is not a legal audit and does not certify that you comply with the GDPR (RGPD) or, if it applies to you, Spain's National Security Framework (Esquema Nacional de Seguridad). It reduces risks, it does not remove them.
The strongest guardrail is not any setting: it is that the agent works with fake test data and never with real data.

## Before starting, ask
1. Is there real patient data in this folder, in a database the code reaches, or nowhere? If the answer is "I don't know", treat it as "yes".
2. Where are the sensitive folders or files?
3. Who is the data protection officer, or who decides for the clinic? If there is nobody, say so in the report.
4. Is Claude Code used with a company account or a personal one? Is there a data processing agreement with the provider? If nobody knows, note [PENDING CONFIRMATION WITH THE PROVIDER].
5. Are there MCP connections or internet access enabled for the agent?

## Step by step
1. Read-only. Read `.claude/settings.json`, `.claude/settings.local.json`, `.mcp.json`, `.gitignore`, and `CLAUDE.md` if they exist. Say which ones don't exist.
2. Search by name, without opening them, for files and folders that look like clinical data: patient, history, nhc (medical record number), dni (national ID), lab results, report, dump, backup, .sql, .csv, .xlsx. Note the path and size. Don't open any.
3. Check these points and mark each one green, amber, or red.
   - Real data inside the project or reachable from it.
   - Read and edit blocks on sensitive folders, `.env` files, and keys.
   - Blocking of commands that can send data out, such as curl, wget, scp, or sending email.
   - MCP connections and what they can read.
   - Agent activity log: when, which tool, and which file or command.
   - That `.gitignore` covers data and keys.
   - That fake test data exists to work with.
4. Write the proposal, without applying it. For the blocks use Claude Code's permission rules (deny). For the log use a hook that records date, tool, and path or command, never the contents of the files.
5. Before writing the syntax, verify it against the current Claude Code documentation. If you can't verify it, write "unverified syntax".
6. Save the report in `auditoria-agente/informe-YYYY-MM-DD.md`.

## What to return
A file with these parts, in this order:
1. Summary of 5 lines at most, without technical jargon.
2. Traffic-light table with three columns: point, status, and why.
3. What to do now: 5 things at most, from most to least urgent.
4. Technical appendix for whoever applies it: proposed permission rules and hook. Warn that the log may contain paths and commands, so it is sensitive data: limited access, backup, and a retention period set by the data controller.
5. What you could not verify.
6. Who has to review and sign it: the data controller or the data protection officer.
In the chat, only the summary and the file path.

## What NOT to do
- Don't open files with patient data, not even to see "what's inside". The name and size are enough.
- Don't copy patient data into the report, the chat, or any log.
- Don't modify `settings.json`, hooks, or permissions. An agent must not touch its own guardrails: a person applies them.
- Don't say the project "complies" or "is secure". Say what you checked and what you didn't.
- Don't run network commands or install anything.
- Don't propose giving the agent access to the real database. The safe approach is for it to work with fake data.

## When to stop and alert a person
- If real data is accessible and there is no data processing agreement with the agent's provider: stop and alert the data controller. Don't continue working on that project.
- If you see that real data has already been opened in an agent session, it may be a security breach. The data controller decides. If it has to be notified to the AEPD (Spain's data protection authority), the deadline is 72 hours from when it becomes known.
- Health data is a special category under the GDPR. Before processing it at scale, an impact assessment is usually required. This command does not do it.
- If the software helps decide diagnoses or treatments, it may be considered a medical device. A regulatory specialist assesses that.
