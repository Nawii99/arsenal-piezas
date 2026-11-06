---
name: auditor-secretos-dependencias-en
description: Reviews a repository or your own website looking for leaked secrets, outdated dependencies, and missing security headers, and returns a prioritized fix plan.
---

## What it does

Reviews code and configuration that are yours or belong to a client who has asked you in writing. It looks for three things that always slip in: keys placed in the code, old libraries with known flaws, and security headers that nobody configured.

Read and analysis only. It does not test attacks, does not touch third-party systems, and does not try to get into anything.

## What to ask beforehand

1. Do you have written permission from the owner of the code and the website? If the answer is not a clear yes, stop here.
2. What is in the project: repository, published website, both.
3. What technology it uses and how it is deployed.
4. Is there personal data involved (customers, employees, patients).
5. Who is going to apply the fixes and with how much time.

## Step by step

1. First see whether a .gitignore exists and whether it covers .env, credentials, database copies, and local configuration folders.
2. Look for secrets in the working tree: strings like api_key, secret, token, password, private_key, keys starting with sk- or AKIA, and URLs with a username and password inside.
3. Also search the git history, not just the latest version. Deleting a file does not delete what was already pushed.
4. Review the dependency file and flag those with published known flaws. Separate what is fixed with a minor update from what breaks things.
5. Check whether the project pins versions or accepts anything new. Accepting anything is how a tampered library gets slipped in.
6. If there is a published website, look at the response headers: Content-Security-Policy, Strict-Transport-Security, X-Content-Type-Options, X-Frame-Options, Referrer-Policy. Note which are missing.
7. Go over the OWASP basics in forms: server-side validation and not only in the browser, parameterized queries, escaping what the user types before rendering it, and checking that each user only sees their own data.
8. Check that session cookies carry HttpOnly, Secure, and SameSite.
9. Order everything by real damage if exploited, not by how easy it is to fix.

## What to return

- Findings table: what it is, where it is (file and line), what would happen if someone exploits it, how to fix it.
- Three levels: fix today, this week, when possible.
- For each secret found: the steps are to revoke and regenerate the key first, change the code afterwards, and clean the history last. In that order, because a pushed key is already considered burned.
- List of dependency updates with the specific version and whether it breaks compatibility.
- Header configuration block ready to copy, with a warning to test it first in a test environment because a poorly set Content-Security-Policy brings the website down.

## What NOT to do

- Do not review systems that do not belong to the client who hires you.
- Do not launch active scans, penetration tests, or attack tools. Without a contract and a signed scope, that is illegal in Spain.
- Do not paste the full keys found in the report. Put the first four characters and where they are.
- Do not upload the client's code to external services for analysis without their permission.
- Do not declare the website secure. Here you state that it has been looked at and that it has not.

## Limits and when a person is needed

This is a surface-level review. It finds what can be seen by reading the code. It does not find business-logic flaws, infrastructure problems, or whether someone is already inside.

A security professional is needed if: the application handles payments or health data, there are signs that unauthorized access has already occurred, the client needs an audit valid for compliance or insurance, or there is personal data of many people. In that case, your job is to hand over the findings and state clearly that a formal audit is needed.
