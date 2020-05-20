import 'dart:io';

import 'package:corona_trace/analytics/CTAnalyticsManager.dart';
import 'package:corona_trace/location_updates.dart';
import 'package:corona_trace/ui/base_state.dart';
import 'package:corona_trace/ui_return_safe_demo/onboarding/onboarding_notification_permission.dart';
import 'package:corona_trace/utils/app_localization.dart';
import 'package:corona_trace/utils/app_surveys.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class OnboardingTestingContactTracing extends StatefulWidget {
  @override
  OnboardingTestingContactTracingState createState() => OnboardingTestingContactTracingState();
}

class OnboardingTestingContactTracingState
    extends BaseState<OnboardingTestingContactTracing> {
  
  @override
  String screenName() {
    return "onboarding_testing_contact_tracing";
  }
  
  @override
  Widget prepareWidget(BuildContext context) {
    return SafeArea(
      child: Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      body: Column(
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
                        height: 70,
                      ),
                      Align(
                        child: Image(
                          image: AssetImage(
                            "assets/images/onboarding_testing.png",
                          ),
                        ),
                        alignment: Alignment.center,
                      ),
                      SizedBox(
                        height: 50,
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
                  AppLocalization.text("testing.contact.tracing.title"),
                  style: TextStyle(
                      fontSize: 28,
                      color: Color(0xff1A1D4A),
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(AppLocalization.text("testing.contact.tracing.description"),
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
                    "onboarding.permissions.location.button",
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
    ));
  }

  Future onPressedBtnAllowLocation(BuildContext context) async {
    try {
      await LocationUpdates.requestPermissions();
      var denied =
          await LocationUpdates.arePermissionsDenied();
      if (denied) {
        onPermissionsDenied(context);
      } else {
        await onPremissionAvailable(context);
        await CTAnalyticsManager.instance.logPermissionsGranted();
      }
    } catch (ex) {
      onPermissionsDenied(context);
    }
  }

  void onPermissionsDenied(BuildContext context) {
    LocationUpdates
        .showLocationPermissionsNotAvailableDialog(
            context);
    AppSurveys.triggerRejectedPermissionsSurvey();
  }

  Future onPremissionAvailable(BuildContext context) async {
    showLoadingDialog(tapDismiss: false);
    hideLoadingDialog();
    navigateNotificationPermission(context);
  }

  void navigateNotificationPermission(BuildContext context) {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => OnboardingNotificationPermission()),
        (route) => false);
  }

  Future<bool> showDialogForLocation() {
    if (Platform.isIOS) {
      return showCupertinoDialog(
          context: context,
          builder: (BuildContext contextDialog) {
            return CupertinoAlertDialog(
              title: Text(
                AppLocalization.text("let.coronatrace.access"),
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              content: Text(AppLocalization.text("this.helps.us.spread")),
              actions: <Widget>[
                CupertinoDialogAction(
                  child: Text(AppLocalization.text("not.now")),
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                ),
                CupertinoDialogAction(
                  child: Text(AppLocalization.text("give.access")),
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                ),
              ],
            );
          });
    } else {
      return showDialog<bool>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext contextDialog) {
          return AlertDialog(
            title: Text(
              AppLocalization.text("let.coronatrace.access"),
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            content: Text(AppLocalization.text("this.helps.us.spread")),
            actions: <Widget>[
              FlatButton(
                child: Text(AppLocalization.text("not.now")),
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
              ),
              FlatButton(
                child: Text(AppLocalization.text("give.access")),
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
              ),
            ],
          );
        },
      );
    }
  }
}
