import 'package:corona_trace/network/api_repository.dart';
import 'package:corona_trace/ui_v1_1/home_checkin/home_atrisk_notificationdetail.dart';
import 'package:corona_trace/ui_v1_1/home_checkin/home_confirm_not_sick.dart';
import 'package:corona_trace/ui_v1_1/privacy/privacy_screen.dart';
import 'package:corona_trace/utils/app_localization.dart';
import 'package:flutter/material.dart';

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
              bottomContent(context)
            ],
          ),
        ),
      ),
    );
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
                  "next.steps",
                ),
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.bold),
              ),
              onPressed: () {},
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
                "notify.someone",
              ),
              style: TextStyle(
                  color: Color(0xff475DF3),
                  fontSize: 17,
                  fontWeight: FontWeight.bold),
            ),
            onPressed: () {},
          ),
          margin: EdgeInsets.only(bottom: 20),
        )
      ],
    );
  }

  topContent(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 50,
        ),
        getRiskListTile(context, showTrailing: true),
        SizedBox(
          height: 30,
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
                Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: FutureBuilder(
                    future: ApiRepository.getUserSeverity(),
                    builder: (context, snapshot) {
                      print(snapshot);
                      if (snapshot.hasData) {
                        return Text(
                          AppLocalization.text(getTextForStatus(snapshot.data as int)),
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        );
                      } else {
                        return Text("");
                      }
                    },
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
                    onPressed: () {},
                  ),
                  padding: EdgeInsets.only(right: 20),
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
          title: Text(
            "Resources",
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
          ),
          subtitle: Text("Learn more about how to stay safe",
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
          title: Text("How CoronaTrace Works",
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
          subtitle: Text("Learn about Contact Tracing",
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
          title: Text("Privacy Settings",
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
          subtitle: Text("Manage how your information is used",
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
    onTap: () {
      if (showTrailing) {
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
      }
    },
    trailing: Icon(
      Icons.arrow_forward_ios,
      color: showTrailing ? Colors.grey : Colors.white,
    ),
    leading: SizedBox(
      child: Image.asset("assets/images/status.png"),
      width: 50,
      height: 50,
    ),
    title: Text(
      AppLocalization.text("Status"),
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    ),
    subtitle: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(AppLocalization.text("you.maybe.risk"),
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        Text("March 31, 2020 5:30pm",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))
      ],
    ),
  );
}

ListTile lastCheckinListTile() {
  return ListTile(
    trailing: Icon(Icons.arrow_forward_ios),
    leading: SizedBox(
      child: Image.asset(
        "assets/images/checkin_dash.png",
      ),
      width: 50,
      height: 50,
    ),
    title: Text(AppLocalization.text("last.checkin"),
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
    subtitle: Text("March 31, 2020 5:30pm",
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
  );
}
