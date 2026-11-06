---
name: cambios-juego
description: Prepares clean commits, a PR description, and a summary of the repository's state in video game projects with many assets. Use it before pushing changes or putting out a public release. It is used with commit, pr, or contexto as the first argument.
---
# Game changes: commit, PR, and context

Arguments received: $ARGUMENTS
(The first word chooses the mode, which can be commit, pr, or contexto. If there is none, ask which one.)

## Where to save it
Save this file as `.claude/commands/cambios-juego.md` in the game's repository. It is used with `/cambios-juego commit`, `/cambios-juego pr`, or `/cambios-juego contexto`.

## What it does
- Commit mode: reviews the pending changes, separates them by type (code, assets, configuration), and proposes one or more commits with a clear message.
- PR mode: writes the Pull Request description and a checklist for public releases.
- Context mode: summarizes the repository's state on one page for someone arriving new or to resume tomorrow. Read-only.

## Before starting, ask (once)
1. Engine: Unity, Godot, Unreal, libGDX, or other.
2. Language of the commit messages, Spanish or English, and whether there is a style guide in CONTRIBUTING.
3. Main branch and whether work is done with PRs or directly.
4. Whether the repository is public or private.
5. Whether Git LFS is installed, which is used for heavy files.
6. Who reviews the PRs.
At the end, ask whether they want you to record the answers in `CLAUDE.md`. If they say no, don't touch it.

## Step by step, commit mode
1. Run `git status` and `git diff --stat`. Don't use `git add -A` or `git add .` blindly.
2. Group the files: code, assets (images, audio, models, scenes), configuration, and generated files.
3. Generated files (build, Library, Temp, .godot, Intermediate, and similar) are not committed. If they appear, warn and propose adding them to `.gitignore`.
4. Alerts before proposing anything.
   - A file over 50 MB, which GitHub warns about, or over 100 MB, which GitHub rejects. Propose Git LFS, but don't set it up yourself.
   - Signing keys (.keystore, .jks), `google-services.json`, `.env`, or tokens. These are never committed.
   - Assets with no author or license noted: music, fonts, sprites, sounds.
   - If it is Unity: an asset without its `.meta` or a `.meta` without its asset.
5. Propose the commits: one topic per commit, with code and assets separated. Title of 72 characters at most, in the imperative. If needed, a brief body that explains the why.
6. Show the list of files in each commit and its message. Wait for a "yes" before running `git commit`.
7. Don't run `git push`. End by saying: "The commits are local. Push them yourself whenever you want."

## Step by step, PR mode
1. Look at the current branch, the base branch, and the commits that will be included (`git log` and `git diff` against the base).
2. Write the description with these sections.
   - What changes for the player, in one or two sentences.
   - What changes internally.
   - How to test it: level or scene, platform, and steps.
   - Screenshots or video: indicate which are needed and put [ATTACH]. Don't invent them.
   - New assets: name, author, license, and link.
   - Risks: saved games that stop working, performance, build size.
3. If the PR goes into a public release, add this checklist and check only what you were able to verify.
   - Licenses of third-party material reviewed.
   - No keys or private data in the PR's commits.
   - Version number and patch notes for players.
   - Tested on a real device, not only in the editor.
   - If the game has ads, analytics, or requests data: privacy policy and consent ready.
   - If minors play: age rating reviewed.
4. If `gh` (GitHub CLI) is installed and they ask for it, offer to create the PR with `gh pr create`. Ask for confirmation first: in a public repository, everyone sees the PR. If not, deliver the text to paste.

## Step by step, context mode
1. Read-only. Current branch, last 10 commits, unsaved changes, open branches, and, if `gh` is available, open PRs.
2. Structure: which folders exist and what each is for, based on their names and the README. Approximate size of the asset folders.
3. How to open and run the game, if the README says so. If not, say it is not documented.
4. Pending items visible in the code or the commits (TODO, FIXME). At most 10.

## What to return
- Commit mode: table with commit, files, message, and alerts. Then, what you ran and what remains local.
- PR mode: text ready to paste into the PR, with the [ATTACH] markers flagged, and separately the list of what you could not verify.
- Context mode: one page at most, with short sections and no jargon.

## What NOT to do
- Don't run `git push`, `--force`, `reset --hard`, `rebase`, or `commit --amend` on changes that have already been pushed.
- Don't use `--no-verify` to skip checks.
- Don't install Git LFS or change `.gitattributes` without permission. Migrating files that are already in the history to LFS rewrites the history. That is done by a person who knows how, with a backup.
- Don't delete assets or branches.
- Don't commit keys, even if asked in a hurry. Stop and warn.
- Don't invent licenses or authors of assets. If not on record, write [NO LICENSE ON RECORD].
- Don't claim the build works if you haven't tested it.

## When to ask a person
- If a key was already pushed to the repository: change it at the originating service. Deleting the file is not enough, because it stays in the history.
- If the history is too heavy or there are stuck files over 100 MB: a technician with Git LFS.
- If you are going to publish with third-party music, fonts, or graphics without a clear license, it can be a copyright problem. Ask the author for permission or consult a lawyer before publishing.
