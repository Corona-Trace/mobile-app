import 'dart:io';

import 'package:corona_trace/analytics/CTAnalyticsManager.dart';
import 'package:corona_trace/location_updates.dart';
import 'package:corona_trace/ui/base_state.dart';
import 'package:corona_trace/ui_return_safe_demo/onboarding/onboarding_testing_contact_tracing.dart';
import 'package:corona_trace/ui_v1_1/notification_location/onboarding_location_permission.dart';
import 'package:corona_trace/ui_v1_1/notification_location/onboarding_notification_permission.dart';
import 'package:corona_trace/utils/app_localization.dart';
import 'package:corona_trace/utils/app_surveys.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class OnboardingPhysicalDistanceAlerts extends StatefulWidget {
  @override
  OnboardingPhysicalDistanceAlertsState createState() => OnboardingPhysicalDistanceAlertsState();
}

class OnboardingPhysicalDistanceAlertsState
    extends BaseState<OnboardingPhysicalDistanceAlerts> {
  
  @override
  String screenName() {
    return "onboarding_physical_distance";
  }
  
  @override
  Widget prepareWidget(BuildContext context) {
    return SafeArea(
      child: Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  color: Color.fromRGBO(237, 239, 254, 0.4),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: 0,
                      ),
                      Align(
                        child: Image(
                          image: AssetImage(
                            "assets/images/onboarding_physical_distancing_alerts.png",
                          ),
                        ),
                        alignment: Alignment.center,
                      ),
                      SizedBox(
                        height: 0,
                      )
                    ]
                  )
                ),
              ],
            ),
          ),
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  AppLocalization.text("physical.distance.alerts.title"),
                  style: TextStyle(
                      fontSize: 28,
                      color: Color(0xff1A1D4A),
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(AppLocalization.text("physical.distance.alerts.description"),
                    style: TextStyle(fontSize: 17))
              ],
            ),
            margin: EdgeInsets.all(20),
          ),
          Container(
            child: Material(
              child: MaterialButton(
                height: 50,
                minWidth: MediaQuery.of(context).size.width * 0.85,
                color: Color(0xff379FFF),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8))),
                child: Text(
                  AppLocalization.text(
                    "Allow.Bluetooth",
                  ),
                  style: TextStyle(color: Colors.white, fontSize: 17),
                ),
                onPressed: () {
                  onPressedBtnAllowLocation(context);
                },
              ),
            ),
            margin: EdgeInsets.only(bottom: 20),
          ),
        ],
      ),
    )));
  }

  Future onPressedBtnAllowLocation(BuildContext context) async {
    navigateLocationPermission(context);
  }

  void navigateLocationPermission(BuildContext context) {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => OnboardingTestingContactTracing()),
        (route) => false);
  }
}
