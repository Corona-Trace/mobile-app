import 'package:corona_trace/analytics/CTAnalyticsManager.dart';
import 'package:corona_trace/app_constants.dart';
import 'package:corona_trace/network/api_repository.dart';
import 'package:corona_trace/ui_v1_1/privacy/delete_data_screen.dart';
import 'package:corona_trace/utils/app_localization.dart';
import 'package:flutter/material.dart';

class PrivacyTermsAndConditionsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StatefulBuilder(builder: (context, setState) {
        return Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: SingleChildScrollView(
                  child: topContent(setState),
                ),
              ),
              bottomContent(context),
            ],
          ),
        );
      }),
    );
  }

  Widget bottomContent(BuildContext context) {
    return Container(
      child: Material(
        child: MaterialButton(
          height: 50,
          elevation: 0,
          minWidth: MediaQuery.of(context).size.width * 0.85,
          color: Color(0xffFFDBE3),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8))),
          child: Text(
            AppLocalization.text(
              "delete.my.data",
            ),
            style: TextStyle(
                color: Color(0xffFF3A6A),
                fontSize: 17,
                fontWeight: FontWeight.bold),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => DeleteDataScreen()),
            );
          },
        ),
      ),
      margin: EdgeInsets.only(bottom: 20),
    );
  }

  Container topContent(setState) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 16,
          ),
          ListTile(title: Text(
            AppLocalization.text("privacy"),
            style: TextStyle(
                fontSize: 28,
                color: Color(0xff1A1D4A),
                fontWeight: FontWeight.bold),
          ),),
          SizedBox(
            height: 16,
          ),
          ListTile(
            title: Text(
              AppLocalization.text("Legal.Terms.Conditions"),
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              CTAnalyticsManager.instance.logClickTermsAndConditions();
              AppConstants.launchUrl(ApiRepository.TERMS_AND_CONDITIONS);
            },
          ),
          Divider(
            height: 0.5,
            color: Colors.grey,
          ),
          ListTile(
            title: Text(
              AppLocalization.text("Legal.Privacy.Policy"),
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              CTAnalyticsManager.instance.logClickPrivacyPolicy();
              AppConstants.launchUrl(ApiRepository.PRIVACY_POLICY);
            },
          ),
          Divider(
            height: 0.5,
            color: Colors.grey,
          ),
        ],
      ),
      margin: EdgeInsets.all(20),
    );
  }
}
