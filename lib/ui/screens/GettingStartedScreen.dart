import 'dart:io';

import 'package:corona_trace/LocationUpdates.dart';
import 'package:corona_trace/main.dart';
import 'package:corona_trace/network/APIRepository.dart';
import 'package:corona_trace/network/ResponseNotifications.dart';
import 'package:corona_trace/push_notifications/push_notifications.dart';
import 'package:corona_trace/ui/BaseState.dart';
import 'package:corona_trace/ui/notifications/CTNotificationMapDetail.dart';
import 'package:corona_trace/ui/screens/Onboarding.dart';
import 'package:corona_trace/ui/screens/UserInfoCollectorScreen.dart';
import 'package:corona_trace/utils/AppLocalization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GettingStarted extends StatefulWidget {
  @override
  _GettingStartedState createState() => _GettingStartedState();
}

class _GettingStartedState extends BaseState<GettingStarted> {
  @override
  Widget prepareWidget(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Color(0xFF2c3054),
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(left: 20, right: 20, top: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 40,
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
                    Divider(
                      color: Color.fromRGBO(227, 203, 228, 1),
                      height: 0.5,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ListTile(
                      leading: Image.asset("assets/images/map_pin.png"),
                      title: Text(AppLocalization.text("notifications_camel"),
                          style: kMainTextStyle),
                      subtitle: Padding(
                        child: Text(
                            AppLocalization.text("coronatrace.will.send"),
                            style: kMainTextStyle),
                        padding: EdgeInsets.only(top: 10, bottom: 20),
                      ),
                    ),
                  ],
                ),
                Container(
                  child: Padding(
                      padding: const EdgeInsets.fromLTRB(12.0, 36.0, 12.0, 0.0),
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
                          showLoadingDialog(tapDismiss: false);
                          var selected = await showDialogForLocation();
                          if (selected) {
                            await LocationUpdates.requestPermissions();
                            await PushNotifications.registerNotification();
                          }
                          await ApiRepository.setOnboardingDone(true);
                          hideLoadingDialog();
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      UserInfoCollectorScreen()),
                              (route) => false);
                        },
                      )),
                  margin: EdgeInsets.only(bottom: 20),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> showDialogForLocation() {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        if (Platform.isIOS) {
          return CupertinoAlertDialog(
            title: Text(AppLocalization.text("let.coronatrace.access")),
            content: Text(AppLocalization.text("this.helps.us.spread")),
            actions: <Widget>[
              CupertinoDialogAction(
                child: Text(AppLocalization.text("not.now")),
                onPressed: () {
                  Navigator.pop(context, false);
                },
              ),
              CupertinoDialogAction(
                child: Text(AppLocalization.text("give.access")),
                onPressed: () {
                  Navigator.pop(context, true);
                },
              ),
            ],
          );
        } else {
          return AlertDialog(
            title: Text(AppLocalization.text("let.coronatrace.access")),
            content: Text(AppLocalization.text("this.helps.us.spread")),
            actions: <Widget>[
              FlatButton(
                child: Text(AppLocalization.text("not.now")),
                onPressed: () {
                  Navigator.pop(context, false);
                },
              ),
              FlatButton(
                child: Text(AppLocalization.text("give.access")),
                onPressed: () {
                  Navigator.pop(context, true);
                },
              ),

            ],
          );
        }
      },
    );
  }
}
