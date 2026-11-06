# Presentation Script for a Class

**Type:** Prompt · **Area:** Education · **License:** CC BY 4.0 · [Spanish original](../../../prompts/educacion/prompt-presentacion-clase.md)

Prompt that asks an AI for a classroom slide script: what appears on each slide, what the teacher says and which questions to ask, sized to the available minutes.

## What it is and what it does

A prompt that requests a slide script for explaining a topic in class: what is on each slide, what the teacher says, and what questions they ask. Input: the topic, the grade, the minutes, and the group profile; output: 8 to 12 slides with brief text. Used in any AI and then laid out in PowerPoint, Google Slides, or Canva.

## The prompt (copy it whole)

```text
You are a teacher with experience in [STAGE AND GRADE, E.G. 2ND YEAR OF ESO (SPANISH LOWER SECONDARY)] in Spain. Help me prepare a class presentation.

Topic: [SPECIFIC TOPIC, E.G. THE LAYERS OF THE EARTH]
Subject: [SUBJECT]
Length of the explanation: [MINUTES, E.G. 20] minutes (the rest of the session will be practice).
What they already know about the topic: [WHAT HAS BEEN COVERED BEFORE OR "NOTHING"]
What I want them to take away at the end: [ONE OR TWO KEY IDEAS]
What they are like as a group: [E.G. 26 STUDENTS, EASILY DISTRACTED, TWO WITH LIMITED SPANISH]

I want a slide script, not running text. Rules:

1. Between 8 and 12 slides for those minutes. Not one more.
2. For each slide give me three separate things:
   - TITLE AND CONTENT: what is seen on screen. Maximum 25 words or an image described in brackets (e.g. [PHOTO: cross-section of the Earth]). No paragraphs on the slide.
   - WHAT I SAY: what I explain with that slide up, in spoken language, 3-5 sentences.
   - QUESTION OR ACTION: a question to put to the class, or an action (raise their hands, talk for 30 seconds with the person next to them, write something down). On at least half of the slides.
3. Slide 1 hooks: a question, a strange image, or a surprising fact. Do not just put the topic title.
4. The second-to-last slide summarizes in 3 points what has been explained. The last one launches the practice task or a question to think about.
5. Use examples of things that a student of that age in Spain knows. No examples translated from other countries.
6. If you are not sure of a numerical figure or a date, write it as [CHECK: fact] instead of inventing it.
7. At the end, separate from the script, give me:
   - A warning about on which slide attention usually drifts and what to do.
   - A version reduced to 5 slides in case I am running short on time.
   - Three terms from the topic that are worth writing on the board for students with limited Spanish.

Format: one section per slide, numbered, with the three parts in bold. No introduction or farewell.
```
