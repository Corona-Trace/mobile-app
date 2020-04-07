import 'package:corona_trace/service/push_notifications/push_notifications.dart';
import 'package:corona_trace/ui_v1_1/onboarding_checkin_beresponsible.dart';
import 'package:corona_trace/utils/app_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OnboardingNotificationPermission extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return OnboardingNotificationPermissionState();
  }
}

class OnboardingNotificationPermissionState
    extends State<OnboardingNotificationPermission> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
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
                        height: 50,
                      ),
                      Align(
                        child: Image(
                          image: AssetImage(
                            "assets/images/onboarding_notification_permission.png",
                          ),
                        ),
                        alignment: Alignment.center,
                      ),
                      SizedBox(
                        height: 30,
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
                  AppLocalization.text("onboarding.permissions.notification.title"),
                  style: TextStyle(
                      fontSize: 28,
                      color: Color(0xff1A1D4A),
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(AppLocalization.text("onboarding.permissions.notification.subtitle"),
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
                color: Color(0xff475DF3),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8))),
                child: Text(
                  AppLocalization.text(
                    "onboarding.permissions.notification.button",
                  ),
                  style: TextStyle(color: Colors.white, fontSize: 17),
                ),
                onPressed: () {
                  onPressedBtnAllowNotification(context);
                },
              ),
            ),
            margin: EdgeInsets.only(bottom: 20),
          ),
        ],
      ),
    ));
  }

  Future onPressedBtnAllowNotification(BuildContext context) async {
    await PushNotifications.registerNotification();
    navigateCheckinBeResponsible(context);
  }

  void navigateCheckinBeResponsible(BuildContext context) {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => OnboardingCheckinBeResponsible()),
        (route) => false);
  }
}
