# Editing Brief for a Recurring Format

**Type:** Prompt · **Area:** Video · **License:** CC BY 4.0 · [Spanish original](../../../prompts/video/brief-edicion-formato-recurrente.md)

Prompt that generates a fixed editing brief for a recurring video format, so the structure does not need deciding every time.

## What it is and what it does

Prompt to paste into Claude, Codex, Gemini, or a local AI that generates a fixed editing brief for a video format that repeats, such as a weekly recap or a news reel. Input: the platform, the duration, the usual structure, the title style, the music, and the frequently forgotten items; output: a list of editing steps that repeats every time. Example: a 60-second weekly recap with a hook, three points, and a closing. Used so you don't have to decide the structure with each edit.

## The prompt (copy it whole)

```text
You are my editing assistant. I have a video format that I repeat every week and I want a fixed editing brief that I can follow without thinking each time, so I don't waste time deciding the same things over and over.

Format details:
- Format name: [FORMAT NAME, E.G. WEEKLY RECAP]
- Target platform: [PLATFORM, E.G. INSTAGRAM REELS / YOUTUBE / TIKTOK]
- Target duration: [DURATION IN SECONDS OR MINUTES]
- Editing software I use: [CAPCUT / DAVINCI RESOLVE / KDENLIVE]
- Usual content structure: [E.G. HOOK, 3 POINTS, CLOSING WITH A CALL TO ACTION]
- Title style: [E.G. BIG TITLES AT EACH CHANGE OF IDEA / SUBTITLES ONLY]
- Music or silence: [TYPE OF MUSIC OR "NO MUSIC"]
- Things I usually forget when editing: [E.G. LOWER THE MUSIC VOLUME WHEN I SPEAK, PUT THE LOGO AT THE END]

With these details, give me an editing brief as a list of steps, in the order in which I have to do things inside the software I use, from importing the clips to exporting. Include at which step the titles go, at which step the music goes down, and a final reminder with the things I usually forget. Do not give me general editing advice, only the steps for this specific format.
```
