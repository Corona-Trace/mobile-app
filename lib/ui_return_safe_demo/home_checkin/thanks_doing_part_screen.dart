
import 'package:corona_trace/app_constants.dart';
import 'package:corona_trace/network/api_repository.dart';
import 'package:corona_trace/ui_return_safe_demo/today_checkin/today_checkin_dashboard.dart';
import 'package:corona_trace/utils/app_localization.dart';
import 'package:corona_trace/utils/app_surveys.dart';
import 'package:flutter/material.dart';

class ThanksDoingPartScreen extends StatelessWidget {
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
          color: Color(0xff379FFF),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8))),
          child: Text(
            AppLocalization.text(
              "done",
            ),
            style: TextStyle(color: Colors.white, fontSize: 17),
          ),
          onPressed: () async {
            int severity = await ApiRepository.getUserSeverity();
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (builder) { 
                      AppSurveys.triggerCheckInFinishedSurvey();
                      return TodayCheckinDashboard(severity: severity);
                  }),
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
            AppLocalization.text("thank.you.for.part"),
            style: TextStyle(
                fontSize: 28,
                color: Color(0xff1A1D4A),
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 16,
          ),
          Text(
            AppLocalization.text("we.will.now.cross"),
            style: TextStyle(fontSize: 17),
          ),
        ],
      ),
      margin: EdgeInsets.all(20),
    );
  }
}
