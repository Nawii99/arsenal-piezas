# Planning a Homemade Surveillance Camera with the ESP32-CAM

**Type:** Prompt · **Area:** IoT & hardware · **License:** CC BY 4.0 · [Spanish original](../../../prompts/iot/prompt-camara-vigilancia-esp32-cam.md)

Prompt that plans a DIY ESP32-CAM home camera for a beginner: parts, setup, secure phone access and what Spanish law allows recording.

## What it is and what it does

A prompt that plans a homemade surveillance camera with an ESP32-CAM for someone with no experience: what to buy, how to assemble it, secure access from your phone, and what the law in Spain allows you to record. Input: the place to monitor and the environment; output: a step-by-step plan in short sentences. Used with any AI.

## The prompt (copy it whole)

```text
I want to build a homemade surveillance camera with an ESP32-CAM board and I have never done anything with boards or programming. I live in Spain. Act as a technician who teaches beginners and guide me with short sentences, taking nothing for granted.

My situation:
- I want to monitor: [WHAT, E.G. THE ENTRANCE OF MY APARTMENT / THE STORAGE ROOM / THE TERRACE]
- The location is: [INDOORS / COVERED OUTDOORS / OUTDOORS EXPOSED TO THE WEATHER]
- The camera would also see: [NOTHING ELSE / THE BUILDING'S COMMON HALLWAY / THE STREET / THE NEIGHBOR'S GARDEN]
- I want to watch it from: [MY ANDROID PHONE AT HOME / ALSO AWAY FROM HOME]
- Computer: [WINDOWS / MAC / LINUX]
- I want to record or just watch live: [LIVE ONLY / SAVE PHOTOS WHEN THERE IS MOTION / RECORD VIDEO]
- Approximate budget: [AMOUNT IN EUROS]

Give me this, in this order:

1. First of all, the legal part in Spain, in five lines at most. Tell me what I can record and what I cannot according to what I marked above: if the camera sees common areas of the building, public roads, or a neighbor's property, explain what obligation I have (approval from the owners' association, informational sign, not capturing more public road than strictly necessary) and refer me to the AEPD's video surveillance guide for the details. If what I marked cannot be done legally, say so before continuing and suggest how to reposition the camera.

2. Shopping list with the exact names to search for in a Spanish store. I want to know whether I need the ESP32-CAM-MB base board (with USB included) or a separate USB-TTL adapter, and why. Warn me that the ESP32-CAM needs a 5 V power supply with enough current and that with a weak charger it reboots by itself. Do not make up prices: put [check] where you don't know.

3. Step by step to upload the CameraWebServer example program from the Arduino IDE: which board to choose (AI Thinker ESP32-CAM), which line of code to change for my model, where to put the WiFi (2.4 GHz only), what to do if it gets stuck on "Connecting," and how to find the camera's IP from the Serial Monitor.

4. How to watch it from the Android phone at home: the address I have to open in the browser and what each option on the camera's page means. Tell me what resolution to set so it doesn't stutter.

5. If I marked that I want to watch it away from home: explain to me why I should NOT open the port on the router (the image travels unencrypted and anyone who finds the IP can look), and how to do it with a simple VPN such as Tailscale or WireGuard installed on a PC or Raspberry Pi at home and on the phone. If I did not mark watching it away from home, skip this point.

6. If I marked saving photos on motion: propose the simplest way, which is for the camera to notify n8n by webhook and for n8n to request the photo from `http://IP_CAMARA/capture` and send it to Telegram. Do not suggest setting up a recording server yet.

7. Real limits of this setup, no frills: image quality, that it doesn't see at night without light, that if the power or WiFi goes out there is no camera, and that it does not replace a professional system nor serve as reliable evidence for an insurer.

8. What NOT to do: a list of six typical beginner mistakes with the ESP32-CAM (weak power supply, antenna covered with a finger or the case, leaving the default password, pointing at the street, exposing the port to the internet, uploading the code with the WiFi password to GitHub).

Rules: do not use technical words without explaining them in the same sentence. If you don't know something or it depends on the exact model, put it in brackets instead of making it up. If what I ask is not legal or not safe, tell me first and clearly, even if the rest of the plan is put on hold.
```
