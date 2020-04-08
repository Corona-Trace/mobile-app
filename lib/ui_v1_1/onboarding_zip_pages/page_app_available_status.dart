import 'package:corona_trace/ui_v1_1/notification_location/onboarding_location_permission.dart';
import 'package:corona_trace/utils/app_localization.dart';
import 'package:flutter/material.dart';

class PageAppAvailabilityStatus extends StatelessWidget {
  final bool isAvailable;

  PageAppAvailabilityStatus(this.isAvailable);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[topContent(), bottomContent(context)],
      ),
    );
  }

  Container topContent() {
    print("is available $isAvailable");
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 16,
          ),
          Text(
            AppLocalization.text(isAvailable
                ? "app.available.area"
                : "onboarding.app.we.willsendemail"),
            style: TextStyle(
                fontSize: 28,
                color: Color(0xff1A1D4A),
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 8,
          ),
        ],
      ),
      margin: EdgeInsets.all(20),
    );
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
              isAvailable ? "Onboarding.GetStarted" : "Ok",
            ),
            style: TextStyle(color: Colors.white, fontSize: 17),
          ),
          onPressed: () {
            if (isAvailable) {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => OnboardingLocationPermission()),
                (route) => false);
            } else {
              Navigator.pop(context);
            }
          },
        ),
      ),
      margin: EdgeInsets.only(bottom: 20),
    );
  }
}
