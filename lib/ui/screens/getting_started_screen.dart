import 'dart:io';

import 'package:corona_trace/analytics/CTAnalyticsManager.dart';
import 'package:corona_trace/location_updates.dart';
import 'package:corona_trace/network/api_repository.dart';
import 'package:corona_trace/service/push_notifications/push_notifications.dart';
import 'package:corona_trace/ui/base_state.dart';
import 'package:corona_trace/ui/screens/onboarding.dart';
import 'package:corona_trace/ui/screens/user_info_collector_screen.dart';
import 'package:corona_trace/utils/app_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GettingStarted extends StatefulWidget {
  @override
  _GettingStartedState createState() => _GettingStartedState();
}

class _GettingStartedState extends BaseState<GettingStarted> {

  @override
  String screenName() {
    return "screen_getting_started";
  }

  @override
  Widget prepareWidget(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Color(0xFF2c3054),
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height * 0.85),
            child: Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        AppLocalization.text("GettingStarted"),
                        style: kMainTitleStyle,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        AppLocalization.text("info.how.selected"),
                        style: kSubtitleStyle,
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      ListTile(
                        leading: Image.asset("assets/images/bell1.png"),
                        title: Text(AppLocalization.text("notifications_camel"),
                            style: kMainTextStyle),
                        subtitle: Padding(
                          child: Text(
                              AppLocalization.text("coronatrace.will.send"),
                              style: kMainTextStyle),
                          padding: EdgeInsets.only(top: 10, bottom: 20),
                        ),
                      ),
                      Divider(
                        color: Color.fromRGBO(227, 203, 228, 1),
                        height: 0.5,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      ListTile(
                        leading: Image.asset("assets/images/map_pin.png"),
                        title: Text(
                          AppLocalization.text(
                            "location.info",
                          ),
                          style: kMainTextStyle,
                        ),
                        subtitle: Padding(
                          child: Text(
                              AppLocalization.text("corona.anonymous.infected"),
                              style: kMainTextStyle),
                          padding: EdgeInsets.only(top: 10, bottom: 20),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    child: Padding(
                        padding:
                            const EdgeInsets.fromLTRB(12.0, 28.0, 12.0, 0.0),
                        child: MaterialButton(
                          padding: EdgeInsets.symmetric(vertical: 14.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(8.0),
                          ),
                          color: Color(0xFF475df3),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                AppLocalization.text("Continue"),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                            ],
                          ),
                          onPressed: () async {
                            await handleGetStarted(context);
                          },
                        )),
                    margin: EdgeInsets.only(bottom: 20),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future handleGetStarted(BuildContext context) async {
    await PushNotifications.registerNotification();
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
  }

  Future onPremissionAvailable(BuildContext context) async {
           showLoadingDialog(tapDismiss: false);
    await ApiRepository.setOnboardingDone(true);
    hideLoadingDialog();
    navigateCollectInformation(context);
  }

  void navigateCollectInformation(BuildContext context) {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => UserInfoCollectorScreen()),
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
