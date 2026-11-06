---
name: auditoria-licencias-assets-en
description: Audits the licenses of all of a game's assets (graphics, audio, fonts, code, AI-generated content) and returns a traffic-light report ready to hand to a client. Activate it when someone wants to know whether they can sell their game without legal problems or asks to review assets before publishing on Steam, itch.io, or Google Play.
---

# Asset license audit

This is a fixed-price service: the studio gives you its list of assets, and you deliver a report and a task list. It is not legal advice and the report must say so on the first line.

## What to ask before starting

Ask for this in a single message, not one at a time:
1. Where will the game be sold? (Steam, itch.io, Google Play, App Store, console). What is required changes.
2. Is it paid, free with in-app purchases, or completely free? Many licenses only allow non-commercial use.
3. A list of assets or access to the project folder. If they give you the folder, list the art, audio, fonts, and plugins subfolders yourself before touching anything.
4. Where did each asset come from? A store (Unity Asset Store, Fab, itch.io), a free pack (Kenney, OpenGameArt), commissioned from an artist, made with AI, or they don't know.
5. Is there an invoice, receipt, or email for each purchase or commission? Without paperwork there is no provable license.

## Step by step

1. Build a table with one row per asset or pack: name, type, source, declared license, link or document that proves it, use in the game.
2. Classify each row with this traffic light:
   - GREEN: a clear license that allows commercial use and the proof is kept (CC0, a store purchase with an invoice, a signed contract with the artist, OFL for fonts).
   - YELLOW: can be used but with a pending condition. Examples: CC BY not yet credited in the credits, music licensed but without permission for the YouTube trailer, a font downloaded from dafont marked for personal use only.
   - RED: cannot be sold like this. Examples: a non-commercial license (CC BY-NC), an asset taken from another game or from an image search, GPL code mixed into a closed-source game, an asset with no known origin.
3. Cases that are often overlooked and that you must always check:
   - Fonts: they are what fails most. Each one needs its license, including the ones in the logo.
   - Music and sound effects: check whether the license covers trailers and third-party videos. If not, streamers get copyright claims and stop playing it.
   - Store packs: the standard Unity Asset Store and Fab license allows using them inside the game, not reselling the assets on their own. If the client sells a level pack or an editor, warn them.
   - AI content: Steam requires declaring on the store page if there is AI-generated content. Note it in the report even if the client doesn't consider it important.
   - Commissions to artists: if there is no contract assigning the exploitation rights, the artist is still the owner. In Spain, the assignment of rights must be in writing.
4. For each yellow or red row, write the concrete action: replace with [specific CC0 alternative], pay for the commercial license, ask the artist for a contract, add attribution in the credits with the exact text.
5. Draft the credits and attributions file that the client can paste as-is into the game and the store page.

## What to return

Three files, in this order:
1. `informe-licencias.md`: first line with the notice that it is not legal advice. Summary in three numbers (greens, yellows, reds). Complete table. List of actions ordered by risk, reds first.
2. `creditos.txt`: ready-to-copy attributions, one per line, in the format each license requires.
3. `propuesta-siguiente-paso.md`: which tasks you can do for an extra fee (replacing assets, drafting the template contract with the artist, preparing the AI declaration for Steam) and which need a lawyer.

## How to charge for it

- Fixed price in tiers by number of assets: up to [N] assets [PRICE] euros, beyond that [PRICE PER BLOCK]. Nothing by the hour: the client doesn't know how many hours it is and neither do you at the start.
- If you are a freelancer in Spain, add 21% Spanish VAT (IVA) to the price for Spanish clients. If the studio is from another EU country and has an intra-community VAT number, it is invoiced without VAT under the reverse charge, and for that you need to be registered in the ROI (Spain's register of intra-EU operators).
- Charge 50% before starting. A license report is easy to receive and not pay for.

## What NOT to do

- Don't approve an asset because "everyone uses it". Ask for the link to the license and read it.
- Don't invent the text of a license. If you can't find it, the row goes red with the note "license not located".
- Don't sign off that the game "is legal". You attest that you have reviewed what you were given and with what result.
- Don't delete or replace any asset in the client's project during the audit. You only report.
- Don't mix marketing recommendations into the same report. That is another service and is sold separately.
