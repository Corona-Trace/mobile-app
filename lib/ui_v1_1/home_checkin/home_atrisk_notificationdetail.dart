import 'package:corona_trace/ui_v1_1/home_checkin/WatchForSymptomsWidget.dart';
import 'package:corona_trace/ui_v1_1/home_checkin/home_checkin_dashboard.dart';
import 'package:corona_trace/utils/app_localization.dart';
import 'package:flutter/material.dart';

class AtRiskNotificationDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 20),
              getRiskListTile(context, showTrailing: false),
              SizedBox(height: 10),
              getNextSteps(),
              WatchForSymptomsWidget(
                      showBottomButtons: false, needsScroll: false)
                  .get(context),
              SizedBox(
                height: 30,
              )
            ],
          ),
          margin: EdgeInsets.only(left: 20, right: 20),
        ),
      ),
    );
  }

  Row getNextSteps() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        RawMaterialButton(
          fillColor: Color(0xff475DF3),
          onPressed: () {},
          child: Icon(
            Icons.arrow_forward,
            color: Colors.white,
          ),
          shape: CircleBorder(side: BorderSide(color: Color(0xff475DF3))),
        ),
        Text(
          AppLocalization.text("next.steps"),
          style: TextStyle(
              color: Color(0xff1A1D4A),
              fontSize: 20,
              fontWeight: FontWeight.bold),
        )
      ],
    );
  }

  ListTile topListTileWithMap() {
    return ListTile(
      leading: Icon(
        Icons.add,
        color: Colors.white,
      ),
      title: Text(
        AppLocalization.text("your.location.data.suggest"),
        style: TextStyle(fontSize: 17),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 20,
          ),
          Card(
              child: SizedBox(
                height: 200,
                width: double.infinity,
              ),
              color: Colors.indigo.shade400),
          SizedBox(
            height: 20,
          ),
          Text(
            "Texas Capital",
            style: TextStyle(
                fontSize: 17,
                color: Color(0xff1A1D4A),
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            "You visisted today between 1:00pm - 2:34pm",
            style: TextStyle(fontSize: 17),
          ),
        ],
      ),
    );
  }
}
