# Alert for Asset Licenses About to Expire

**Type:** Automation recipe · **Area:** Games & 3D · **License:** CC BY 4.0 · [Spanish original](../../../recetas/n8n/juegos/n8n-aviso-caducidad-licencias-assets.md)

n8n workflow that checks a spreadsheet of temporary asset licenses weekly and alerts via Telegram or email before they expire.

## What it is and what it does

An n8n flow that reads a Google Sheets sheet with the temporary licenses of each asset (name, license type, expiration date, and owner), calculates the days remaining, and sends an alert by Telegram or Gmail only when something expires in less than 30 days. It runs with a weekly Schedule Trigger and works on self-hosted n8n or n8n Cloud. Example: music with an annual license that expires in 20 days generates an alert on Monday. Used in video game studios or any team that depends on assets with limited licenses.

## The recipe, step by step

# Alert for asset licenses about to expire

Keep in a spreadsheet every asset with a temporary license (music with an annual license, plugins with a subscription, rented assets) and this automation alerts you before it expires, so you don't find out when it has already expired and the game has been published with an unlicensed asset.

## Accounts needed
- Google account with Google Sheets (free).
- n8n (free self-hosted, or n8n Cloud with a free trial plan and paid afterward).
- A Telegram account or an email (Gmail) to receive the alert; both free.

## Nodes, in order
1. Trigger: Schedule Trigger, set to run once a week (for example, Monday at 9:00).
2. Google Sheets ("Get rows" node): reads the "licencias_assets" sheet with the columns nombre_asset, tipo_licencia, fecha_caducidad, responsable.
3. Function or Code: calculates the days remaining until fecha_caducidad for each row and filters those that expire in less than 30 days.
4. IF: if the result of the previous step is not empty, continue; if it is empty, end the flow without doing anything.
5. Telegram ("Send Message" node) or Gmail ("Send Email" node): sends the list of assets about to expire, with name, date, and owner.

## How to test it without messing up
1. Before activating it, create a test row in the sheet with an expiration date 10 days from now.
2. Run the flow manually from n8n ("Execute Workflow" button) instead of waiting for the Schedule Trigger.
3. Check that the alert arrives on Telegram or by email with the correct data from that test row.
4. Only after seeing it work with test data, activate the Schedule Trigger and delete the test row.
5. Check every few months that the sheet still has all the assets with temporary licenses: the automation only alerts about what is recorded, it doesn't discover new assets on its own.
