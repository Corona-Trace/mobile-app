import 'package:corona_trace/APIRepository.dart';
import 'package:corona_trace/AppConstants.dart';
import 'package:corona_trace/ui/BaseState.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:corona_trace/ui/widgets/CTBottomSheetWidget.dart';
import 'package:corona_trace/ui/widgets/CTQuestionPair.dart';
import 'package:corona_trace/ui/widgets/CTThankYouDialog.dart';
import 'package:corona_trace/ui/widgets/CTHeaderTile.dart';

class UserInfoCollectorScreen extends StatefulWidget {
  @override
  _UserInfoCollectorScreenState createState() =>
      _UserInfoCollectorScreenState();
}

const SCREEN_FEELING_TODAY = 1;
const SCREEN_ACKNOWLEDGEMENT = 2;
const SCREEN_TESTING_INFORMATION = 3;

class _UserInfoCollectorScreenState extends BaseState<UserInfoCollectorScreen> {
  int _currentScreen = SCREEN_FEELING_TODAY;

  @override
  Widget prepareWidget(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: SafeArea(
        top: false,
        bottom: false,
        child: safeAreaContainer(),
      ),
      backgroundColor: Color.fromRGBO(43, 54, 181, 1),
    );
  }

  Widget safeAreaContainer() {
    return Column(
      children: <Widget>[
        Stack(
          children: <Widget>[
            SizedBox(height: 10,),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  backIcon(),
                  CTHeaderTile(),
                  testingInformation()
                ],
              ),
              margin: EdgeInsets.only(top: 50, bottom: 20),
            ),
            Align(
              child: Padding(
                child: Image.asset("assets/combined_shape.png"),
                padding: EdgeInsets.only(top: 20, bottom: 50),
              ),
              alignment: Alignment.topRight,
            ),
          ],
        ),
        Expanded(
          flex: 1,
          child: Align(
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
        )
      ],
    );
  }

  Card getCardBodySeverity() {
    Widget currentScreen = getCurrentScreen();
    return Card(
      margin: EdgeInsets.all(0),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10))),
      child: Padding(
        padding: EdgeInsets.only(left: 20, right: 20, top: 30, bottom: 50),
        child: currentScreen,
      ),
    );
  }

  Widget firstCardContent() {
    Widget questionPair = CTQuestionPair(
        positiveQuestionText: "I am not infected with Coronavirus",
        negativeQuestionText: "I am infected with Coronavirus",
        onNegativeQuestionClick: () async {
          dialogOnResponse(SCREEN_ACKNOWLEDGEMENT);
          FirestoreRepository.setUserSeverity(1);
        },
        onPositiveQuestionClick: () async {
          dialogOnResponse(SCREEN_ACKNOWLEDGEMENT);
          FirestoreRepository.setUserSeverity(0);
        });

    return CTBottomSheetWidget(
        mainQuestionText: "Q. How are you feeling today?",
        subSectionDescription:
            "Don't worry. No personal information will be stored. Your location will be tracked, but all data will be anonymous.",
        questionPairWidget: questionPair,
        onTermsConditionsClick: (String key) async {
          showLoadingDialog(tapDismiss: false);
          String url = await FirestoreRepository.getRemoteConfigValue(key);
          print(url);
          hideLoadingDialog();
          AppConstants.launchUrl(url);
        });
  }

  Widget secondCardContent() {
    return CTThankYouDialog(
      onButtonClick: () {
        dialogOnResponse(SCREEN_FEELING_TODAY);
      },
    );
  }

  Widget testingInformationCardContent() {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 20,
        ),
        Container(
          decoration: new BoxDecoration(
              color: Colors.transparent,
              border: Border.all(color: Colors.indigo),
              borderRadius: new BorderRadius.all(const Radius.circular(8.0))),
          child: ListTile(
            onTap: () {
              AppConstants.launchUrl(AppConstants.TESTED_URL);
            },
            trailing: Icon(Icons.navigate_next, color: Colors.indigo),
            title: Padding(
              child: Text(
                "How to get tested",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              padding: EdgeInsets.all(5),
            ),
            subtitle: Padding(
              child: Text("COVID-19 Testing Resources"),
              padding: EdgeInsets.all(5),
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Container(
          decoration: new BoxDecoration(
              color: Colors.transparent,
              border: Border.all(color: Colors.indigo),
              borderRadius: new BorderRadius.all(const Radius.circular(8.0))),
          child: ListTile(
            onTap: () {
              AppConstants.launchUrl(AppConstants.TESTED_URL);
            },
            trailing: Icon(Icons.navigate_next, color: Colors.indigo),
            title: Padding(
              child: Text("How to get documentation",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              padding: EdgeInsets.all(5),
            ),
            subtitle: Padding(
              child: Text("COVID-19 Testing Documentation Resources"),
              padding: EdgeInsets.all(5),
            ),
          ),
        ),
        SizedBox(
          height: 120,
        ),
      ],
    );
  }

  void dialogOnResponse(screen) {
    setState(() {
      _currentScreen = screen;
    });
  }

  testingInformation() {
    return _currentScreen != SCREEN_TESTING_INFORMATION
        ? Container(
            child: FlatButton(
              shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(8.0),
                  side: BorderSide(color: Colors.indigo.shade300)),
              color: Colors.transparent,
              textColor: Colors.indigo,
              padding: EdgeInsets.all(8.0),
              onPressed: () {
                dialogOnResponse(SCREEN_TESTING_INFORMATION);
              },
              child: Text(
                "Testing Information",
                style: TextStyle(fontSize: 14.0, color: Colors.white),
              ),
            ),
            margin: EdgeInsets.only(left: 20),
          )
        : Container();
  }

  backIcon() {
    return _currentScreen == SCREEN_TESTING_INFORMATION
        ? IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              dialogOnResponse(SCREEN_FEELING_TODAY);
            },
          )
        : Container();
  }

  Widget getCurrentScreen() {
    switch (_currentScreen) {
      case SCREEN_TESTING_INFORMATION:
        {
          return testingInformationCardContent();
        }
        break;
      case SCREEN_FEELING_TODAY:
        {
          return firstCardContent();
        }
        break;
      case SCREEN_ACKNOWLEDGEMENT:
        {
          return secondCardContent();
        }
        break;
    }
    return Container();
  }
}
