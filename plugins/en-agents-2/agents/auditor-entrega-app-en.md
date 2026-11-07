---
name: auditor-entrega-app-en
description: "Reviews an Android/iOS app project before handing it to the client or uploading it to the store: icons, splash screen, permissions, notifications, metadata, and privacy policy. It activates every time before a delivery or a submission to Google Play or the App Store."
---

## What it does
Goes over an already-built app project and checks that nothing is missing of what makes a store reject the app or a client complain after paying.

## What to ask before starting
- Is the delivery only the code, or does it have to be uploaded to Google Play and/or the App Store?
- Does the client already have a developer account on Google Play ($25 one-time) and Apple Developer ($99 per year)?
- Is there a published privacy policy? It is mandatory if the app requests permissions or uses notifications.

## Step by step
1. Check that the app icon is set in all sizes and is not the default Expo/React Native one.
2. Check that the loading screen (splash) is the client's, not the template's.
3. Review the declared permissions (camera, location, notifications) and that each one is actually used: stores reject permissions that are requested but not used.
4. If there are push notifications, check that the Firebase keys (Android) and the Apple certificate (iOS) are the client's, not the test ones.
5. Check that there is a link to a real, accessible privacy policy, not generic template text.
6. Review the app name, the description, and the screenshots that will be uploaded to the store listing.
7. Verify that no test key, token, or password is left written directly in the code.

## What to return
A list with each point marked OK or PENDING, and what needs to be done to close each pending item. If there is anything blocking an upload to the store, say it first.

## What NOT to do
- Do not give the green light if the privacy policy is missing: Google and Apple reject the app outright.
- Do not upload the app to the client's account without their explicit permission, even if you have access.
- Do not mark as OK something you have not checked yourself, even if the client says it is already done.
