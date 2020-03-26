import 'package:background_fetch/background_fetch.dart';
import 'package:corona_trace/network/APIRepository.dart';
import 'package:corona_trace/ui/screens/UserInfoCollectorScreen.dart';
import 'package:flutter_background_geolocation/flutter_background_geolocation.dart'
    as bg;

import 'AppConstants.dart';

class LocationUpdates {
  static scheduleBGTask() async {
    // Step 1:  Configure BackgroundFetch as usual.
    BackgroundFetch.configure(BackgroundFetchConfig(minimumFetchInterval: 15),
        (String taskId) async {
      // This is the fetch-event callback.
      print("[BackgroundFetch] taskId: $taskId");

      // Use a switch statement to route task-handling.
      switch (taskId) {
        case 'com.transistorsoft.locationUpdate':
          print("Received custom task");
          await initiateLocationUpdates();
          break;
        default:
          print("Default fetch task");
      }
      // Finish, providing received taskId.
      BackgroundFetch.finish(taskId);
    });

    // Step 2:  Schedule a custom "oneshot" task "com.transistorsoft.locationUpdate" to execute certain time from now.
    BackgroundFetch.scheduleTask(TaskConfig(
        taskId: "com.transistorsoft.locationUpdate",
        delay: Duration(minutes: 15).inMilliseconds // <-- milliseconds
        ));
  }

  static requestPermissions() async {
    await bg.BackgroundGeolocation.requestPermission();
  }

  static Future<void> initiateLocationUpdates() async {
    // Fired whenever a location is recorded
    bg.BackgroundGeolocation.onLocation((bg.Location location) async {
      print('[location] - $location');
      await ApiRepository.updateLocationForUserHistory(location);
    }, (error) {});

    // Fired whenever the plugin changes motion-state (stationary->moving and vice-versa)
    bg.BackgroundGeolocation.onMotionChange((bg.Location location) async {
      print('[motionchange] - $location');
    });

    // Fired whenever the state of location-services changes.  Always fired at boot
    bg.BackgroundGeolocation.onProviderChange((bg.ProviderChangeEvent event) {
      print('[providerchange] - $event');
    });

    ////
    // 2.  Configure the plugin
    //
    var displacement = await ApiRepository.getRemoteConfigValue(
        AppConstants.DISTANCE_DISPLACEMENT_FACTOR);
    await bg.BackgroundGeolocation.ready(bg.Config(
            desiredAccuracy: bg.Config.DESIRED_ACCURACY_HIGH,
            distanceFilter:
                displacement != null && displacement.isNotEmpty ? double.parse(displacement) : 100,
            stopOnTerminate: false,
            allowIdenticalLocations: false,
            startOnBoot: true,
            debug: true,
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
            logLevel: bg.Config.LOG_LEVEL_VERBOSE))
        .then((bg.State state) {
      if (!state.enabled) {
        bg.BackgroundGeolocation.start();
      }
    });
    await LocationUpdates.scheduleBGTask();
  }
}
