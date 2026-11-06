---
name: audio-ffmpeg-sin-tocar-originales
description: Writes and tests ffmpeg scripts to convert, even out the volume of, and clean up audio (podcasts, voice-overs, interviews) without touching the original files, and prepares the upload. Activates when you ask to convert audio to MP3 or WAV, even out volume, remove long silences, or process a batch of episodes.
---

# Audio with ffmpeg without touching the originals

## What it does
ffmpeg is a free program that converts and processes audio and video from the terminal. Claude writes the commands, tests them on a single file, and, if you like the result, applies them to the whole batch. The originals are never touched.
Where to put it: save this text as SKILL.md inside .claude/skills/audio-ffmpeg-sin-tocar-originales/ in your project.
This runs on a computer with Claude Code. From an Android phone you can leave the request prepared, but the processing happens on the computer.
How to ask for it: "Convert the 12 episodes in the raw folder to MP3 with even volume, without touching the originals."

## Ask before starting
1. What files are there, in what format, how many, and in which folder?
2. What do you want at the end? Format (MP3, WAV, M4A), mono or stereo, and quality.
3. Where will it be published? Each platform requires its own volume and format. Ask for the link to its requirements. If you don't have it, use [VOLUME TARGET IN LUFS, typically -16 for podcasts] and warn that it needs to be confirmed.
4. What is the problem? Uneven volume, background noise, long silences, or a format they don't accept.
5. Is the audio yours or a client's? Is there music, guests, or third-party voices?
6. Is ffmpeg installed? Have Claude check with ffmpeg -version. If it is missing, have it explain how to install it from the official website or from the system's package manager. No downloads from shady sites.
7. Windows, Mac, or Linux? The type of script changes.

## Step by step
1. Confirm that a backup of the originals exists. The output always goes to a new folder, for example processed.
2. First look at what is there: duration, format, and average volume of each file. Summarize it in a table.
3. Explain the processing in plain language and wait for approval.
4. Write the command for a single file. Common patterns:
- Convert and even out volume: ffmpeg -n -i entrada.wav -af loudnorm=I=-16:TP=-1.5:LRA=11 -c:a libmp3lame -b:a 128k procesado/salida.mp3
- The -n option makes ffmpeg not overwrite anything. For voice only, -ac 1 converts it to mono.
- Remove annoying low frequencies and light noise: highpass and afftdn filters, in small doses.
- Remove long silences: silenceremove filter. Careful: it can eat the ends of words. Have Claude tune the values and show them.
5. Test with a 30 to 60 second clip. Ask the user to listen to it with headphones.
6. If it sounds good, write the batch script (a .sh or .bat file) that loops through the folder, writes to processed, and keeps a log of what it does.
7. Run the batch. Check that as many files come out as went in and that none lasts 0 seconds.
8. Upload, only if the user asks for it: either upload the files by hand, or set up an n8n flow that starts when there is a new file in the folder, goes through a manual approval step, and only then uploads to the hosting service. Never an upload that publishes on its own.

## What to return
The processed folder with the new files and clear names, for example YYYY-MM-DD_name_v2.mp3.
A table with one row per file:
| File | Duration before | Duration after | Volume before | Volume after | Size | Notes |
|---|---|---|---|---|---|---|
The saved script, so it can be repeated, and a 5-line explanation of what each part does.
A list of what a person needs to listen for before publishing.

## What NOT to do
- Don't use the -y option, which overwrites, and don't delete files. Never run delete commands on the user's folders.
- Don't process the whole batch without having tested one file.
- Don't promise studio quality. Heavy cleanup leaves the voice sounding metallic. If the audio is badly damaged, say so.
- Don't upload anything to the internet without an explicit yes.
- Don't cut sentences or reorder the content unless asked.
- Don't use copyrighted music or effects. If commercial music plays in a client's audio, warn them: publishing it could cause them problems.
- Don't clone or imitate voices.
- Don't install programs from unknown sources.

## What a person reviews
Someone listens to the result, in full or in sections, before publishing: cuts inside words, volume, new noises.
If there are guest or client voices, the voice is personal data. They must have given permission for it to be published.
If you are going to charge for it, have a short contract that states what you deliver, how many revisions are included, and who keeps the originals.

Piece reviewed in October 2026. Each platform's volume and format requirements change: confirm them on its website.
