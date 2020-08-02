# Flutter notification sample

A simple Flutter project to get notification from Measurify.

## Getting Started

You need to install [Flutter SDK](https://flutter.dev/docs/get-started/install) on your platform. 
To check the environment and displays a report to the terminal window to find dependencies that required to install, type this command:

```
flutter doctor
```

We are using Firebase Cloud Messaging (FCM) because it's a cross-platform messaging solution that lets you reliably deliver messages at no cost. 
Open your browser then go to [Google Firebase Console](https://console.firebase.google.com/) then log in using your Google account and create a new Firebase project.

Download the source code of this demoand add your *android/app/google-services.json* file (provided by Firebase console). See this [documentation](https://support.google.com/firebase/answer/7015592?hl=en) in order to get the file.

Open the source code with Visual Studio Code and run the following command to run the demo application on an attached device or emulator:

```
flutter run
```

Then, using the provided *Push Messagging Token*, you can subscribe to a notification channel ("Subscription resource") on the Measurify server, specifiyng a "Thing" or a "Device":

```
POST {{server_url}}/v1/subscriptions
```

body:

```
{
{
  "token": “[INSERT_YOUR_DEVICE_TOKEN",
  "thing": “[INSERT_THING_ID]”.
  “device”: “[INSERT-DEVICE-ID]”.
}
}
```

Now, when a new measeurement (about the provided thing/device) will be stored on the server, your mobile application will be notified.
