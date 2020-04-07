import 'package:corona_trace/main.dart';
import 'package:corona_trace/utils/app_localization.dart';
import 'package:flutter/material.dart';

class OnboardingCheckAvailability extends StatelessWidget {
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
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 16,
                ),
                Text(
                  AppLocalization.text("Coronatrace").toUpperCase(),
                  style: TextStyle(
                      color: Color(0xff475DF3),
                      fontSize: 17,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  AppLocalization.text("onboarding.working.together"),
                  style: TextStyle(
                      fontSize: 28,
                      color: Color(0xff1A1D4A),
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(AppLocalization.text("onboarding.working.anonymous"),
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
                    "check.availability",
                  ),
                  style: TextStyle(color: Colors.white, fontSize: 17),
                ),
                onPressed: () {
                  btnCheckAvailability();
                },
              ),
            ),
            margin: EdgeInsets.only(bottom: 20),
          ),
        ],
      ),
    ));
  }

  void btnCheckAvailability() {

  }
}
