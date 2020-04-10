import 'package:corona_trace/ui_v1_1/home_checkin/home_atrisk_notificationdetail.dart';
import 'package:corona_trace/ui_v1_1/privacy/privacy_screen.dart';
import 'package:corona_trace/utils/app_localization.dart';
import 'package:flutter/material.dart';

class HomeNotAvailableDashboard extends StatelessWidget {
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
        Container(
          color: Color.fromRGBO(237, 239, 254, 0.4),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              SizedBox(
                height: 50,
              ),
              // TODO: Need to add one of 3 widgets here based on notify vs location permission state
              //getRiskListTile(context, showTrailing: true),
              SizedBox(
                height: 30,
              ),
              meanwhileManualGuideListTile(),
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
                        child: Text(
                          AppLocalization.text("manual.contact.tracing"),
                          style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        child: MaterialButton(
                          color: Color(0xffDFE3FF),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(20))),
                          child: Text(
                            AppLocalization.text(
                              "View",
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
            ],
          ),
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

ListTile meanwhileManualGuideListTile() {
  return ListTile(
    leading: SizedBox(
      child: Image.asset(
        "assets/images/checkin_dash.png",
      ),
      width: 50,
      height: 50,
    ),
    title: Text(AppLocalization.text("meanwhile.guide.waiting"),
        style: TextStyle(fontSize: 17, fontWeight: FontWeight.normal))
  );
}
