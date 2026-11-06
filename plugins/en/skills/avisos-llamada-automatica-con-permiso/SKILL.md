---
name: avisos-llamada-automatica-con-permiso
description: Prepares automated voice-call notices (script, phone list, and schedule) and leaves them ready in DialMyCalls if connected. Use it for service notices to customers you already have, such as appointment or schedule changes, not for cold selling.
---

# Automated call notices, with permission

## What it does
It prepares a short voice-call notice (the typical call with a recorded message) for many people at once. It writes the script, cleans the phone list, and proposes the schedule. If DialMyCalls is connected, it leaves the campaign prepared without launching it.
An automated call is more annoying than an email. Use it only when the notice matters and the person expects you to notify them.

## Before starting, ask
- What needs to be announced and by when? Schedule change, appointment reminder, closure, delivery.
- Is it a service notice to customers you already have or a commercial offer? If it is commercial, apply the section "First, permission."
- Where do the phone numbers come from and when did each person give permission? Can you prove it (date, form, source)?
- How many people are there? Has anyone unsubscribed or asked not to be called?
- Does their DialMyCalls plan allow calling numbers in Spain (+34)? How much does each call cost and is it charged if they do not answer? If they do not know, they should check the provider's rate: [RATE TO SPAIN].
- Is there a connector with DialMyCalls or will they load the campaign by hand?

## First, permission
- Service notice to a current customer (your appointment tomorrow has changed time): it is a communication about something they already contracted.
- Automated commercial call (offers, promotions): in Spain it needs prior consent from each person. Without provable permission, do not continue. Say so and stop.
- Anyone on the Lista Robinson (Spain's national do-not-advertise registry) does not want advertising, unless they have given you express permission.
- Debt collection: do not use automated calls for that. A person does it and, better, in writing.
- This is general guidance, not legal advice. A lawyer or a data protection officer confirms it.

## Step by step
1. Classify the notice (service or commercial) and check the permission. If it is commercial and there is no permission, stop.
2. Clean the list: international format (+34600000000), no duplicates, no incomplete numbers, and no unsubscribes. Return how many remain and how many you removed, with the reason.
3. Write the script of 15 to 25 seconds. Order: who is calling, reason, key fact (day, time, place), what to do, and how to stop receiving notices. Short sentences. For synthetic voice, write times and figures as they are spoken: "at half past five in the afternoon." Repeat the key fact once.
4. Always start with "This is an automated message from [BUSINESS NAME]." If you use synthetic voice, do not pass it off as a person.
5. Write a shorter version for voicemail or an answering machine, if the tool allows it.
6. Propose the schedule: a reasonable day and time slot (morning or afternoon, never at night, nor on Sundays or holidays), maximum number of retries [RETRIES], and end time.
7. Test first with 3 numbers from the team itself. Have the person listen to the audio. If there is a connector, prepare only the test campaign.
8. With the person's express OK and the test going well, the person launches the campaign. Claude does not launch it.
9. Afterward, summarize: answered, voicemail, no answer, errors, and unsubscribes. Unsubscribes are applied the same day on the original list.

## What to return
- Final script (text designed for voice) and voicemail version.
- Clean list as a table or CSV: phone, first name if there is one, permission (yes or no), and source.
- Schedule and estimated cost: number of calls times [RATE]. Show the calculation, not just the total.
- Results report after sending, in about 8 lines.
- To-do list for the person.

## What NOT to do
- Do not launch, schedule, or pay for a campaign without express OK.
- Do not make commercial calls to anyone who has not given permission. There are penalties for commercial calls without consent.
- Do not use purchased lists or phone numbers taken from a directory.
- Do not put personal data in the audio (full name, diagnosis, amount of a debt). Whoever picks up the phone can hear it.
- Do not call at night, on Sundays, or on holidays.
- Do not clone anyone's voice without their written permission.
- Do not use this to replace safety or life-threatening emergency alerts.
- Do not hide the number or use numbers that do not belong to the business.
- Do not upload the phone list to tools the business has not contracted, and do not paste API keys into the chat.

## When to ask a person
- Before the first commercial campaign: a lawyer or data protection advisor reviews permissions, text, and the way to unsubscribe.
- If the business is healthcare, financial, or insurance: it has its own rules.
- If you use synthetic voice: the EU AI Act has transparency rules for AI-generated content. Ask your advisor what applies to you and since when.
- If someone complains about a call: stop the campaign and review before continuing.

## Installation (for you, not for Claude)
Save this text as SKILL.md inside a folder with the name above, in .claude/skills/ of your project, or in ~/.claude/skills/ to use it in all your projects. Leave Claude Code in the mode that asks permission before using the connector.
