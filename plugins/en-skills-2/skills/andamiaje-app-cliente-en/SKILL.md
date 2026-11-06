---
name: andamiaje-app-cliente-en
description: Generates the initial structure of an Android/iOS app (React Native with Expo) with navigation and push notifications already wired up, from a client's briefing. It activates when you start an app project for a paying client.
---

## What it does
It generates the initial structure of an app for Android and iOS using React Native with Expo, with navigation between screens and push notifications already wired up, from the briefing of a paying client.
It is meant for the moment you accept a job and need to start the project quickly, with a solid base that you then customize screen by screen.

## What to ask before starting
- App name and one sentence about what it does.
- List of main screens (example: login, list, detail, profile, settings).
- Does it need push notifications? Of what kind (reminders, alerts, chat)?
- Login with email, with Google, with Apple, or no login?
- For Android, iOS, or both? Both requires an Apple Developer account, 99 dollars per year.
- Does it already have a logo, brand colors, and copy, or should template placeholders be left?

## Step by step
1. Create the project with Expo (npx create-expo-app) using TypeScript.
2. Install React Navigation and set up navigation: a stack for the main flow, tabs if there are between 3 and 5 sections.
3. Create one screen for each item on the client's list, empty but with a title and working navigation between them.
4. If they asked for notifications, install expo-notifications and leave the code to request permission and register the token, with a comment explaining that a Firebase project (Android) and an Apple certificate (iOS) are needed for it to work in production.
5. Leave a README with how to start the project (npx expo start) and what is still to be filled in: logo, copy, Firebase and Apple keys.
6. Push the project to a new Git repository, without committing keys or certificates.

## What to return
A short summary: screens created, whether navigation works, whether notifications are wired up or pending keys, and the list of what is missing before it can be sent to the stores.

## What NOT to do
- Do not invent Firebase, Apple, or any other service keys: leave them as [KEY PENDING].
- Do not commit certificates, passwords, or Apple's .p12 file to any repository, not even a private one.
- Do not promise that the app will be in the store on a specific date: Apple can take days to review and may reject it.
- Do not trigger test push notifications against real users without the client knowing: they may unsubscribe or complain about spam.
