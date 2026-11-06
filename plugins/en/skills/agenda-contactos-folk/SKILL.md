---
name: agenda-contactos-folk
description: Keeps your folk CRM up to date: finds duplicates and gaps, proposes fixes, logs meeting notes, and creates follow-up reminders, always showing the changes before saving them. Use it when your contact list is messy or right after a meeting or call.
---
# Keep Your folk Contacts Up to Date
folk is a CRM where several people can work on the same contact list. That is why this skill works carefully: it reads first, then proposes, and only writes what someone has approved.

## Installation (for the person, not for Claude)
- Save this text as SKILL.md inside .claude/skills/agenda-contactos-folk/ in your project, or in ~/.claude/skills/agenda-contactos-folk/ for all your projects.
- You need to connect Claude Code to folk through an MCP connector or its API. Check in your account whether your plan includes that access: [CHECK IN YOUR FOLK ACCOUNT]. Connector: [CONNECTOR COMMAND OR URL].
- Create the key with minimum permissions and do not paste it into the chat. A connector can read and change whatever your account allows, so install only connectors from sources you trust.
- While testing, use Claude Code's plan mode (toggle it with Shift+Tab): it only proposes and executes nothing.

## Ask this before starting
1. What do you want? Cleanup (duplicates, empty fields), log a meeting or call, create reminders, or review a specific group.
2. Which group or list should I work on? Never start with "all contacts."
3. Who else uses this folk workspace? Are there contacts that belong to another team member? Those are not touched.
4. What format do you want? Phone numbers with the +34 prefix, names with an initial capital, company names always written the same way.
5. Can I write to folk or only read? By default, only read and propose.

## Step by step
1. Take inventory of the connection: what it can read and what it can write. Assume nothing.
2. Read a sample of [20 TO 30] contacts from the chosen group to understand how it is organized before proposing changes.
3. Look for problems: possible duplicates (same email or phone, or a very similar name at the same company), empty fields, mixed formats, emails with typical errors (gmial.com), companies written in several ways, and contacts with no activity in [NUMBER] months.
4. Present a table of proposed changes with the columns Contact, Field, Current value, Proposed value, Reason, and Confidence (high, medium, low). Anything doubtful goes into a "review by hand" list.
5. Wait for the OK. Apply only what was approved, in batches of at most [25] changes. After each batch, re-read the contacts and check that they ended up as agreed.
6. If the user gives you notes from a meeting or call, summarize them in a short note: what was discussed, what was agreed, next step, and date. Propose a reminder with a specific date. Show everything before saving it.
7. Keep a local log in a file named registro-folk-DATE.md: contact, field, value before, and value after. It serves to undo changes by hand.

## What to return
- Summary: contacts reviewed, changes proposed, applied, and pending.
- The table of changes with the status of each one (applied, pending, rejected).
- List of duplicates with your proposal for which one to keep. Without merging.
- Reminders and notes created.
- The log file.

## What NOT to do
- Do not delete contacts, companies, or groups. If something is surplus, propose it and let a person do it.
- Do not merge duplicates: there may be no way back. Just flag them.
- Do not overwrite existing data without first showing the old value.
- Do not change a contact's owner or move contacts between groups without express permission.
- Do not send emails or messages, and do not add contacts to sequences or campaigns.
- Do not import purchased lists or data scraped from social networks or websites unless the person confirms where they come from and on what legal basis they are used.
- Do not record sensitive data (health, political opinions, religion, sexual orientation, trade union membership, origin) or personal opinions about the contact. Rule of thumb: write only what you would not mind the contact reading, because they have the right to request to see their data.
- Do not make things up. If there is no data, leave it empty or write [MISSING DATA].

## What a person reviews before using the result
- Someone on the team looks at the table of changes before approving a batch, especially the duplicates.
- Whoever is responsible for the data (you or your client) confirms that they have a legal basis to store it and decides how long it is kept (GDPR and Spain's LOPDGDD). If you work for a client, they are the controller and you are the processor: a written contract is required.
- Whoever runs sales reviews the notes and reminders before relying on them. Claude can summarize a meeting badly.
