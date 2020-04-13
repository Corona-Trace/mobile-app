import 'package:corona_trace/location_updates.dart';
import 'package:corona_trace/ui_v1_1/not_available_yet/home_not_available_dashboard.dart';
import 'package:corona_trace/utils/app_localization.dart';
import 'package:flutter/material.dart';

class OnboardingNotAvailableYet extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return OnboardingNotAvailableYetState();
  }
}

class OnboardingNotAvailableYetState
    extends State<OnboardingNotAvailableYet> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          topContent(),
          bottomContent(context),
        ],
      ),
    ));
  }

  Widget bottomContent(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 16,
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
                  "notify.me",
                ),
                style: TextStyle(color: Colors.white, fontSize: 17),
              ),
              onPressed: () {
                onPressedBtn(context, true);
              },
            ),
          ),
          margin: EdgeInsets.only(bottom: 20),
        ),
        Container(
          child: MaterialButton(
            height: 50,
            minWidth: MediaQuery.of(context).size.width * 0.85,
            color: Color(0xffDFE3FF),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8))),
            child: Text(
              AppLocalization.text(
                "not.right.now",
              ),
              style: TextStyle(color: Color(0xff475DF3), fontSize: 17),
            ),
            onPressed: () {
              onPressedBtn(context, false);
            },
          ),
          margin: EdgeInsets.only(bottom: 20),
        )
      ],
    );
  }

  Container topContent() {
    return Container(
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
                AppLocalization.text("onboarding.looks.like.not.available"),
                style: TextStyle(
                    fontSize: 28,
                    color: Color(0xff1A1D4A),
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 8,
              ),
              Text(AppLocalization.text("onboarding.notavailable.subtitle"),
                  style: TextStyle(fontSize: 17))
            ],
          ),
          margin: EdgeInsets.all(20),
        );
  }

  void onPressedBtn(BuildContext context, bool shouldNotify) async {
    bool locationInfoDenied = await LocationUpdates.arePermissionsDenied();
    //TODO: Implmenet Logic to handle notify me
    print("next button clicked");
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => 
              HomeNotAvailableDashboard(
                notifyMeEnabled: shouldNotify,
                locationInfoDenied: locationInfoDenied)),
        (route) => false);
  }
}
