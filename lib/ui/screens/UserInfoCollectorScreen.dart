import 'package:corona_trace/APIRepository.dart';
import 'package:corona_trace/ui/BaseState.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class UserInfoCollectorScreen extends StatefulWidget {
  @override
  _UserInfoCollectorScreenState createState() =>
      _UserInfoCollectorScreenState();
}

const TERMS_AND_CONDITIONS = "TERMS_AND_CONDITIONS";
const PRIVACY_POLICY = "PRIVACY_POLICY";
const DISTANCE_DISPLACEMENT_FACTOR = "DISTANCE_DISPLACEMENT_FACTOR";

class _UserInfoCollectorScreenState extends BaseState<UserInfoCollectorScreen> {
  int _currentScreen = 1;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget prepareWidget(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: SafeArea(
        bottom: false,
        child: safeAreaContainer(),
      ),
      backgroundColor: Color.fromRGBO(43, 54, 181, 1),
    );
  }

  Stack safeAreaContainer() {
    return Stack(
      children: <Widget>[
        Container(
          child: getHeaderListTile(),
          margin: EdgeInsets.only(top: 50, bottom: 20),
        ),
        Align(
          child: Padding(
            child: Image.asset("assets/combined_shape.png"),
            padding: EdgeInsets.only(top: 20, bottom: 50),
          ),
          alignment: Alignment.topRight,
        ),
        Align(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 200,
                ),
                getCardBodySeverity()
              ],
            ),
          ),
          alignment: Alignment.bottomCenter,
        ),
      ],
    );
  }

  Card getCardBodySeverity() {
    return Card(
      margin: EdgeInsets.all(0),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10))),
      child: Padding(
        padding: EdgeInsets.only(left: 20, right: 20, top: 30, bottom: 50),
        child: _currentScreen == 1 ? firstCardContent() : secondCardContent(),
      ),
    );
  }

  Column firstCardContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "Q. How are you feeling today?",
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          "Don’t worry. No personal information will be stored. Your location will be tracked, but all data will be anonymous.",
          style: TextStyle(fontSize: 16),
        ),
        SizedBox(
          height: 80,
        ),
        Align(
          child: SizedBox(
            width: double.infinity,
            height: 50,
            child: MaterialButton(
              color: Colors.red,
              shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(8.0),
              ),
              onPressed: () async {
                dialogOnResponse(2);
                FirestoreRepository.setUserSeverity(1);
              },
              child: Text(
                "I am infected with Coronavirus",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          ),
          alignment: Alignment.center,
        ),
        SizedBox(
          height: 10,
        ),
        Align(
          child: SizedBox(
            width: double.infinity,
            child: MaterialButton(
              color: Colors.green,
              height: 50,
              shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(8.0),
              ),
              onPressed: () async {
                dialogOnResponse(2);
                FirestoreRepository.setUserSeverity(0);
              },
              child: Text(
                "I am not infected with Coronavirus",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          ),
          alignment: Alignment.center,
        ),
        SizedBox(
          height: 20,
        ),
        Align(
          child: RichText(
            textAlign: TextAlign.center,
            text: new TextSpan(
              // Note: Styles for TextSpans must be explicitly defined.
              // Child text spans will inherit styles from parent
              style: new TextStyle(
                fontSize: 14.0,
                color: Colors.black,
              ),
              children: <TextSpan>[
                new TextSpan(
                    text: 'By responding, I accept the\n'
                        ''),
                new TextSpan(
                    text: 'Terms and Conditions ',
                    recognizer: new TapGestureRecognizer()
                      ..onTap = () {
                        launchWebUrl(TERMS_AND_CONDITIONS);
                      },
                    style: new TextStyle(fontWeight: FontWeight.bold)),
                new TextSpan(text: ' and '),
                new TextSpan(
                    text: ' Privacy Policy.',
                    recognizer: new TapGestureRecognizer()
                      ..onTap = () {
                        launchWebUrl(PRIVACY_POLICY);
                      },
                    style: new TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          alignment: Alignment.center,
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }

  Column secondCardContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "Thank you for your response!",
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          "Thank you for joining hands and helping humanity. Remember you can always comeback and submit an updated status.",
          style: TextStyle(fontSize: 16),
        ),
        SizedBox(
          height: 160,
        ),
        Align(
          child: SizedBox(
            width: double.infinity,
            height: 50,
            child: MaterialButton(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(8.0),
                side: BorderSide(color: Colors.black),
              ),
              onPressed: () {
                dialogOnResponse(1);
              },
              child: Text(
                "Got It",
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),
            ),
          ),
          alignment: Alignment.center,
        )
      ],
    );
  }

  void dialogOnResponse(screen) async {
    setState(() {
      _currentScreen = screen;
    });
  }

  ListTile getHeaderListTile() {
    return ListTile(
      title: Text(
        "Help Save Lives!",
        style: TextStyle(
            color: Color.fromRGBO(254, 198, 208, 1),
            fontSize: 28,
            fontWeight: FontWeight.bold),
      ),
      subtitle: Padding(
        child: Text(
          "WHO announces COVID-19\noutbreak a pandemic",
          style:
              TextStyle(color: Color.fromRGBO(254, 198, 208, 1), fontSize: 20),
        ),
        padding: EdgeInsets.only(top: 20, bottom: 20),
      ),
    );
  }

  void launchWebUrl(String key) async {
    showLoadingDialog(tapDismiss: false);
    String url = await FirestoreRepository.getRemoteConfigValue(key);
    print(url);
    hideLoadingDialog();
    if (await canLaunch(url)) {
      await launch(url);
    }
  }
}
