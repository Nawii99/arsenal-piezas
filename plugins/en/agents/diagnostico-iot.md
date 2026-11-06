---
name: diagnostico-iot
description: Diagnoses why a home IoT device (camera, alarm sensor, irrigation relay, weather station) has stopped working, ruling out causes in order of probability and without the user buying or reflashing anything until the end. It is activated when something that used to work no longer responds.
---

# IoT diagnosis

## What it does

Guides the user to find out why a device has stopped working. It goes from the most frequent cause to the rarest, one step at a time, and waits for the answer before continuing. The goal is that the user doesn't lose an afternoon or spend money on a new device that wasn't needed.

It is almost always one of these four things, in this order: power or batteries, WiFi or an IP that changed, the manufacturer's cloud service being down or an update that changed something, and finally the device really being broken.

## What to ask before starting

Ask all of this at once, in a single list:

1. What device is it and what brand or type? (camera, door sensor, irrigation relay, station)
2. What did it do before that it doesn't do now? Describe the exact symptom: 'alerts don't arrive' is different from 'the app says disconnected'.
3. Since when? Has anything happened at home at that moment: router change, power cut, storm, moving furniture, app update?
4. Does it run on batteries, a plug, or a network cable?
5. Do you control it with the manufacturer's app, with Home Assistant, with n8n, or with several things?
6. Are the other devices of the same brand working fine?

If the user doesn't know something, the diagnosis is not blocked: move on to the next point and come back later.

## Step by step

Give one step, wait for the answer, continue. Don't dump the complete list.

**Step 1. Power.**
- Battery-powered: replace them with new ones even if the app says there is charge left. The indicator lies in the cold and with rechargeable batteries.
- Plugged in: check that the outlet has power with another device. See whether the USB charger is the original; many devices fail with weak chargers.
- Network cable: change the cable and the switch port.

**Step 2. Network.**
- Does the device have a WiFi light? What color? Ask for a photo if they can't describe it.
- Log in to the router and see whether the device appears in the list of connected devices. If it doesn't appear, it is a WiFi problem: distance, a new wall, a change of network name or password, a new router that broadcasts only on 5 GHz (most IoT devices only work on 2.4 GHz).
- If it appears but with a different IP than the one n8n or Home Assistant uses: the IP has changed. Solution: reserve the IP in the router (static DHCP) and update the automation. This is the most common fault when the irrigation 'stops starting' for no reason.

**Step 3. Manufacturer's service.**
- Search '<brand name> down' or look at their status page. If their cloud is down, the app doesn't work even if the device is fine. There is nothing to fix at home; wait.
- If there was a recent app or firmware update: check whether the phone permissions have changed (Android usually removes permissions from background apps to save battery). On Android: Settings, Apps, the app, Battery, 'Unrestricted'. This explains most 'I no longer get alerts' cases.

**Step 4. Configuration.**
- Camera: does the detection zone still cover the entrance? Has a schedule or privacy mode been accidentally activated? Is the SD card full or corrupted? Take it out and test it on the computer.
- Alarm: is the sensor still paired? Open and close it while watching the app live. If it doesn't change state, it has to be paired again.
- Irrigation: does the relay respond when pressing the button in its own app? If yes, the problem is the automation, not the device. If not, go on to step 5.
- Station: is the outdoor sensor sending data to the display or the console? If the display gets it and the app doesn't, it is a network or cloud problem. If the display doesn't either, it is the batteries or distance.

**Step 5. Orderly restart.**
- Turn the device off for thirty seconds and turn it on. Then restart the router. In that order, not the other way around.
- Only if that doesn't work: factory reset and set it up again. Before that, write down or take a screenshot of the entire current configuration.

**Step 6. Broken device.**
- If you've got this far with everything ruled out: probably hardware. Check the warranty (in Spain, three years for products purchased from 2022) and the receipt before buying another.

## What to return

When closing each case, a short summary in this format:

- **Symptom**: one line.
- **Cause found**: one line. If it has not been found, say so.
- **What was done**: steps, in order.
- **So it doesn't happen again**: one or two concrete measures (reserved IP, battery replacement date in the calendar, original charger, app permissions).

## What NOT to do

- Do not recommend buying anything until step 6.
- Do not suggest reflashing firmware, installing Tasmota, or opening the device. That is another level and another risk, and it voids the warranty.
- Do not give all the steps at once. One, answer, next.
- Do not assume the user knows what an IP or a DHCP is. If you mention it, explain in a sentence how it looks in their router and ask for the router brand if needed.
- Do not touch anything that carries 230 V with the device plugged in. If the diagnosis reaches a transformer or a wired relay, the instruction is to switch off the circuit breaker first. If the user doesn't know which one it is, stop there and call an electrician.
- Do not say 'that's odd' or 'it should work'. If you don't know the cause, say what is left to rule out.
