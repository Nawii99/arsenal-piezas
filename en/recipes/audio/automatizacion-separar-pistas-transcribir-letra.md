# n8n: Split Tracks and Transcribe Lyrics on Audio Upload

**Type:** Automation recipe · **Area:** Music & audio · **License:** CC BY 4.0 · [Spanish original](../../../recetas/n8n/audio/automatizacion-separar-pistas-transcribir-letra.md)

n8n workflow that watches a Drive folder, filters audio files, sends them to a stem-separation API, polls for results and logs lyric transcriptions.

## What it is and what it does

An n8n flow that watches a Google Drive folder of incoming audio, filters the audio files, sends them to a track separation service, waits for the result with a polling loop, uploads the tracks to Drive, and adds the lyrics transcription to a tracking sheet. Inputs are mp3, wav, or m4a files, and the outputs are separated tracks and transcribed lyrics, with no manual intervention.

## The recipe, step by step

1. Trigger: Google Drive Trigger node, 'file created' event, watching a specific folder (e.g. 'Incoming audio'). Account: Google, free, subject to the normal Drive API limit.
2. IF node: filters so that the new file has an audio extension (mp3, wav, m4a), to avoid processing folders or documents that don't belong.
3. HTTP Request node: uploads the file to the track separation API you use (for example lalal.ai). It needs an account with your own API key; check the free limit of the plan you choose, because it is usually a few minutes per month and then you pay per use.
4. Wait node + HTTP Request node in a loop (or Split in Batches): checks the status of the process every so often until the separation is ready, instead of assuming it has already finished.
5. HTTP Request node: downloads the resulting tracks (vocals and instrumental) once the status is 'completed'.
6. Google Drive node: uploads the downloaded tracks to a subfolder named after the song, inside 'Processed'.
7. HTTP Request node to the Whisper API (OpenAI): transcribes the vocal track to get the lyrics as text. Account: OpenAI, pay per use; Whisper is cheap but has no free tier.
8. Google Sheets node: adds a row with the file name, date, link to the Drive folder with the tracks, and the transcribed lyrics, and status 'done'.
9. Notification node (Telegram or Email): notifies that the song is ready, with the link to the folder. Account: Telegram bot, free, or the email you already use.
10. Accounts needed in total: n8n (self-hosted, free with the Community Edition; n8n Cloud only has a temporary free trial and is paid afterwards), Google (Drive and Sheets, free), the chosen track separation tool (check its specific free limit), OpenAI for Whisper (pay per use) and, if you notify through Telegram, a free bot.
11. How to test it without messing up: first test it with a short, unimportant audio (about 15 seconds), run it node by node with 'Execute step' instead of activating it entirely, and check the Drive folder and the Sheets row before turning on the trigger automatically.
12. Don't activate the trigger in production mode until you have tested it with 2 or 3 real audio files: a silent failure here means processing real customers' audio incorrectly.
13. Cost warning: each processed song consumes paid minutes or credits in the separation API and in Whisper; before offering it as a service, calculate the real cost per song so you don't charge less than you spend.
