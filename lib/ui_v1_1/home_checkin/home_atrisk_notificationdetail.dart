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
              topListTileWithMap(),
              SizedBox(height: 20),
              getNextSteps(),
              SizedBox(height: 20),
              getWatchForSymptomsColumn(),
              getWhenToSeekMedical(),
              SizedBox(height: 20),
              Container(
                child: MaterialButton(
                  height: 50,
                  minWidth: MediaQuery.of(context).size.width * 0.85,
                  color: Color(0xff475DF3),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                  child: Text(
                    AppLocalization.text(
                      "notify.someone",
                    ),
                    style: TextStyle(
                        color: Color(0xffDFE3FF),
                        fontSize: 17,
                        fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {},
                ),
                margin: EdgeInsets.only(bottom: 20),
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
          "Next Steps",
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

  getWatchForSymptomsColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        ListTile(
          title: Text(
            "Watch for these \nsymptoms",
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          subtitle: Padding(
            child: Text(
              "This guidance was sourced from the Center for Disease Control",
              style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff1A1D4A)),
            ),
            padding: EdgeInsets.only(top: 16),
          ),
        ),
        ListTile(
          title: Text(
              "These symptoms may appear 2-14 days after exposure (based on the incubation period of MERS-CoV viruses).",
              style: TextStyle(fontSize: 17, color: Color(0xff1A1D4A))),
        ),
        SizedBox(height: 10),
        ListTile(
          title: Text(
            "•  Fever",
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
            "•  Cough",
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
            "•  Shortness of breath",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }

  getWhenToSeekMedical() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 20),
          Text(
            "When to seek medical attention",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Text(
              "If you develop emergency warning signs for COVID-19 get medical attention immediately. Emergency warning signs include*:",
              style: TextStyle(fontSize: 17)
          ),
          SizedBox(height: 10),
          ListTile(
            title: Text(
              "•  Trouble breathing",
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
              "•  Persistent pain or pressure in the chest",
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
              "•  New confusion or inability to around",
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
              "•  Bluish lips or face",
              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
      color: Color(0xffF3F4FC),
    );
  }
}
