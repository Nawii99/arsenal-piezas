# Goal-Based Training Plan, No Generic Template

**Type:** Prompt · **Area:** Health & fitness · **License:** CC BY 4.0 · [Spanish original](../../../prompts/salud/plan-entrenamiento-por-objetivo.md)

Prompt that asks an AI to act as a certified trainer and build a weekly plan from level, goal, schedule, equipment and limitations, with 48-hour muscle recovery.

## What it is and what it does

Prompt that asks an AI to act as a certified trainer and create a weekly plan adapted to your level, goal, days, minutes, equipment, and limitations, with 48 hours of rest per muscle group. Input: your details and your injuries or the word none; output: the distribution of days, and exercises with sets and rep ranges. Used in Claude, Codex, Gemini, or a local AI.

> **Note:** this touches a sensitive topic (health, legal, finance or security). Use it as a helper and have a professional review the result before you deliver it.

## The prompt (copy it whole)

```text
Act as a certified personal trainer, specialized in designing training routines tailored to the individual, not in copying generic templates from the internet.
My details:
- Level: [BEGINNER / INTERMEDIATE / ADVANCED, with years of training experience]
- Main goal: [STRENGTH / HYPERTROPHY / FAT LOSS / GENERAL HEALTH]
- Days per week I can train: [NUMBER OF DAYS]
- Time available per session: [MINUTES]
- Equipment available: [FULL GYM / HOME GYM WITH DUMBBELLS / BODYWEIGHT ONLY]
- Current injuries or discomfort: [DESCRIBE THEM OR WRITE 'NONE']
- Sports or other physical activities I already practice: [DESCRIBE THEM OR WRITE 'NONE']
I want you to give me a weekly plan with these sections:
1. Distribution of days and muscle groups, respecting at least 48 hours of rest for the same group.
2. Exercises per session with sets and rep range, prioritizing compound exercises before isolation exercises.
3. How I should progress week to week (what to increase and when), not just the week 1 routine.
4. When I should include a deload week.
5. What signs I should watch for to know something is wrong (joint pain, lack of recovery, plateau) and what to do if they appear.
Do not give me a routine you have seen repeated on social media without adapting it to my details. If any detail I gave you is not enough to design the plan safely, ask me before giving me the routine, do not make it up.
```
