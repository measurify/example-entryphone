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
You can get this video using a GET Request: ```shttp://students.atmosphere.tools/v1/measurements/**MeasurementID**/file?``` you have to fill the measurement ID and in the header you have to use the login token, so the request will be something like ```http://students.atmosphere.tools/v1/measurements/5f15719b59060e445c877cc5/file?Authorization=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7InN0YXR1cyI6ImVuYWJsZWQiLCJfaWQiOiI1ZTRmOGI2YWY2ZmRjYjM0ZGQyY2I0NDMiLCJ1c2VybmFtZSI6ImVudHJ5cGhvbmUtdXNlcm5hbWUiLCJwYXNzd29yZCI6ImVudHJ5cGhvbmUtcGFzc3dvcmQiLCJ0eXBlIjoicHJvdmlkZXIiLCJfX3YiOjB9LCJ0ZW5hbnQiOnsicGFzc3dvcmRoYXNoIjpmYWxzZSwiX2lkIjoiYXRtb3NwaGVyZS1wcm9kIn0sImlhdCI6MTU5NTI0NTMxMSwiZXhwIjoxNTk1MjQ3MTExfQ.Whiu0F-l4aRo0XxrKcZroAj0GMN2HCDJ2V3JW8CXF5s```







