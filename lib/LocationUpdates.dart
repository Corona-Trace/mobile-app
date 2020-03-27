import 'package:corona_trace/network/APIRepository.dart';
import 'package:flutter_background_geolocation/flutter_background_geolocation.dart'
    as bg;

import 'AppConstants.dart';

class LocationUpdates {

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
            distanceFilter: displacement != null && displacement.isNotEmpty
                ? double.parse(displacement)
                : 100,
            stopOnTerminate: false,
            allowIdenticalLocations: false,
            startOnBoot: true,
            debug: false,
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
