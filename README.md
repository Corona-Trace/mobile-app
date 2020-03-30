![Corona Tracker App](CoronaTrackerAppHeader.png)

# CoronaTracker App

CoronaTracker App is written in Flutter and can be built to run on Android and iOS. 

It uses the device's current location to provide critical location-based push notifications related to COVID-19.


## About the App

As of now, when coupled with the CoronaTracker Firebase backend, the app anonymously shares your location data and allows push notifications to be received for all the users of this app who have visited the locations that an infected person visited in the past 7 days. An infected person can confirm an infection in the app, which will alert other users to take precautionary steps.


## Requirements

1. A Firebase project.
    * Setup Firebase push notifications.
    * Setup Firebase Remote Config.
    * Create signing config for debug and release projects and add the SHA-1 to Firebase dashboard.
    * Add Apple Push Notification
    * Add GoogleServices.json and GoogleServices-Info.plist to Android and iOS projects respectively.
2. The App uses multiple Flutter plugins.
    * The `background_geolocator_flutter` plugin needs a license to be purchased in case of a release builds.
    * Some sounds are played by this Flutter plugin as debug, but can be stripped off in release builds.
    * You are free to use any other plugin for background location.

# How To Contribute
This project uses Firebase and therefore relies on a `google-services.json` configuration file. This file is not included in this repo and every contributor is encouraged to generate their own.

When importing the project in Android Studio the build task will fail with the following error:

`org.gradle.api.GradleException: File google-services.json is missing. The Google Services Plugin cannot function without it.`

Or something similar depending on the Android Studio version you're using.

In order to generate a `google-services.json` configuration file follow these steps (Note: requires a Google account):

- Open the [Firebase Console](https://console.firebase.google.com/).
- Login with your Google account.
- Create a new project (name doesn't matter).
- Select "_Add Firebase to your Android app_".
- Provide package name:  `org.coronatrace.mobile`.
- Register app.
- Download `google-services.json` file.
- Follow instructions to add file to project.
- Skip "_Add Firebase SDK step_".
- Run app to verify that the configuration is picked up correctly.