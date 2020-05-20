import 'package:corona_trace/app_constants.dart';
import 'package:corona_trace/utils/app_localization.dart';
import 'package:flutter/material.dart';

import 'home_confirm_not_sick.dart';

class WatchForSymptomsWidget {
  final bool showBottomButtons;
  final int status;
  final Function(Widget response) onNextScreen;
  final bool needsScroll;

  WatchForSymptomsWidget(
      {this.showBottomButtons,
      this.status,
      this.onNextScreen,
      this.needsScroll});

  Widget get(context) {
    if (needsScroll) {
      return SingleChildScrollView(
        child: getInnerContent(context),
      );
    }
    return getInnerContent(context);
  }

  Container getInnerContent(context) {
    return Container(
      child: Column(
        children: <Widget>[
          SizedBox(height: 32),
          getWatchForSymptomsColumn(),
          getWhenToSeekMedical(),
          SizedBox(height: 20),
          getHowToProtect(),
          showBottomButtons ? bottomContent(context) : Container()
        ],
      ),
    );
  }

  getWatchForSymptomsColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        ListTile(
          title: Text(
            AppLocalization.text("watch.for.symptoms"),
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          subtitle: Padding(
            child: Text(
              AppLocalization.text("this.guidance.was"),
              style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff1A1D4A)),
            ),
            padding: EdgeInsets.only(top: 16),
          ),
        ),
        ListTile(
          title: Text(AppLocalization.text("these.symptoms.may.appear"),
              style: TextStyle(fontSize: 17, color: Color(0xff1A1D4A))),
        ),
        SizedBox(height: 10),
        ListTile(
          title: Text(
            "•  " + AppLocalization.text("Fever"),
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        Divider(
          height: 0.5,
          indent: 20,
          color: Color(0xffBAC8E1),
        ),
        ListTile(
          title: Text(
            "•  " + AppLocalization.text("Cough"),
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        Divider(
          height: 0.5,
          indent: 20,
          color: Color(0xffBAC8E1),
        ),
        ListTile(
          title: Text(
            "•  " + AppLocalization.text("shortness.breath"),
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }

  getWhenToSeekMedical() {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 20),
          Text(
            AppLocalization.text("when.seek.medical"),
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Text(AppLocalization.text("if.you.develop"),
              style: TextStyle(fontSize: 17)),
          SizedBox(height: 10),
          ListTile(
            title: Text(
              "•  Trouble breathing",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ),
          Divider(
            height: 0.5,
            indent: 20,
            color: Color(0xffBAC8E1),
          ),
          ListTile(
            title: Text(
              "•  Persistent pain or pressure in the chest",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ),
          Divider(
            height: 0.5,
            indent: 20,
            color: Color(0xffBAC8E1),
          ),
          ListTile(
            title: Text(
              "•  New confusion or inability to around",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ),
          Divider(
            height: 0.5,
            indent: 20,
            color: Color(0xffBAC8E1),
          ),
          ListTile(
            title: Text(
              "•  Bluish lips or face",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
      color: Color(0xffF3F4FC),
    );
  }

  getHowToProtect() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        ListTile(
          onTap: () {
            AppConstants.launchUrl(AppConstants.DOCUMENTATION_URL);
          },
          title: Text(
            AppLocalization.text("learn.protect.yourself"),
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
          ),
          trailing: Icon(Icons.arrow_forward_ios),
        ),
        Divider(
          height: 0.5,
          color: Color(0xffBAC8E1),
          indent: 20,
        ),
        SizedBox(
          height: 10,
        ),
        ListTile(
          onTap: (){
            AppConstants.launchUrl(AppConstants.CARE_FOR_SOMEONE);
          },
          title: Text(AppLocalization.text("how.tocareforsomeone"),
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
          trailing: Icon(Icons.arrow_forward_ios),
        ),
        Divider(
          height: 0.5,
          color: Color(0xffBAC8E1),
          indent: 20,
        ),
        SizedBox(
          height: 10,
        ),
        ListTile(
          onTap: (){
            AppConstants.launchUrl(AppConstants.STEPS_WHEN_SICK);
          },
          title: Text(AppLocalization.text("todo.whensick"),
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
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

  Widget bottomContent(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(height: 30),
        Container(
          child: Material(
            child: MaterialButton(
              height: 50,
              minWidth: MediaQuery.of(context).size.width * 0.85,
              color: Color(0xff379FFF),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8))),
              child: Text(
                AppLocalization.text(
                  "next",
                ),
                style: TextStyle(color: Colors.white, fontSize: 17),
              ),
              onPressed: () {
                onNextScreen.call(HomeConfirmProcessSick(
                  status: status,
                  onNextScreen: onNextScreen,
                ));
              },
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
                "go.back",
              ),
              style: TextStyle(color: Color(0xff379FFF), fontSize: 17),
            ),
            onPressed: () {
              onNextScreen.call(null);
            },
          ),
          margin: EdgeInsets.only(bottom: 20),
        )
      ],
    );
  }
}
