import 'package:corona_trace/location_updates.dart';
import 'package:corona_trace/ui_v1_1/home_checkin/home_atrisk_notificationdetail.dart';
import 'package:corona_trace/ui_v1_1/privacy/privacy_screen.dart';
import 'package:corona_trace/utils/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class HomeNotAvailableDashboard extends StatelessWidget {
  
  final bool notifyMeEnabled;
  final bool locationInfoDenied;
  HomeNotAvailableDashboard({this.notifyMeEnabled, this.locationInfoDenied});
  
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
                  child: topContent(context, locationInfoDenied, notifyMeEnabled),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  topContent(BuildContext context, bool locationInfoDenied, bool allowedNotify) {
    dynamic locationWidget = locationInfoDenied ? 
      getLocationInformationNotAvailableWidget(context) : SizedBox(height: 0);
    dynamic notifyWidget = locationInfoDenied ?
      SizedBox(height: 0) : (allowedNotify ? 
      getAllSetWidget() : getNotifyMeWidget(context));
    return Column(
      children: <Widget>[
        Container(
          color: Color.fromRGBO(237, 239, 254, 0.4),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              SizedBox(
                height: 34,
              ),
              // TODO: Need to add one of 3 widgets here based on notify vs location permission state
              locationWidget,
              notifyWidget,
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

getAllSetWidget() {
  return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.fromLTRB(28, 10, 10, 16),
            child: Text(
              AppLocalization.text("all.set"),
              style: TextStyle(
                  fontSize: 28,
                  color: Color(0xff1A1D4A),
                  fontWeight: FontWeight.bold),
            ),
          ),
          ListTile(
            onTap: () {
              //TODO: implement
            },
            leading: SizedBox(
              child: Image.asset("assets/images/not_available_allset_circle.png"),
              width: 50,
              height: 50,
            ),
            title: Text(
              AppLocalization.text("all.set.description"),
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
            ),
          )
        ],
      )
    );
}

getNotifyMeWidget(BuildContext context) {
  return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.fromLTRB(28, 10, 10, 16),
            child: Text(
              AppLocalization.text("stay.safe.while.wait"),
              style: TextStyle(
                  fontSize: 28,
                  color: Color(0xff1A1D4A),
                  fontWeight: FontWeight.bold),
            ),
          ),
          ListTile(
            onTap: () {
              //TODO: implement
            },
            leading: SizedBox(
              child: Image.asset("assets/images/not_available_notify_circle.png"),
              width: 50,
              height: 50,
            ),
            title: Text(
              AppLocalization.text("stay.safe.while.wait.description"),
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
            ),
          ),
          Container(
            child: Material(
              child: MaterialButton(
                height: 50,
                minWidth: MediaQuery.of(context).size.width,
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
                  //TODO: Implmenet Logic to handle notify me
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => 
                            HomeNotAvailableDashboard(
                              notifyMeEnabled: true,
                              locationInfoDenied: false)),
                      (route) => false);
                },
              ),
            ),
            margin: EdgeInsets.all(20),
          ),
        ],
      )
    );
}

getLocationInformationNotAvailableWidget(BuildContext context) {
  return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.fromLTRB(28, 10, 10, 16),
            child: Text(
              AppLocalization.text("location.information.notavailable"),
              style: TextStyle(
                  fontSize: 22,
                  color: Color(0xff1A1D4A),
                  fontWeight: FontWeight.bold),
            ),
          ),
          ListTile(
            onTap: () {
              //TODO: implement
            },
            leading: SizedBox(
              child: Image.asset("assets/images/not_available_location_circle.png"),
              width: 50,
              height: 50,
            ),
            title: Text(
              AppLocalization.text("location.information.notavailable.description"),
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
            ),
          ),
          Container(
            child: Material(
              child: MaterialButton(
                height: 50,
                minWidth: MediaQuery.of(context).size.width,
                color: Color(0xff475DF3),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8))),
                child: Text(
                  AppLocalization.text(
                    "go.to.settings",
                  ),
                  style: TextStyle(color: Colors.white, fontSize: 17),
                ),
                onPressed: () {
                  openAppSettings();
                },
              ),
            ),
            margin: EdgeInsets.all(20),
          ),
        ],
      )
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
