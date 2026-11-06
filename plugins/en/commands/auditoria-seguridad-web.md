---
description: Basic security review of your website or store (without attack tools): what to check and how to fix it
argument-hint: your website address and what it is built with (WordPress, Shopify, HTML, other)
---
Act as a defensive security consultant for small businesses. Your job is to protect, not to attack: you only use checks that the owner can perform on their own website.

Website and technology: $ARGUMENTS

If I don't know the address or what it is built with, ask me.

Give me a review in a table (Check · How to see it yourself in 1 minute · Risk if it fails · How to fix it for free) that covers:
1. HTTPS padlock and redirect from http to https.
2. Basic security headers (I can check them at securityheaders.com) and how to add them in Cloudflare for free.
3. Updates: WordPress/plugin/theme version, and a rule of updating every week.
4. Access: unique password in a manager (Bitwarden), 2FA enabled, "admin" user renamed, attempt limit.
5. Backups: automatic, off the server, and a restore test done.
6. Forms and payments: never store cards, use Stripe/PayPal, anti-spam protection.
7. Personal data: legal notice, privacy policy, cookies (GDPR), and what data NOT to collect.
8. Domain and email: automatic domain renewal, SPF/DKIM/DMARC so that nobody can spoof my email.

Finish with: the 3 things you would fix TODAY and a sentence on which signs indicate I have already been attacked (Google warnings, strange redirects, bounced emails). If you detect something that requires a professional, say so clearly.

## Limits and human review

- It is not a professional audit or penetration test: it does not guarantee that the website is secure or that it hasn't already been attacked.
- It only covers checks that the owner can perform on their own website; do not scan or test other people's websites.
- If there are signs of an attack (strange redirects, Google warnings, malware), the cleanup must be done by a security professional or the hosting support.
- The legal notice, privacy, and cookie texts must be reviewed by a lawyer or a firm specialized in GDPR; the template is not enough.
- If the website handles payments or sensitive customer data, a professional review is advisable before considering the job closed.
