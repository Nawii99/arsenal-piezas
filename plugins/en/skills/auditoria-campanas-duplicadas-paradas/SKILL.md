---
name: auditoria-campanas-duplicadas-paradas
description: Audits piled-up email or ad campaigns, detects duplicates, paused campaigns, and ones that spend without delivering results, and proposes what to keep, pause, or archive. Use it when cleaning up accounts or before reviewing budgets. It deletes nothing and does not touch budgets.
---

# Campaign Audit: Duplicate, Paused, and Ownerless

## What it does
It gathers the campaigns from one or several accounts into a single table, finds the ones that are surplus or left hanging, and proposes an action for each. It is an audit: it proposes, it does not execute on its own. "Cleaning up" here means pausing or archiving, never deleting.
Where to save it: in .claude/skills/auditoria-campanas-duplicadas-paradas/SKILL.md inside your project, or in ~/.claude/skills/ for all projects. If you do not know how, ask Claude to save it for you.

## How to connect it
- Export from each platform (Google Ads, Meta Ads, Brevo, Mailchimp, or another) a CSV with name, status, creation date, last send or last impression, spend, and results. Leave the CSVs in the project folder.
- If there is an MCP connector for the platform (/mcp shows the installed ones), use it read-only. Writing is left for the last step and requires permission.
- Access keys never go in the chat.

## Ask before starting
1. Which platforms and which accounts? Are they yours or your clients'? If they are clients', is there written permission to touch them?
2. Since when does a campaign count as inactive? Propose [90 days] and let the person change it.
3. Are there seasonal campaigns (sales, Christmas, back to school) or brand campaigns that should stay even if paused?
4. Are there campaigns that must be kept for contractual reasons, client reports, or audits?
5. Is there a naming convention? If not, one is proposed.
6. Who decides on the budget? That person approves the actions.

## Step by step
1. Load all the CSVs and say how many rows you read out of how many there are. Combine everything into one table: platform, account, id, name, status, created, last activity, spend for 30 and 90 days, results.
2. Money first: list the active campaigns with spend and zero results in the period. These are the most urgent. Use only figures from the data; if one is missing, "no data."
3. Inactive: no sends or impressions in the period, old drafts, and scheduled campaigns whose date has already passed.
4. Duplicates: nearly identical names (copy, copy, v2, final, final2) or the same audience, same offer, and same dates. Before treating them as duplicates, rule out A/B tests done on purpose and campaigns split by country or language.
5. Assign an action to each campaign: KEEP, PAUSE, ARCHIVE, or REVIEW WITH A PERSON. If in doubt, REVIEW WITH A PERSON. The DELETE action does not exist.
6. Propose a naming convention along the lines of platform_client_objective_date_version. As a proposal only.
7. With a written "yes," and only if there is a connector with write access: pause or archive in batches of at most [10] and, after each batch, read the status to verify it. Record each change in a log: id, previous status, new status, and date. It can be used to undo changes.
8. Warning: reactivating an ad campaign that has been paused for a while can force the platform to learn again and it may perform differently at first. Note the reason for each pause.

## What to return
- Summary: campaigns reviewed, number per proposed action, and spend over the last 30 days of the campaigns without results, summed from the data.
- Full table, with the campaigns that are spending money at the top.
- Duplicates grouped, with the reason for each group.
- "To review with a person" list, with the specific question that needs answering.
- Undo log, if anything was executed.
- Naming convention proposal.

## What NOT to do
- Do not delete campaigns, lists, audiences, or templates. Pause or archive at most, and with permission.
- Do not touch budgets, bids, audiences, or dates.
- Do not pause a campaign that is currently spending without first notifying whoever is accountable for the budget.
- Do not write off a campaign as useless just because it has no direct sales: brand, awareness, or seasonal campaigns can be valuable.
- Do not mix accounts from different clients in the same table that will later go to another client.
- Do not touch accounts that are not yours without written permission.
- Do not estimate savings with figures from the internet. Only actual spend from the data.

## What a person reviews before using the result
- Whoever is accountable for the budget approves each pause or archive, especially for campaigns with active spend.
- That no campaign marked for archiving is needed for contractual reasons, a pending report, or an upcoming seasonal campaign.
- That the duplicates really are duplicates.
- If lists of subscribed people are involved, that the unsubscribe record is not lost: losing it would make it possible to email someone who asked not to be contacted.

Rules and limits reviewed in October 2026. Check that they are still current before relying on them.
