import 'package:corona_trace/analytics/CTAnalyticsManager.dart';
import 'package:corona_trace/app_constants.dart';
import 'package:corona_trace/network/api_repository.dart';
import 'package:corona_trace/ui_return_safe_demo/home_checkin/home_first_checkin.dart';
import 'package:corona_trace/ui_v1_1/home_checkin/home_atrisk_notificationdetail.dart';
import 'package:corona_trace/ui_v1_1/home_checkin/home_confirm_not_sick.dart';
import 'package:corona_trace/ui_v1_1/privacy/privacy_screen.dart';
import 'package:corona_trace/utils/app_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TodayCheckinDashboard extends StatelessWidget {
  final int severity;
  TodayCheckinDashboard({this.severity});
  
  @override
  Widget build(BuildContext context) {
    CheckedInStatus status = getCheckedInStatus(severity);
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Color(0xffE5E5E5),
          body: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.all(24),
                    child: topContent(context, status, severity),
                  ),
                ),
                tabBar()
              ],
            ),
          ),
        ),
      )
    );
  }

  tabBar() {
    return CupertinoTabBar(
        backgroundColor: Colors.white,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Image.asset("assets/images/tabbar_today_icon.png"),
                title: Text(
                  AppLocalization.text("today.checkin.tabbar.today")
                ),
              ),
              BottomNavigationBarItem(
                icon: Image.asset("assets/images/tabbar_atwork_icon.png"),
                title: Text(
                  AppLocalization.text("today.checkin.tabbar.atwork")
                ),
              ),
              BottomNavigationBarItem(
                icon: Image.asset("assets/images/tabbar_help_icon.png"),
                title: Text(
                  AppLocalization.text("today.checkin.tabbar.help")
                ),
              ),
            ],
            currentIndex: 0,
            activeColor: Color(0xff379FFF),
          );
  }

  topContent(BuildContext context, CheckedInStatus checkedInStatus, int severity) {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('EEEE, MMM dd').format(now);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          formattedDate,
          style: TextStyle(
            fontSize: 13, 
            fontWeight: FontWeight.bold,
            color: Color(0xff8E8E93)
          )
        ),
        Text(
          AppLocalization.text("today"),
          style: TextStyle(
            fontSize: 36, 
            fontWeight: FontWeight.bold
          )
        ),
        SizedBox(
          height: 10,
        ),
        checkedInStatusCard(context, checkedInStatus, severity),
        SizedBox(
          height: 20,
        ),
        yourOfficeExampleCard(context),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }
}

Card yourOfficeExampleCard(BuildContext context) {
  return Card(
    elevation: 4,
    shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(10))),
    child: Container(
      child: Image.asset(
        "assets/images/your_office_example.png"),
      width: MediaQuery.of(context).size.width * 0.85,
    ),
  );
}

Card checkinCard(BuildContext context) {
  return Card(
    elevation: 4,
    shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(10))),
    child: Padding(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Image.asset("assets/images/today_clipboard_icon.png"),
          SizedBox(
            height: 10,
          ),
          Text(
            AppLocalization.text("check.in"),
            style: TextStyle(
              fontSize: 20, 
              fontWeight: FontWeight.bold
            )
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            AppLocalization.text("today.checkin.subtitle"),
            style: TextStyle(
              fontSize: 17, 
              color: Color(0xff8E8E93)
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            child: Material(
              child: MaterialButton(
                height: 50,
                minWidth: MediaQuery.of(context).size.width * 0.75,
                color: Color(0xff379FFF),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8))),
                child: Text(
                  AppLocalization.text(
                    "start",
                  ),
                  style: TextStyle(
                      color: Colors.white,
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
            ),
          ),
        ],
      ),
      padding: EdgeInsets.all(20),
    )
  );
}

enum CheckedInStatus {
  notCheckedIn,
  comeToWork,
  workFromHome,
  seeYourDoctor,
  speakWithContactTracer
}

