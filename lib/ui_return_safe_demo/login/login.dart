import 'package:corona_trace/location_updates.dart';
import 'package:corona_trace/network/api_repository.dart';
import 'package:corona_trace/ui/base_state.dart';
import 'package:corona_trace/ui_return_safe_demo/home_checkin/home_first_checkin.dart';
import 'package:corona_trace/ui_return_safe_demo/onboarding/onboarding_work_together.dart';
import 'package:corona_trace/ui_return_safe_demo/today_checkin/today_checkin_dashboard.dart';
import 'package:corona_trace/ui_v1_1/not_available_yet/onboarding_not_available_yet.dart';
import 'package:corona_trace/utils/app_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginState();
  }
}

class LoginState
    extends BaseState<Login> {
  @override
  Widget prepareWidget(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          key: scaffoldKey,
          backgroundColor: Colors.black,
          body: SingleChildScrollView(child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(left:20, right:20),
                color: Colors.black,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                        color: Colors.black,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              SizedBox(
                                height: 10,
                              ),
                              Align(
                                child: Image(
                                  image: AssetImage(
                                    "assets/images/ey_logo.jpg",
                                  ),
                                ),
                                alignment: Alignment.center,
                              ),
                              SizedBox(
                                height: 10,
                              )
                            ]
                        )
                    ),
                    loginCard(context),
                    Container(
                        color: Colors.black,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              SizedBox(
                                height: 20,
                              ),
                              Align(
                                child: Image(
                                  image: AssetImage(
                                    "assets/images/powered_by_returnsafe.png",
                                  ),
                                ),
                                alignment: Alignment.center,
                              ),
                              SizedBox(
                                height: 30,
                              )
                            ]
                        )
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
      ));
  }

  Card loginCard(BuildContext context) {
  return Card(
    elevation: 4,
    shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(10))),
    child: Padding(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          Text(
            AppLocalization.text("get.started"),
            style: TextStyle(
              fontSize: 20, 
              fontWeight: FontWeight.bold
            )
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            AppLocalization.text("sign.in.subtitle"),
            style: TextStyle(
              fontSize: 15, 
              color: Color(0xff8E8E93),
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 20,
          ),
          TextField(
            decoration: InputDecoration(
              fillColor: Color.fromRGBO(55, 159, 255, 0.2),
              border: OutlineInputBorder(),
              labelText: 'Employee Email',
              focusColor: Color(0xff379FFF),
            ),
          ),
          SizedBox(
            height: 8,
          ),
          TextField(
            obscureText: true,
            decoration: InputDecoration(
              fillColor: Color.fromRGBO(55, 159, 255, 0.2),
              border: OutlineInputBorder(),
              labelText: 'Password',
              focusColor: Color(0xff379FFF),
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
                    "sign.in",
                  ),
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  onPressedBtnLogin(context);
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

  void onPressedBtnLogin(BuildContext context) async {
    Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => OnboardingWorkTogether()),
          (route) => false);
  }

  @override
  String screenName() {
    return "login";
  }
}
