import 'package:corona_trace/location_updates.dart';
import 'package:corona_trace/network/api_repository.dart';
import 'package:corona_trace/ui/base_state.dart';
import 'package:corona_trace/ui_return_safe_demo/home_checkin/home_first_checkin.dart';
import 'package:corona_trace/ui_v1_1/not_available_yet/onboarding_not_available_yet.dart';
import 'package:corona_trace/utils/app_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OnboardingCheckinGetStarted extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return OnboardingCheckinGetStartedState();
  }
}

class OnboardingCheckinGetStartedState
    extends BaseState<OnboardingCheckinGetStarted> {
  @override
  Widget prepareWidget(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
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
                            height: 50,
                          ),
                          Align(
                            child: Image(
                              image: AssetImage(
                                "assets/images/onboarding_checkin_getstarted.png",
                              ),
                              height: screenHeight/2 - 130,
                              width: screenWidth * 0.85,
                              fit: BoxFit.fitHeight,
                            ),
                            alignment: Alignment.center,
                          ),
                          SizedBox(
                            height: 30,
                          )
                        ])),
              ],
            ),
          ),
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  AppLocalization.text(
                      "checkin.getstarted.title"),
                  style: TextStyle(
                      fontSize: 28,
                      color: Color(0xff1A1D4A),
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                    AppLocalization.text(
                        "onboarding.checkin.beresponsible.subtitle"),
                    style: TextStyle(fontSize: 17))
              ],
            ),
            margin: EdgeInsets.all(20),
          ),
          Container(
            child: Material(
              child: MaterialButton(
                height: 50,
                minWidth: MediaQuery.of(context).size.width,
                color: Color(0xff379FFF),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8))),
                child: Text(
                  AppLocalization.text(
                    "check.in",
                  ),
                  style: TextStyle(color: Colors.white, fontSize: 17),
                ),
                onPressed: () {
                  onPressedBtnGetStarted(context);
                },
              ),
            ),
            margin: EdgeInsets.all(20),
          ),
        ],
      ),),
    ));
  }

  void onPressedBtnGetStarted(BuildContext context) async {
    print("permission button clicked");
    showLoadingDialog();
    await ApiRepository.setOnboardingDone(true);
    var isWithingArea = await LocationUpdates.isWithinAvailableGeoLocation();
    hideLoadingDialog();
    if (isWithingArea) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => HomeFirstTimeCheckInScreen()),
          (route) => false);
    } else {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => OnboardingNotAvailableYet()),
          (route) => false);
    }
  }

  @override
  String screenName() {
    return "onboarding_checking_getstarted";
  }
}
