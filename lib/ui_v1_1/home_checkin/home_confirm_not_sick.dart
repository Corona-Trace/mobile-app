import 'package:corona_trace/analytics/CTAnalyticsManager.dart';
import 'package:corona_trace/app_constants.dart';
import 'package:corona_trace/network/api_repository.dart';
import 'package:corona_trace/ui_v1_1/home_checkin/thanks_doing_part_screen.dart';
import 'package:corona_trace/utils/app_localization.dart';
import 'package:flutter/material.dart';

class HomeConfirmProcessSick extends StatelessWidget {
  final bool isSick;
  final Function(Widget response) onNextScreen;

  HomeConfirmProcessSick({this.isSick,this.onNextScreen});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[topContent(), bottomContent(context)],
        ),
      ),
    );
  }

  Widget topContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: 32,
        ),
        Padding(
          padding: EdgeInsets.only(left: 20, right: 20, top: 20),
          child: Text(
            AppLocalization.text("confirm.your.answer"),
            style: TextStyle(
                fontSize: 28,
                color: Color(0xff1A1D4A),
                fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 32,
        ),
        getNotFeelSickContainer(),
        SizedBox(
          height: 32,
        ),
        Padding(
          padding: EdgeInsets.only(left: 20),
          child: Text(
            AppLocalization.text("by.responding"),
            style: TextStyle(fontSize: 13),
          ),
        ),
        SizedBox(
          height: 32,
        ),
        ListTile(
          title: Text(
            AppLocalization.text("Legal.Terms.Conditions"),
          ),
          trailing: Icon(Icons.arrow_forward_ios),
          onTap: () {
            CTAnalyticsManager.instance.logClickTermsAndConditions();
            AppConstants.launchUrl(ApiRepository.TERMS_AND_CONDITIONS);
          },
        ),
        Divider(
          height: 0.5,
          indent: 20,
          color: Colors.grey,
        ),
        ListTile(
          title: Text(
            AppLocalization.text("Legal.Privacy.Policy"),
          ),
          trailing: Icon(Icons.arrow_forward_ios),
          onTap: () {
            CTAnalyticsManager.instance.logClickPrivacyPolicy();
            AppConstants.launchUrl(ApiRepository.PRIVACY_POLICY);
          },
        ),
        Divider(
          height: 0.5,
          indent: 20,
          color: Colors.grey,
        ),
      ],
    );
  }

  Container getNotFeelSickContainer() {
    return Container(
      padding: EdgeInsets.only(top: 30, bottom: 30),
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
          color: Color(0xffF3F4FC),
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: 20,
              ),
              Icon(
                Icons.done,
                color: Color(0xff475DF3),
              ),
              SizedBox(
                width: 20,
              ),
              Text(
                AppLocalization.text(
                    !isSick ? "not.feel.sick" : "yes.feel.sick.message"),
                style: TextStyle(fontSize: 17),
              )
            ],
          ),
          isSick
              ? Padding(
                  padding:
                      EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 10),
                  child:
                      Text(AppLocalization.text("is.sick.not.tested.message")),
                )
              : Container()
        ],
      ),
    );
  }

  Widget bottomContent(BuildContext context) {
    return Column(
      children: <Widget>[
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
                  "submit",
                ),
                style: TextStyle(color: Colors.white, fontSize: 17),
              ),
              onPressed: () {
                onNextScreen.call(ThanksDoingPartScreen());
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
              style: TextStyle(color: Color(0xff475DF3), fontSize: 17),
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
