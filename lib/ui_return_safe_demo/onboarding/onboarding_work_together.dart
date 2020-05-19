import 'package:corona_trace/ui_return_safe_demo/onboarding/onboarding_daily_recommendations.dart';
import 'package:corona_trace/utils/app_localization.dart';
import 'package:flutter/material.dart';

class OnboardingWorkTogether extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return OnboardingWorkTogetherState();
  }
}

class OnboardingWorkTogetherState
    extends State<OnboardingWorkTogether> {

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
    double topPadding = screenHeight*518/812; //Ratio from Figma Design
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
                AppLocalization.text("work.together.safely.title"),
                style: TextStyle(
                    fontSize: 28,
                    color: Color(0xff1A1D4A),
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                  height: 10,
                ),
                Text(
                    AppLocalization.text(
                        "work.together.safely.description"),
                    style: TextStyle(fontSize: 17)),
              SizedBox(
                height: 24,
              ),
              Material(
                child: MaterialButton(
                  height: 50,
                  minWidth: minBtnWidth,
                  color: Color(0xff379FFF),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                  child: Text(
                    AppLocalization.text(
                      "See.How",
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
            BuildContext context) => OnboardingDailyWorkplaceRecommendations()
          ),
          (route) => false);
  }
}
