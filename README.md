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
    * Some sounds are played by this flutter plugin as debug but can be stripped off in relase builds.
    * You are free to use any other plugin for background location.
