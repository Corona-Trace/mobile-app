import 'package:corona_trace/ui_v1_1/OnboardingStatus.dart';
import 'package:corona_trace/ui_v1_1/onboarding_zip_pages/page_app_availability.dart';
import 'package:corona_trace/ui_v1_1/onboarding_zip_pages/page_app_available_status.dart';
import 'package:corona_trace/ui_v1_1/onboarding_zip_pages/page_enter_zip_one.dart';
import 'package:corona_trace/utils/app_localization.dart';
import 'package:flutter/material.dart';

class OnboardingCheckAvailability extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return OnboardingCheckAvailabilityState();
  }
}

class OnboardingCheckAvailabilityState
    extends State<OnboardingCheckAvailability> {
  final PageController _pageController = PageController();

  bool _isAvailable = false;

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

  Container bottomContent(BuildContext context) {
    return Container(
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
                btnCheckAvailability(context);
              },
            ),
          ),
          margin: EdgeInsets.only(bottom: 20),
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
        );
  }

  void btnCheckAvailability(BuildContext context) {
    print("refreshed");
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        builder: (context) {
          return FractionallySizedBox(
            child: PageView(
              physics: NeverScrollableScrollPhysics(),
              controller: _pageController,
              children: <Widget>[
                OnboardingCheckAvailabilityCheckZip(onBoardStatusUpdate),
                PageAppAvailability(onBoardStatusUpdate),
                PageAppAvailabilityStatus(_isAvailable)
              ],
            ),
            heightFactor: 0.85,
          );
        });
  }

  void onBoardStatusUpdate(OnboaringStatus status) {
    if (status is OnboaringStatusZip) {
      // TODO validate the status.zip;
      if (status.zip == "111111") {
        print("value true");
        _isAvailable = true;
        setState(() {});
        _pageController.jumpToPage(2);
      } else {
        setState(() {});
        print("value false");
        _pageController.nextPage(
            duration: Duration(milliseconds: 250),
            curve: Curves.easeInToLinear);
      }
    } else if (status is OnboaringStatusEmail) {
      // TODO validate the status.email and send post API to save it with the zip code;
      _pageController.nextPage(
          duration: Duration(milliseconds: 250), curve: Curves.easeInToLinear);
    }
  }
}
