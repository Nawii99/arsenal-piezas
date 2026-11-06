# Playable Demo Plan

**Type:** Prompt · **Area:** Games & 3D · **License:** CC BY 4.0 · [Spanish original](../../../prompts/juegos/plan-demo-juego.md)

Prompt that plans a playable demo for Steam or itch.io: what to include, what to cut and how it should end.

## What it is and what it does

Prompt to paste into Claude, Codex, Gemini, or a local AI that designs a game's playable demo before uploading it to Steam or itch.io. It takes the name, genre, length of the full game, desired demo length, main mechanic, and the highlight moment; it returns which stretch to include, what to show in the first five minutes, what to leave out, and where to put the closing. Example: with a 20-minute demo, it suggests cutting before the final boss. Used a few weeks before launch.

## The prompt (copy it whole)

```text
I want you to help me design the playable demo of my game to upload to Steam or itch.io before launch.

Game details:
- Name: [GAME NAME]
- Genre: [GENRE]
- Total length of the full game: [TOTAL LENGTH]
- Length I want the demo to have: [DEMO LENGTH IN MINUTES]
- Main mechanic in one sentence: [MAIN MECHANIC]
- Moment in the full game where the best mechanic or the best twist is: [HIGHLIGHT MOMENT]
- Launch platform: [PLATFORM]

With these details, I want you to tell me:
1. Which stretch of the full game the demo should include (the beginning, a middle level, or a special cut made just for the demo).
2. What I should show in the first 5 minutes to hook players, without over-explaining.
3. What I should leave out even if it hurts (spoilers, advanced mechanics, final content).
4. Where to put the final cut of the demo and what message to show (for example, a link to the wishlist or the store page).
5. Whether it is worth adding any difference between the demo and the full game (achievements, a save that does not carry over, etc.) and what to tell the player about it.

At the end, also give me two short sentences for the "end of demo" message that invite players to add the game to their wishlist, without sounding desperate or promising a release date if I don't have one confirmed.
```
