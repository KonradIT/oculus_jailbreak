# oculus_jailbreak
Research on Jailbreaking Oculus Quest 2

## Notes

Extract source from apk:

JEB Android one month license for jeb-android-3.27.0.202011241947
https://www.pnfsoftware.com/jeb/buy

$ ./jeb_macos.sh 
open the APK, note the invalid dex signature may cause headaches with other tools. You can view this on the logging console. 

```
Attempting to merge the multiple DEX files into a single DEX file...
This APK contains multiple DEX files: 2
{Oculus_v65.0.0.2.120_apkpure.com.apk > Oculus_v65.0.0.2.120_apkpure.com.apk > Bytecode}: [DEX #0] Invalid DEX signature (expected=C7 10 88 14 1A 5C E8 1E F4 A9 63 03 DC C8 2E 15 5D CC 2C 8D , actual=D6 C4 2C 1F 40 DF FF 75 27 B1 39 48 77 6C 53 BB B8 84 43 18 )
{Oculus_v65.0.0.2.120_apkpure.com.apk > Oculus_v65.0.0.2.120_apkpure.com.apk > Bytecode}: [DEX #1] Invalid DEX signature (expected=DE EA B9 9C ED F6 65 71 C0 80 BF E8 C8 60 43 86 04 CA 77 5C , actual=A4 65 AF A4 3B 61 52 F5 8E B3 AD DA F2 24 A4 49 60 9F 37 6D )
{Oculus_v65.0.0.2.120_apkpure.com.apk > Oculus_v65.0.0.2.120_apkpure.com.apk}: DEX merger was successful and produced a virtual DEX unit
```

File->Export->Decompiled Code->All

Also be sure to note the various string decriptions as they occur on the logging console

```
Method Lcom/facebook/blescan/BleScanUtils;-><clinit>()V: Decrypted bytes: "FF4C000215"
Method Lcom/facebook/blescan/BleScanUtils;-><clinit>()V: Decrypted bytes: "16AAFE"
Method Lcom/facebook/blescan/BleScanUtils;-><clinit>()V: Decrypted bytes: "17FFAB01"
...
Method Lcom/facebook/common/build/Bit64Mode;->a()Z: Decrypted string: "armv7"
```

Extract hermes bundle:

hermes-cli-darwin-v0.5.0 was used from https://github.com/facebook/hermes/releases
```
$ hermes-cli-darwin-v0.5.0/hbcdump assets/TwilightBundle.js.hbc -out=twilightbundle_hbcdump.txt
disassemble
```
or 

```
$ hermes-cli-darwin-v0.5.0/hermes -b --dump-bytecode assets/TwilightBundle.js.hbc > ~/Desktop/Oculus/twilightbundle_hermes_dump.txt
```

### 

We'd like to first bypass the dev NDA requirement. 
https://developer.oculus.com/distribute/publish-account-management-intro/?locale=en_US
https://developer.oculus.com/manage/organizations/create

More Settings -> Developer Settings -> Developer Mode (toggle)

"Become a Developer"
"Go to ocul.us/StartCreating to register."
"NO THANKS", "START CREATING"

Refrences to enabling ADB can be found in the decompiled TwilightBundle
```
    NewObjectWithBuffer r11, 2, 2, 2619, 3531
    PutNewOwnByIdShort r9, r11, "mode"
    PutNewOwnByIdShort r8, r9, "fields"
    PutNewOwnById     r7, r8, "DevModeRequest"
    NewObject         r8
    NewObject         r9
    NewObjectWithBuffer r11, 2, 2, 2619, 3531
    PutNewOwnByIdShort r9, r11, "status"
    PutNewOwnByIdShort r8, r9, "fields"
    PutNewOwnById     r7, r8, "DevModeResponse"
    NewObject         r8
    NewObject         r9
    NewObjectWithBuffer r11, 3, 3, 2616, 4150
    PutNewOwnById     r9, r11, "enable"
    PutNewOwnByIdShort r8, r9, "fields"
    PutNewOwnById     r7, r8, "AdbModeRequest"
    NewObject         r8
    NewObject         r9
    NewObjectWithBuffer r11, 2, 2, 2619, 3850
    PutNewOwnByIdShort r9, r11, "status"
    PutNewOwnByIdShort r8, r9, "fields"
    PutNewOwnById     r7, r8, "AdbModeResponse"
    NewObject         r8
    NewObject         r9
```

The CompanionServer on the Oculus Quest 2 is responsible for handling this request over Bluetooth BLE. 
You'll find detail in com/oculus/companion/server/Protocol*.java if you decompile CompanionServer. 

We should be able to enable adb mode over BLE using the adb_mode_set() function in https://github.com/QuestEscape/research/blob/master/ble_companion_client.py#L410. 
This tool appears to have been created by reverse engineering the Companion Server. Sadly the pyobjc implementation requires specific versions of OSX+Python

### Myths and Lore

"I’m still offering $5000 for a Quest 2 jailbreak! Jailbreakers, dm me. Let’s break free of FB’s anti-competitive, anti-privacy ecosystem!"
https://twitter.com/arobertlong/status/1316177057085177857?lang=en

"My offer of $5000 to jailbreak the Quest still stands. I’m moving the target to Quest 2 though seeing as Quest 1 is no longer in production."
https://twitter.com/arobertlong/status/1306422159594549248

"Also, if anyone is working on a project to jailbreak the Quest and boot to Oculus Browser or Firefox Reality without a FB login, I will donate $1000 to your project."
https://twitter.com/arobertlong/status/1295791549238788096

"I’ll up my donation from $1000 to $5000 if a project can get around the FB login. I’m 100% serious, someone needs to do this. Start recruiting people from the Android jailbreaking scene."
https://twitter.com/arobertlong/status/1295912254970318848

"At this time I've postponed organizing a crowdfunding campaign. I'm still committed to paying out my bounty and I hope members of the community will as well when we get this figured out."
https://twitter.com/arobertlong/status/1320782261747216384

"Here's the update on the Oculus Quest 2 jailbreak efforts. You can read more at "
https://twitter.com/arobertlong/status/1320782260753199104

"Sources suggest the first reported Oculus Quest 2 jailbreak is almost certainly not real."
https://twitter.com/UploadVR/status/1326933213701345282

### Public firmware sources

"Want the new Quest 2 90hz update now? Skip the wait! Sideload it!"
https://www.reddit.com/r/OculusQuest/comments/jtrrsc/want_the_new_quest_2_90hz_update_now_skip_the/

https://drive.google.com/file/d/1cE-tkpoy7IDY4hfMPbhh6Q4ORZvZ18qr/view
https://drive.google.com/file/d/1DtnQp-Bz2y6OpGghLeRBQqPbnQVeRRxg/view

Payload Dumper can extract the payload.bin within the update files. 
payload_dumper_tool_by_ius.zip - https://drive.google.com/file/d/1QpsywAbNroDKEDz4TytQl8UlK6v2gJSi/view


