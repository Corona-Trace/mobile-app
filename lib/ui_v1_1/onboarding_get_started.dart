import 'package:corona_trace/ui_v1_1/notification_location/onboarding_location_permission.dart';
import 'package:corona_trace/utils/app_localization.dart';
import 'package:flutter/material.dart';

class OnboardingGetStarted extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return OnboardingGetStartedState();
  }
}

class OnboardingGetStartedState
    extends State<OnboardingGetStarted> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          topContent(context),
        ],
      ),
    ));
  }

  Container topContent(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double topPadding = screenHeight*218/812; //Ratio from Figma Design
    double minBtnWidth = MediaQuery.of(context).size.width;
    return Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: topPadding,
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
                height: 16,
              ),
              Material(
                child: MaterialButton(
                  height: 50,
                  minWidth: minBtnWidth,
                  color: Color(0xff475DF3),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                  child: Text(
                    AppLocalization.text(
                      "Onboarding.GetStarted",
                    ),
                    style: TextStyle(color: Colors.white, fontSize: 17),
                  ),
                  onPressed: () {
                    btnGetStarted(context);
                  },
                ),
              ),
            ],
          ),
          margin: EdgeInsets.all(20),
        );
  }

  void btnGetStarted(BuildContext context) {
    print("btnGetStarted");
    Navigator.pushAndRemoveUntil(context, 
          MaterialPageRoute(builder: (
            BuildContext context) => OnboardingLocationPermission()
          ),
          (route) => false);
  }
}
