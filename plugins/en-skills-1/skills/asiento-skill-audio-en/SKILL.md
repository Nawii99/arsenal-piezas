---
name: asiento-skill-audio-en
description: Guides the repair of a bad voice recording (background noise, uneven volume, hollow sound, music over the voice) by choosing the right tool for each problem and in the right order, because doing it the other way around ruins the audio.
---

# Clean up a voice recording

Use this skill when someone has a recording that cannot be published as is: an interview with noise, a class recorded in a room with echo, a video with music over the voice.

## The rule almost everyone skips

**Order matters more than tools.** Each step constrains the next, and doing it the other way around introduces problems that can no longer be removed afterward. If someone normalizes the volume before removing the noise, they amplify the noise.

## Correct order

1. **Separate, if there is music or several voices on top.** Ultimate Vocal Remover or
   Spleeter. This goes first because everything else works worse on a
   mix.
2. **Cut what is surplus.** Long silences, coughs, false starts. It is faster
   now, with a clean waveform, than later.
3. **Remove the background noise.** In Audacity: select a stretch of noise only
   so it learns what the noise is, and then apply it to everything. If you overdo it, the voice
   sounds metallic: it is better to leave some noise than to wreck the voice.
4. **Fix the tone.** Cut the very low frequencies (the rumble of the
   table) and, if it sounds dull, raise the clarity region a little.
5. **Even out the volume.** Gentle compression first, normalization afterward.
   In this order and not the other way around.
6. **Check on cheap earbuds and on the phone speaker.** That is where people
   will listen to it, not on your good headphones.

## What cannot be fixed

Say so clearly when it applies, instead of making anyone waste the day:

- Clipped voice (recorded too loud): it cannot be recovered, it must be re-recorded.
- Very reverberant room: it can be improved, not fixed.
- Microphone three meters away: the noise and the voice are at the same level and separating them
  wrecks the voice.
- Audio from a video that was compressed many times: information is missing that is not there.

## Output

Return: what problems the recording has, in what order they must be tackled, with
which tool for each, which specific setting to try first, and which part of the
recording cannot be fixed, if any. If a re-recording is needed, say so early.