Card checkedInStatusCard(BuildContext context, CheckedInStatus checkedInStatus, int severity) {
  Image iconImage;
  String title;
  String subtitle;
  bool shouldDisplayInterviewButton = false;
  bool hasSymptoms = (severity == AppConstants.NOT_TESTED_FEEL_SICK || severity == AppConstants.TESTED_POSITIVE);
  switch(checkedInStatus) {
    case CheckedInStatus.notCheckedIn:
      return checkinCard(context);
    case CheckedInStatus.comeToWork:
      iconImage = Image.asset("assets/images/today_coffee_icon.png");
      title = AppLocalization.text("today.checkin.cometowork");
      subtitle = AppLocalization.text("today.checkin.cometowork.subtitle");
      break;
    case CheckedInStatus.workFromHome:
      iconImage = Image.asset("assets/images/today_home_icon.png");
      title = AppLocalization.text("today.checkin.workfromhome");
      subtitle = AppLocalization.text("today.checkin.workfromhome.subtitle");
      break;
    case CheckedInStatus.seeYourDoctor:
      iconImage = Image.asset("assets/images/today_doctor_icon.png");
      title = AppLocalization.text("today.checkin.seeyourdoctor");
      subtitle = AppLocalization.text("today.checkin.seeyourdoctor.subtitle");
      break;
    case CheckedInStatus.speakWithContactTracer:
      iconImage = Image.asset("assets/images/today_contacttracer_icon.png");
      title = AppLocalization.text("today.checkin.speakwithcontacttracer");
      subtitle = AppLocalization.text("today.checkin.speakwithcontacttracer.subtitle");
      shouldDisplayInterviewButton = true;
      break;
  }
  return Card(
    elevation: 4,
    shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(10))),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Padding(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              iconImage,
              SizedBox(
                height: 10,
              ),
              Text(
                title,
                style: TextStyle(
                  fontSize: 20, 
                  fontWeight: FontWeight.bold
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 17, 
                  color: Color(0xff8E8E93)
                ),
                textAlign: TextAlign.center
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                child: Material(
                  color: Colors.white,
                  child: MaterialButton(
                    color: shouldDisplayInterviewButton ? Colors.white : Color(0xff379FFF),
                    elevation: shouldDisplayInterviewButton ? 0 : 2,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: Text(
                      AppLocalization.text(
                        "see.why",
                      ),
                      style: TextStyle(
                          color: shouldDisplayInterviewButton ? Color(0xff379FFF) : Colors.white,
                          fontSize: 15),
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
              ),
              shouldDisplayInterviewButton ?
              SizedBox(
                height: 10,
              ) : SizedBox(height: 0),
              shouldDisplayInterviewButton ? Container(
                child: Material(
                  child: MaterialButton(
                    height: 50,
                    minWidth: MediaQuery.of(context).size.width * 0.75,
                    color: Color(0xff379FFF),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    child: Text(
                      AppLocalization.text(
                        "setup.interview",
                      ),
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.bold),
                    ),
                    onPressed: () {
                      
                    },
                  ),
                ),
              ) : SizedBox(height: 0),
            ],
          ),
          padding: EdgeInsets.all(20),
        ),
        Divider(
          height: 0.5,
          color: Color(0xffBAC8E1),
          indent: 0,
        ),
        lastCheckinListTile(context, hasSymptoms)
      ]
    )
  );
}

ListTile lastCheckinListTile(BuildContext context, bool hasSymptoms) {
  return ListTile(
    leading: SizedBox(
      child: Image.asset(
        hasSymptoms ? "assets/images/meh_icon.png" : "assets/images/smile_icon.png",
      ),
      width: 40,
      height: 50,
    ),
    title: Text(
        hasSymptoms ? AppLocalization.text("experiencing.symptoms") : AppLocalization.text("no.symptoms"),
        style: TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w500
          )),
    subtitle: Text("TODAY " + DateFormat("h:mm a").format(DateTime.now()),
        style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
    trailing: Container(
                child: Material(
                  color: Colors.white,
                  child: MaterialButton(
                    color: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: Text(
                      AppLocalization.text(
                        "Update",
                      ),
                      style: TextStyle(
                          color: Color(0xff379FFF),
                          fontSize: 17,
                          fontWeight: FontWeight.w600),
                    ),
                    onPressed: () {
                      Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      HomeFirstTimeCheckInScreen()));
                    },
                  ),
                ),
              ),
  );
}

CheckedInStatus getCheckedInStatus(severity) {
      switch(severity) {
        case AppConstants.TESTED_POSITIVE:
          return CheckedInStatus.speakWithContactTracer;
        case AppConstants.TESTED_NEGATIVE:
          return CheckedInStatus.comeToWork;
        case AppConstants.WAITING:
          return CheckedInStatus.workFromHome;
        case AppConstants.NOT_TESTTED_NOT_SICK:
          return CheckedInStatus.workFromHome;
        case AppConstants.NOT_TESTED_FEEL_SICK:
          return CheckedInStatus.seeYourDoctor;
        default:
          return CheckedInStatus.notCheckedIn;
      }
  }