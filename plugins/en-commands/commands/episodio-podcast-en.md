---
name: episodio-podcast-en
description: Prepares a podcast episode from a transcript or notes, in three modes. Episode notes, promotional texts, and publish checklist. Launched with /episodio-podcast-en, the mode, and the file.
---

# /episodio-podcast-en

Usage: `/episodio-podcast-en notas episodios/012/transcripcion.txt`
Modes: `notas` (notes), `promo`, and `publicar` (publish). The first word is the mode and the next is the file path.
Arguments received: $ARGUMENTS

## What it does
A single command with three modes for the repeated work of every episode. You write texts and lists. You don't publish anything.

## Before starting
If the arguments are empty, or the mode or the file is missing, ask and wait. Then ask, all at once and at most 6 things:
1. Podcast name and working title or episode number.
2. Guest: name and title as they want it to appear, or none.
3. Tone: friendly, serious, funny.
4. Links they want to include.
5. Is there a sponsor or affiliate links?
6. Where it is hosted (iVoox, Spotify, Apple Podcasts, YouTube, or other).
If the file doesn't exist or you can't open it, say so and stop. Do not improvise the content.

## Notes mode
1. Read the entire file.
2. Generate: 3 titles of 60 characters at most, without promising what the episode doesn't deliver; a 2-sentence summary; a description of 100 to 150 words for the platform; 5 key points; 5 to 8 keywords.
3. Chapters with timestamps ONLY if the transcript includes times. If not, use [MM:SS] for the person to fill in.
4. Up to 3 verbatim quotes, copied exactly from the text.
5. Links and resources: only those mentioned in the file.
6. Guest bio: only with the data you have been given.
7. Mark with [REVIEW] proper names, figures, and any claim about health, money, or law made in the episode.

## Promo mode
1. Three social media posts, each with a short text and a quote from the episode. Maximum 3 hashtags. [CHECK the character limits of each network].
2. A short email for the subscriber list.
3. A 20-second script for an audio teaser or stories.
4. If there is a sponsor or affiliate links, make it clear in each text: "Advertisement", "Partnership", or "affiliate link".

## Publish mode
Return a list with checkboxes [ ] to tick by hand:
- Final audio listened to in full (even volume, no noise, no parts the guest asked to remove).
- Title, description, episode number, category, and cover image.
- Explicit content tag if applicable.
- Music and clips licensed or with permission.
- Guest's permission to publish and to quote them.
- Chapters, and subtitles if you also upload it as video.
- Links tested one by one.
- Scheduled date and time.
- After publishing: check that it appears on each platform (it may take a while).

## What to return
The result of the requested mode, in Markdown, with clear headings. If the person asks, save it at `episodios/[NUMBER]/notas-episodio.md`. If the file already exists, do not overwrite it: create one with `-v2` at the end.

## What NOT to do
- Do not invent quotes, figures, names, minutes, or links.
- Do not publish, schedule, or send anything, and do not log in to the hosting platform.
- Do not attribute to the guest things they didn't say or change the meaning of a sentence when cleaning it up.
- Do not let advertising pass without warning. If there is sponsorship or affiliates, the listener must see it clearly.
- Do not use third-party music or clips without a license.
- Do not take as true what is said about health, money, or law. Mark [REVIEW] and warn the person.
- Do not put third parties' personal data, such as phone numbers or emails, in public notes.
- Do not mix episodes. Work only with the indicated file.
- Always warn that an AI-made transcript may have errors in names and figures.
- Remember that the text you give Claude is sent to the AI. Do not use private conversations or guests' sensitive data without their permission.

## For the person, not for Claude. How to organize many commands
Claude, ignore this section.
- Each command is a `.md` file inside `.claude/commands/` in your project, or in `~/.claude/commands/` if you want it in all your projects. The file name is the command name.
- To organize, create subfolders, for example `.claude/commands/podcast/`. Depending on your version of Claude Code, the command may appear with or without the folder name. Type `/` and see how it shows up in the list.
- Simpler alternative: a single command with modes, like this one. Fewer files, less hassle.
- If one day you need Claude to make a separate decision, with its own memory, that is already a subagent and goes in `.claude/agents/`.
