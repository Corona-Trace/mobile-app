import 'package:corona_trace/APIRepository.dart';
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
          child: CTHeaderTile(),
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

  Widget firstCardContent() {
    Widget questionPair = CTQuestionPair(
        positiveQuestionText: "I am not infected with Coronavirus",
        negativeQuestionText: "I am infected with Coronavirus",
        onNegativeQuestionClick: () async {
          dialogOnResponse(2);
          FirestoreRepository.setUserSeverity(1);
        },
        onPositiveQuestionClick: () async {
          dialogOnResponse(2);
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
          if (await canLaunch(url)) {
            await launch(url);
          }
        });
  }

  Widget secondCardContent() {
    return CTThankYouDialog(
      onButtonClick: () {
        dialogOnResponse(1);
      },
    );
  }

  void dialogOnResponse(screen) async {
    setState(() {
      _currentScreen = screen;
    });
  }
}
