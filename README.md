# Design and development of an embedded device for remote control

## Overview

This project is based on the nedd to have a smart entryphone, the user receieves a notification when someone rings the bell, he can watch the video stream of the camera located at the phisical device and he could open the door.
The Android application, named Mike, uses an IoT Framework called [**Measurify**](https://measurify.org/) (previously known as *Atmosphere*) in order to communicate with the phisical device.

## Hardware

We didn't really designed the hardware device, we thought to use a  [**Raspberry PI 4 Mod. B**](https://www.raspberrypi.org/products/raspberry-pi-4-model-b/), but it is excessive for our use, so we could find a MicroControllor suitable for this project.
## Software

We developed the Android Application named **Mike**, we used a framework named [**Flutter**](https://flutter.dev), developed by Google, we implemented the push notification service using [Google Firebase](https://firebase.google.com/).

## Simulation of the hardware
To simulate the hardware device you can use the webpage, named ```server.html```, in the edge folder. The start recording button equivalent to the button to ring the bell.
After you click this button, a new measurement is created on Measurify, and every 3 seconds the video is attached at the measurement.
You can get this video using a GET Request: 
```shttp://students.atmosphere.tools/v1/measurements/MeasurementID/file?``` 
you have to fill the measurement ID and in the header you have to use the login token, so the request will be something like 
```http://students.atmosphere.tools/v1/measurements/5f15719b59060e445c877cc5/file?Authorization=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7InN0YXR1cyI6ImVuYWJsZWQiLCJfaWQiOiI1ZTRmOGI2YWY2ZmRjYjM0ZGQyY2I0NDMiLCJ1c2VybmFtZSI6ImVudHJ5cGhvbmUtdXNlcm5hbWUiLCJwYXNzd29yZCI6ImVudHJ5cGhvbmUtcGFzc3dvcmQiLCJ0eXBlIjoicHJvdmlkZXIiLCJfX3YiOjB9LCJ0ZW5hbnQiOnsicGFzc3dvcmRoYXNoIjpmYWxzZSwiX2lkIjoiYXRtb3NwaGVyZS1wcm9kIn0sImlhdCI6MTU5NTI0NTMxMSwiZXhwIjoxNTk1MjQ3MTExfQ.Whiu0F-l4aRo0XxrKcZroAj0GMN2HCDJ2V3JW8CXF5s```

At the moment Mike doesn't get the measurement ID automatically, you have to edit the code on ```dashboard_screen.dart``` on line 84.

## Open the door
We implemented the code to run this feature, when you press this button, Mike posts a new measurement on 
      "thing": "lock",
      "feature": "entry",
      "device": "door-opener"
so your device should listen to new measurement on this Measurify's device and open the lock when a new measurement is posted.

## QUICK START
In order to run Mike, you have to right-click on the client folder, click on "Open with Code".
At this point you have to open the command line and execute ```flutter pub get```, Code will install all packages needed by Mike written in the pubspec.yaml .
Now you can run an Android Emulator or connect an Android device with Debug Mode enabled and run the command ```flutter run``` in Code's command line.
If you want to deploy the APK you can visit [this link](https://flutter.dev/docs/deployment/android).

The ```server.html``` posts the new measurement with the video attached, but at the moment Mike doesn't get the measurement's ID automatically, we thought two different ways to handle with this problem:
      1. Mike will read the last notification and use that ID
      2. Mike makes a GET request to Measurify and use the last Measurement posted by the entryphone device
   
We started to develop the second way, in ```lib\services\networking.dart``` you can find our **getMeasurementID** class.



