---
name: montar-coolify-para-clientes-en
description: Use it when someone wants to set up their own deployment server with Coolify for a small business and charge for installing and maintaining it
---

# Set up Coolify for a client

## 1. What it is and who you sell it to
Coolify is a dashboard that is installed on your own server and lets you deploy websites, online shops, databases, and applications in a few clicks, instead of depending on expensive commercial hosting.
It comes with ready-made templates for many well-known services, such as WordPress, and connects to the server over SSH to manage everything from a visual dashboard.
You sell it to businesses that already have or are going to have a website, an online shop, or a simple application and today overpay for shared hosting: a shop with its ecommerce, an academy with its course website, an advisory firm with its corporate website.
The pitch: instead of paying fixed fees to a generic host, they have their own server, cheaper, and you manage it for them.

## 2. First of all: what it requires
You need a server with Docker installed and at least 2 GB of RAM, more the more services run at the same time.
A VPS of that size runs around 10 to 20 euros per month, depending on the provider. This is indicative: check it before quoting anything.
You need SSH access to the server and, for each project you deploy, a domain of its own pointing at that server.

## 3. Setup step by step, first on a test machine
Always try Coolify first on a test server of your own, never directly on the client's production server.
Follow the README of the coollabsio/coolify repository for the exact installation command: it is a single command that is run on the server and that can change from version to version.
After installing it, go into the dashboard, connect your first server (it can be the same one where Coolify is running), and deploy a simple test application there before touching anything of the client's.
Check that automatic deployment works: make a small change in the test project and see that it updates on its own on the server.

## 4. Configuration so the client can use it without calling you
Create a separate user for the client in the Coolify dashboard, with permissions limited to their own projects, and do not give them full administrator access unless they ask for it.
Set up automatic backups of the databases and the important files of each project, with a clear notice of where they are stored.
Document, in a simple document without technical jargon, how to restart their website from the dashboard if something fails on a weekend and you are not available.
Turn on Coolify notifications (by email or similar) so that they warn when a deployment fails, and decide who receives them: you, the client, or both.

## 5. What to charge
For the initial server setup and the first deployment, an indicative range of 200 to 600 euros, depending on how many projects and services have to be configured.
For monthly maintenance, between 30 and 100 euros indicative, which includes: system and Coolify updates, periodic backups, monitoring that the server stays up, and support for incidents.
These prices are indicative: they change according to the area, the number of projects you manage, and the level of support urgency you offer. Adjust them to each case.

## 6. The license: what you can charge for and what you cannot
Coolify has an Apache-2.0 license, a permissive free license without restrictions of this kind. You can do whatever you want with it: install it, modify it, build a hosting business on top of it and sell it, with no obligation to publish anything.
There is no fine print here: charge for it with confidence, both the setup and the monthly maintenance.

## 7. Limits and human review
Do not promise one hundred percent uptime or "it will never go down": no server guarantees that, least of all one managed by a single person.
You will have SSH and administrator access to the server where the website lives and, often, the business's customer data (orders, forms, emails). Talk with the client about who holds the passwords and SSH keys, and what happens if you stop working together.
If the server stores personal data of the business's customers, discuss with them whether a data processing agreement is needed under the GDPR, and have their own advisory firm review it if they have doubts.
Really test the backups by restoring one; do not assume they work just because they have been scheduled.
If the client sells online and handles payments or invoicing, make clear that you manage the server, not the legal or tax side of their shop: their advisory firm reviews that.

## 8. Maintenance
Each month check: pending updates for Coolify and the server's operating system, available disk space, that the backups were made, and that the HTTPS certificates are still valid.
Notify the client with a brief summary: what you updated, whether there is anything that needs their attention (for example, renewing the server or upgrading the plan if resources are tight), and when the next review is due.
