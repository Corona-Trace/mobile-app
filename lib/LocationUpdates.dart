import 'package:corona_trace/network/APIRepository.dart';
import 'package:flutter_background_geolocation/flutter_background_geolocation.dart'
    as bg;

import 'AppConstants.dart';

class LocationUpdates {
  static requestPermissions() async {
    await bg.BackgroundGeolocation.requestPermission();
  }

  static void headlessTask(bg.HeadlessEvent headlessEvent) async {
    print('[BackgroundGeolocation HeadlessTask]: $headlessEvent');
    // Implement a 'case' for only those events you're interested in.
    switch (headlessEvent.name) {
      case bg.Event.TERMINATE:
        bg.State state = headlessEvent.event;
        print('- State: $state');
        break;
      case bg.Event.LOCATION:
        bg.Location location = headlessEvent.event;
        print('- Location: $location');
        await ApiRepository.updateLocationForUserHistory(location);
        break;
      case bg.Event.HTTP:
        bg.HttpEvent response = headlessEvent.event;
        print('HttpEvent: $response');
        break;
    }
  }

  static Future<void> initiateLocationUpdates() async {
    // Fired whenever a location is recorded
    bg.BackgroundGeolocation.registerHeadlessTask(headlessTask);

    bg.BackgroundGeolocation.onLocation((bg.Location location) async {
      await ApiRepository.updateLocationForUserHistory(location);
    }, (error) {});

    var displacement = await ApiRepository.getRemoteConfigValue(
        AppConstants.DISTANCE_DISPLACEMENT_FACTOR);
    await bg.BackgroundGeolocation.ready(bg.Config(
            url: ApiRepository.USER_LOCATION_URL,
            maxBatchSize: 50,
            headers: {"AUTHENTICATION_TOKEN": "23kasdlfkjlksjflkasdZIds"},
            params: {"user_id": 1234},
            extras: {"route_id": 8675309},
            locationsOrderDirection: "DESC",
            maxDaysToPersist: 3,
            desiredAccuracy: bg.Config.DESIRED_ACCURACY_HIGH,
            distanceFilter: displacement != null && displacement.isNotEmpty
                ? double.parse(displacement)
                : 100,
            stopOnTerminate: false,
            allowIdenticalLocations: false,
            startOnBoot: true,
            enableHeadless: true,
            locationAuthorizationAlert: {
              'titleWhenNotEnabled': 'Your location-services are disabled',
              'titleWhenOff': 'Your location-services are disabled',
              'instructions':
                  'Permitting ‘Always-on’ access to your device location is essential to provide critical location-based COVID-19 notifications.',
              'cancelButton': 'Cancel',
              'settingsButton': 'Settings'
            },
            notification: bg.Notification(
                title: "Corona Trace",
                text:
                    "Your location is being tracked, but all data will be anonymous."),
            logLevel: bg.Config.LOG_LEVEL_OFF))
        .then((bg.State state) {
      if (!state.enabled) {
        bg.BackgroundGeolocation.start();
      }
    });
  }
}
