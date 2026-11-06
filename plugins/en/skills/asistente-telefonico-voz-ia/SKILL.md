---
name: asistente-telefonico-voz-ia
description: Designs, and if asked prototypes, an AI voice assistant that answers calls or converses by voice, with transcription, response, synthetic voice, handoff to a person, and legal notices. It activates when the user talks about a virtual receptionist, phone bot, or voice assistant.
---

# AI voice assistant: design, prototype, and launch

This skill takes the user from "I want an AI to answer the phone" to a clear dossier and, if the user asks, to a test prototype. It runs in three phases. It does not move from one to the next without a "go ahead" from the user.

## How it works inside (explain it this simply)

- Transcription: converts the caller's voice into text.
- Brain: a language model, such as Claude, decides what to answer according to a script and the business information.
- Synthetic voice: converts the answer into voice.
- Around it: the phone line (or a website or app) and the logic to let the caller speak, handle interruptions, and hand off to a person.
- There are also models that go from voice to voice without passing through text [check what each provider offers today].

## Before starting, ask

- What is it for? Taking messages, booking appointments, answering frequent questions, screening calls.
- Incoming calls, outgoing, or both? Outgoing commercial calls have strict rules.
- Where will it be used? Phone line, website, or app.
- What languages and accents will callers have? Peninsular Spanish, Catalan, Galician, Basque, English.
- How many calls a day and of how many minutes, roughly? [NUMBER]
- What information can it give and what can it not? Where is it (website, PDF, Excel)?
- What happens when it does not know something or the person gets angry? Who is it transferred to and during what hours?
- Are calls recorded? What is stored and for how long?
- What is the maximum monthly budget and who answers if it fails?

## Phase 1. Design (always)

1. Choose the path. A) A ready-made voice agent platform, charged per minute and needing almost no code. Some names: Vapi, Retell, ElevenLabs [check that they still exist and their rates]. B) A custom build with separate components, for example LiveKit Agents or Pipecat [check]. It gives more control and more technical work. If the user does not code, recommend starting with A, validating with real calls, and moving to B only if cost or control demands it.
2. Write the script: a greeting that says it is an automated assistant, what it can do, a flow for each task with the questions in order, repeating key data (name, phone, date) to confirm it, and a goodbye.
3. Voice rules: short sentences, one question at a time, numbers said in groups, brief silences. Write for the ear, not for reading.
4. Handoff to a person. Define the phrases that trigger it (I want to talk to someone, complaint, urgency) and what happens: transfer during business hours or take a message and call back. If the person describes an emergency, tell them to call 112 (Spain's emergency number) and do not continue with the script.
5. Knowledge base: a single document with hours, prices, policies, and address, with a review date. The assistant answers only from that. If it is not there: "I don't know, I'll transfer you to a person" or "we'll call you back."
6. Latency and cost. Latency is the time from when the person stops talking until they hear the first word. If it is long, people talk over it or hang up. Measure it in the tests. The cost per minute adds up line, transcription, model, voice, and platform [check each one's rate]. Multiply it by the minutes per month.
7. Test plan with 20 calls: normal, a person who interrupts, background noise, a strong accent, a phone number said badly, an off-topic question, an attempt to make the assistant say something it should not, a request to speak with a person, and silence.

## Phase 2. Prototype (only if the user asks)

1. Ask which path they are following. With A, help write the script and the knowledge base to paste into the chosen platform.
2. With B, create the project in a new, isolated folder. Explain in plain language what each file does. The service keys go in a keys file, never in the chat. Test only with the user's phone.
3. Warn that installing it and keeping it running 24 hours a day requires technical knowledge. A technical person must review it before it receives real calls.
4. Do not connect it to a real line until it passes the test plan.

## Phase 3. Launch (checklist for a person)

- The assistant announces at the start that it is an AI. The EU AI Act requires it (Article 50) [confirm with an advisor the application dates and the exceptions in force].
- If it records, notice is given before recording.
- Contracts with the providers as data processors, and where the data is stored [review].
- Spending limits turned on at each provider.
- Phone number of an on-call person.
- Weekly review of a sample of calls during the first month.

## What to return

A dossier with these parts: five-line summary; what the assistant does and does not do; chosen path and why; script by task; voice and handoff rules; knowledge base template; cost estimate with formula and cells [in brackets]; test plan as a table; legal checklist for a person; known risks. If there is a prototype: list of files, how to test it with the phone, and what is missing.

## What NOT to do

- Do not put the assistant on a real line without testing or legal review.
- Do not have it claim to be a person.
- Do not allow it to make up prices, calendar slots, or policies.
- Do not use it for unsolicited sales calls. In Spain they are heavily restricted and require prior consent [review with a lawyer].
- Do not collect card data, national ID numbers (DNI), or passwords by voice. To charge, send a payment link through another channel [review with an expert].
- Do not use voice to identify anyone.
- Do not clone a real person's voice without their written permission. Use voices licensed by the provider.
- Do not give medical, legal, or financial advice. Only basic information and messages.
- Do not keep recordings just in case. Define a purpose and a retention period.
- Do not paste API keys into the chat.
- Do not promise savings. The real cost depends on the minutes and the providers.

## What a person reviews before using the result

- The complete script and the knowledge base.
- The AI and recording notices, and the privacy policy.
- The contracts with providers and where the data goes.
- The tests with real voices and accents, not just the user's own.
- The real cost after a week of test calls.

## Where to save it

Save this text as SKILL.md in the .claude/skills/asistente-telefonico-voz-ia/ folder of your project.
