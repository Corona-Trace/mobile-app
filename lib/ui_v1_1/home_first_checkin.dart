import 'package:corona_trace/ui/screens/user_info_collector_screen.dart';
import 'package:corona_trace/ui_v1_1/privacy/privacy_screen.dart';
import 'package:corona_trace/utils/app_localization.dart';
import 'package:flutter/material.dart';

class HomeFirstTimeCheckInScreen extends StatelessWidget {
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
              "check.in",
            ),
            style: TextStyle(color: Colors.white, fontSize: 17),
          ),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => UserInfoCollectorScreen()),
                    (route) => false);
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
            AppLocalization.text("check.in.start.fight"),
            style: TextStyle(
                fontSize: 28,
                color: Color(0xff1A1D4A),
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 16,
          ),
          Text(
            AppLocalization.text("answers.to.next.few.help"),
            style: TextStyle(fontSize: 17),
          ),
        ],
      ),
      margin: EdgeInsets.all(20),
    );
  }
}
