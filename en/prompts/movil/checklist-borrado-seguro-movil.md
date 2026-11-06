# Secure Erase Checklist Before Selling Your Phone

**Type:** Prompt · **Area:** Mobile · **License:** CC BY 4.0 · [Spanish original](../../../prompts/movil/checklist-borrado-seguro-movil.md)

Prompt that produces the exact order of steps to sell, give away or recycle a phone with no recoverable data, based on its model, OS and accounts.

## What it is and what it does

Prompt that generates, from your phone's exact details, the order of steps to sell, give away, or recycle it without leaving recoverable data. Input: the model, the operating system, whether it has an SD card, the active accounts, and where the device is going; output: an ordered sequence: prior backup, signing out, unlinking accounts, and erasing. Paste it into any chat AI, no programming needed, and a technician can use it when handing over a second-hand phone.

## The prompt (copy it whole)

```text
I am going to [SELL / GIVE AWAY / RECYCLE] my phone and I want to leave it without any of my data, so that no one can recover anything even if they use data recovery tools.

This is my phone's information:
- Model: [PHONE MODEL]
- Operating system and version: [ANDROID OR IOS AND VERSION]
- Has an SD card: [YES / NO]
- Has a physical SIM card: [YES / NO]
- Active accounts on the phone: [GOOGLE, APPLE ID, WHATSAPP, BANKS, EMAIL, ETC.]
- I am going to hand it over to: [A STRANGER THROUGH A SECOND-HAND MARKETPLACE / SOMEONE I KNOW / A RECYCLING POINT]
- I want to keep a copy of the photos and data before erasing: [YES / NO]

Give me the step by step in the exact order in which I have to do it, not a disorganized list. It must include, if it applies to my case:
1. How to back up what I want to keep before touching anything.
2. How to sign out of each account (Google, Apple ID, WhatsApp, banks, email) before resetting, and why the order matters.
3. How to disable activation lock (Find My iPhone or Google's Factory Reset Protection), so that the new owner can use the phone and I am not asked for my password if it ever comes back to me.
4. How to physically remove the SIM card and the SD card, and what to do with each one.
5. How to do the factory reset, encrypting first if the phone is old and does not come encrypted by default.
6. How to check, after resetting, that the phone asks to be set up as new and does not ask for any account of mine.

Also tell me what happens if I skip any of these steps: what specific piece of data would be exposed and what someone could do with it.
```
