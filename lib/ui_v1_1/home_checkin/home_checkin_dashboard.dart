import 'package:corona_trace/analytics/CTAnalyticsManager.dart';
import 'package:corona_trace/app_constants.dart';
import 'package:corona_trace/network/api_repository.dart';
import 'package:corona_trace/ui_v1_1/home_checkin/home_atrisk_notificationdetail.dart';
import 'package:corona_trace/ui_v1_1/home_checkin/home_confirm_not_sick.dart';
import 'package:corona_trace/ui_v1_1/home_checkin/home_first_checkin.dart';
import 'package:corona_trace/ui_v1_1/privacy/privacy_screen.dart';
import 'package:corona_trace/utils/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomeCheckinDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: SingleChildScrollView(
                  child: topContent(context),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  topContent(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 50,
        ),
        getRiskListTile(context),
        SizedBox(
          height: 30,
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
                  "details.next.steps",
                ),
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    builder: (context) {
                      return FractionallySizedBox(
                        child: AtRiskNotificationDetail(),
                        heightFactor: 0.85,
                      );
                    });
              },
            ),
          ),
          margin: EdgeInsets.only(bottom: 20),
        ),
        lastCheckinListTile(),
        SizedBox(
          height: 30,
        ),
        Container(
          child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: FutureBuilder(
                      future: ApiRepository.getUserSeverity(),
                      builder: (context, snapshot) {
                        print(snapshot);
                        if (snapshot.hasData) {
                          return Text(
                            AppLocalization.text(
                                getTextForStatus(snapshot.data as int)),
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold),
                          );
                        } else {
                          return Text("");
                        }
                      },
                    ),
                  ),
                ),
                Padding(
                  child: MaterialButton(
                    color: Color(0xffDFE3FF),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: Text(
                      AppLocalization.text(
                        "Update",
                      ),
                      style: TextStyle(
                          color: Color(0xff475DF3),
                          fontSize: 17,
                          fontWeight: FontWeight.bold),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  HomeFirstTimeCheckInScreen()));
                    },
                  ),
                  padding: EdgeInsets.only(right: 20, top: 5, bottom: 5),
                )
              ],
            ),
          ),
          margin: EdgeInsets.only(left: 20, right: 20),
        ),
        SizedBox(
          height: 30,
        ),
        ListTile(
          onTap: () {
            CTAnalyticsManager.instance.logClickResources();
            AppConstants.launchUrl(ApiRepository.RESOURCES_URL);
          },
          title: Text(
            AppLocalization.text("checking.Resources"),
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
          ),
          subtitle: Text(AppLocalization.text("learn.howto.staysafe"),
              style: TextStyle(fontSize: 15)),
          trailing: Icon(Icons.arrow_forward_ios),
        ),
        Divider(
          height: 0.5,
          color: Color(0xffBAC8E1),
          indent: 20,
        ),
        SizedBox(
          height: 30,
        ),
        ListTile(
          onTap: () {
            CTAnalyticsManager.instance.logClickHowItWorks();
            AppConstants.launchUrl(ApiRepository.HOW_IT_WORKS_URL);
          },
          title: Text(AppLocalization.text("how.tracetozero.works"),
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
          subtitle: Text(AppLocalization.text("learn.about.contacttracing"),
              style: TextStyle(fontSize: 15)),
          trailing: Icon(Icons.arrow_forward_ios),
        ),
        Divider(
          height: 0.5,
          color: Color(0xffBAC8E1),
          indent: 20,
        ),
        SizedBox(
          height: 30,
        ),
        ListTile(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) =>
                        PrivacyTermsAndConditionsScreen()));
          },
          title: Text(AppLocalization.text("privacy.settings"),
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
          subtitle: Text(AppLocalization.text("how.information.used"),
              style: TextStyle(fontSize: 15)),
          trailing: Icon(Icons.arrow_forward_ios),
        ),
        Divider(
          height: 0.5,
          color: Color(0xffBAC8E1),
          indent: 20,
        ),
      ],
    );
  }
}

ListTile getRiskListTile(BuildContext context, {bool showTrailing}) {
  return ListTile(
    leading: SizedBox(
      child: Image.asset("assets/images/status.png"),
      width: 50,
      height: 50,
    ),
    title: Text(
      AppLocalization.text("you.maybe.risk"),
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    ),
    subtitle: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "1 ${AppLocalization.text("nLocation")}",
          style: TextStyle(
              fontSize: 20,
              color: Color(0xff1A1D4A),
              fontWeight: FontWeight.w400),
        ),
        SizedBox(
          height: 10,
        ),
        RichText(
            text: TextSpan(
                style: TextStyle(fontSize: 18, color: Color(0xff1A1D4A)),
                children: [
              TextSpan(text: AppLocalization.text("location.data.suggests")),
              TextSpan(
                  text: AppLocalization.text("may.have.crossed.paths"),
                  style: TextStyle(fontWeight: FontWeight.bold)),
              TextSpan(
                  text: AppLocalization.text("with.someone.texted.positive"))
            ]))
      ],
    ),
  );
}

ListTile lastCheckinListTile() {
  return ListTile(
    leading: SizedBox(
      child: Image.asset(
        "assets/images/checkin_dash.png",
      ),
      width: 50,
      height: 50,
    ),
    title: Text(AppLocalization.text("last.checkin"),
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
    subtitle: Text(DateFormat("EEEE MMM dd hh:mm a").format(DateTime.now()),
        style: TextStyle(fontSize: 18)),
  );
}
