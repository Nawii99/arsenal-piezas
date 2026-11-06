---
name: auditor-licencias-assets
description: Reviews a game's asset list (art, sound, music, plugins, third-party code) and flags which licenses carry risk before publishing on Steam or itch.io. It activates when asked to review licenses, prepare a launch, or run a legal audit of assets.
---

# What it does
It receives the list of assets the game uses (or the whole project if it has access to the folder) and for each one checks: where it comes from, what license it has, whether that license allows commercial use, whether it requires attribution, and whether there is any limit (for example, a free asset for only one game, or a typeface for personal use only).

# What to ask before starting
- Will the game be sold or free? Many licenses change if money is involved.
- On which store will it be published (Steam, itch.io, Epic, mobile)? Each one asks for different things in the credits.
- Do you have the invoices or download pages for each asset? Without that, nothing can be confirmed, only risk estimated.
- Are there assets made on commission (freelance)? Ask for the contract or the message where use is granted.

# Step by step
1. Ask for the asset list with: name, type (art, sound, music, font, plugin, code library), origin (store or author), and whether any license file has been saved.
2. For each asset, find the exact text of the license (do not rely on the client's memory or on "I think it was free").
3. Classify each one as green, yellow, or red: green (clear license compatible with selling the game), yellow (a piece of data is missing, such as attribution or license version), red (prohibits commercial use, requires buying an extended license, or there is no way to verify it).
4. For the yellows and reds, propose a concrete action: ask for the invoice, buy an extended license, replace the asset, or add the missing attribution.
5. Review third-party code separately (SDKs, engine plugins, libraries): many GPL-type licenses require you to publish your own code if you use them, and that may not suit the studio.

# What to return
A table with columns: asset, type, license, status (green/yellow/red), recommended action. Below it, a 3-4 sentence summary of whether the game is ready to be published or what is blocking the launch.

# How to turn it into a billable service
This can be sold as a "launch audit" to small studios or solo developers: you deliver the table as a PDF plus a 30-minute call explaining the risks. Charge per project, not per hour, according to the number of assets (for example, cheaper up to 50 assets and more expensive above that). Always state in writing: the audit is not legal advice, it is a risk review done by a non-lawyer.

# What NOT to do
- Do not treat a license as valid just because the client says they "downloaded it for free": ask for the source.
- Do not present it as a legal guarantee or as a substitute for a lawyer: if there are serious doubts (for example, an asset that looks copied from a commercial game), say so clearly and recommend a real legal consultation.
- Do not ignore code under the GPL or a similar license just because "it's only a small library": always review code licenses, not just art licenses.
- Do not bill the audit as if it certified that the game is "legally clean": it certifies only what you have been able to verify with the documents you were given.
