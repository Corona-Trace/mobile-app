import 'package:corona_trace/LocationUpdates.dart';
import 'package:corona_trace/main.dart';
import 'package:corona_trace/network/APIRepository.dart';
import 'package:corona_trace/AppConstants.dart';
import 'package:corona_trace/network/ResponseNotifications.dart';
import 'package:corona_trace/push_notifications/push_notifications.dart';
import 'package:corona_trace/ui/BaseState.dart';
import 'package:corona_trace/ui/CTCoronaTraceCommonHeader.dart';
import 'package:corona_trace/ui/notifications/CTNotificationMapDetail.dart';
import 'package:corona_trace/ui/notifications/NotificationsListScreen.dart';
import 'package:corona_trace/ui/widgets/CTBottomSheetWidget.dart';
import 'package:corona_trace/ui/widgets/CTHeaderTile.dart';
import 'package:corona_trace/ui/widgets/CTQuestionPair.dart';
import 'package:corona_trace/ui/widgets/CTTestingInformation.dart';
import 'package:corona_trace/ui/widgets/CTThankYouDialog.dart';
import 'package:corona_trace/utils/Stack.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserInfoCollectorScreen extends StatefulWidget {
  @override
  _UserInfoCollectorScreenState createState() =>
      _UserInfoCollectorScreenState();
}

const SCREEN_FEELING_TODAY = 1;
const SCREEN_ACKNOWLEDGEMENT = 2;
const SCREEN_TESTING_INFORMATION = 3;
const SCREEN_CONFIRM_TESTED_POSITIVE = 4;
const SCREEN_CONFIRM_DO_NOT_HAVE_SYMPTOMS = 5;
const SCREEN_CONFIRM_DO_HAVE_SYMPTOMS = 6;



class _UserInfoCollectorScreenState extends BaseState<UserInfoCollectorScreen> {
  int _currentScreen = SCREEN_FEELING_TODAY;
  var stack = StackCollect();
  PushNotifications _pushNotifications = PushNotifications();

  @override
  void initState() {
    super.initState();
    stack.push(_currentScreen);
    Future.delayed(Duration(seconds: 5)).then((value) => _pushNotifications.sendAndRetrieveMessage());
  }

  @override
  Widget prepareWidget(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        key: scaffoldKey,
        body: SafeArea(
          top: false,
          bottom: false,
          child: safeAreaContainer(),
        ),
        backgroundColor: appColor,
      ),
      onWillPop: _onPopScope,
    );
  }

  Future<bool> _onPopScope() async {
    stack.pop();
    if (stack.isEmpty) {
      return true;
    } else {
      setState(() {
        _currentScreen = stack.top();
      });
    }
    return false;
  }

  Widget safeAreaContainer() {
    return Column(
      children: <Widget>[
        CTCoronaTraceCommonHeader(),
        Expanded(
          child: getCardBodySeverity(),
        )
      ],
    );
  }

  Card getCardBodySeverity() {
    return Card(
      margin: EdgeInsets.all(0),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15), topRight: Radius.circular(15))),
      child: Padding(
        padding: EdgeInsets.only(left: 20, right: 20),
        child: getCurrentScreen(),
      ),
    );
  }

  Widget firstCardContent() {
    Widget questionPair = CTQuestionPair(
        positiveQuestionText: "YES",
        positiveSubtitleBottomQuestionText: "I tested positive for COVID-19",
        negativeQuestionTitleText: "NO",
        negativeQuestionSubtitleText: "I do not have any symptoms",
        neutralQuestionTitleText: "NO, BUT I HAVE SYMPTOMS",
        neutralQuestionSubtitleText: "I have symptoms but have not tested",
        showArrows: true,
        iconPositive: Icon(
          Icons.add_circle_outline,
          color: Colors.red,
        ),
        iconNegative: Icon(
          Icons.remove_circle_outline,
          color: Colors.green,
        ),
        iconNeutral: Image.asset(
          "assets/images/help_circle.png",
        ),
        onNeutralQuestionClick: () async {
          dialogOnResponse(SCREEN_CONFIRM_DO_HAVE_SYMPTOMS);
        },
        onNegativeQuestionClick: () async {
          dialogOnResponse(SCREEN_CONFIRM_DO_NOT_HAVE_SYMPTOMS);
        },
        onPositiveQuestionClick: () async {
          dialogOnResponse(SCREEN_CONFIRM_TESTED_POSITIVE);
        });

    return getBottomSheetWidget(
        headerText: "Have you tested positive for COVID-19?",
        subHeaderText:
            "Your answer is completely anonymous and no personal information will ever be stored.\n\nSelect an answer to continue.",
        questionPair: questionPair);
  }

  Widget confirmTestedPositiveCardContent() {
    Widget questionPair = CTQuestionPair(
        positiveQuestionText: "CANCEL",
        positiveSubtitleBottomQuestionText: "",
        negativeQuestionTitleText: "YES",
        negativeQuestionSubtitleText:
            "I tested positive for COVID-19, use my location anonymously",
        hasCustomColor: true,
        customColor: Color.fromRGBO(219, 102, 81, 1),
        onNegativeQuestionClick: () async {
          dialogOnResponse(SCREEN_ACKNOWLEDGEMENT);
          ApiRepository.setUserSeverity(1);
        },
        onPositiveQuestionClick: () async {
          _onPopScope();
        });

    return getBottomSheetWidget(
        headerText: "Please confirm your answer to continue.",
        subHeaderText:
            "Confirm your answer and CoronaTrace will timestamp and use your location anonymously to help stop the spread of COVID-19.",
        questionPair: questionPair);
  }

  Widget confirmDoHaveSymptomsCardContent() {
    Widget questionPair = CTQuestionPair(
        negativeQuestionSubtitleText: "I have symptoms but I have not tested",
        positiveQuestionText: "CANCEL",
        negativeQuestionTitleText: "NO, BUT I HAVE SYMPTOMS",
        positiveSubtitleBottomQuestionText: "",
        hasCustomColor: true,
        customColor: Color.fromRGBO(240, 193, 28, 1),
        onPositiveQuestionClick: () async {
          _onPopScope();
        },
        onNegativeQuestionClick: () async {
          dialogOnResponse(SCREEN_ACKNOWLEDGEMENT);
          ApiRepository.setUserSeverity(0);
        });

    return getBottomSheetWidget(
        headerText: "Please confirm your answer to continue.",
        subHeaderText:
            "Confirm your answer and CoronaTrace will timestamp and use your location anonymously to help stop the spread of COVID-19.",
        questionPair: questionPair);
  }

  Widget confirmDoNotHaveSymptomsCardContent() {
    Widget questionPair = CTQuestionPair(
        negativeQuestionSubtitleText: "I DO NOT HAVE ANY SYMPTOMS",
        positiveQuestionText: "CANCEL",
        negativeQuestionTitleText: "NO",
        positiveSubtitleBottomQuestionText: "",
        hasCustomColor: true,
        customColor: Colors.green,
        onPositiveQuestionClick: () async {
          _onPopScope();
        },
        onNegativeQuestionClick: () async {
          dialogOnResponse(SCREEN_ACKNOWLEDGEMENT);
          ApiRepository.setUserSeverity(0);
        });

    return getBottomSheetWidget(
        headerText: "Please confirm your answer to continue.",
        subHeaderText:
            "Confirm your answer and CoronaTrace will timestamp and use your location anonymously to help stop the spread of COVID-19.",
        questionPair: questionPair);
  }

  Widget thankYouCardContent() {
    return CTThankYouDialog(onButtonClick: () {
      _onPopScope();
      Navigator.push(context,
          MaterialPageRoute(builder: (BuildContext context) {
        return NotificationsListScreen();
      }));
    });
  }

  void dialogOnResponse(screen) {
    setState(() {
      _currentScreen = screen;
      stack.push(_currentScreen);
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
                style: TextStyle(fontSize: 16.0, color: Colors.white),
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
              _onPopScope();
            },
          )
        : Container();
  }

  CTBottomSheetWidget getBottomSheetWidget(
      {CTQuestionPair questionPair, String headerText, String subHeaderText}) {
    return CTBottomSheetWidget(
        mainQuestionText: headerText,
        subSectionDescription: subHeaderText,
        questionPairWidget: questionPair,
        onTermsConditionsClick: (String key) async {
          showLoadingDialog(tapDismiss: false);
          String url = await ApiRepository.getRemoteConfigValue(key);
          print(url);
          hideLoadingDialog();
          AppConstants.launchUrl(url);
        });
  }

  Widget getCurrentScreen() {
    switch (_currentScreen) {
      case SCREEN_TESTING_INFORMATION:
        {
          return CTTestingInformation();
        }
        break;
      case SCREEN_FEELING_TODAY:
        {
          return firstCardContent();
        }
        break;
      case SCREEN_ACKNOWLEDGEMENT:
        {
          return thankYouCardContent();
        }
        break;
      case SCREEN_CONFIRM_TESTED_POSITIVE:
        {
          return confirmTestedPositiveCardContent();
        }
        break;
      case SCREEN_CONFIRM_DO_NOT_HAVE_SYMPTOMS:
        {
          return confirmDoNotHaveSymptomsCardContent();
        }
        break;
      case SCREEN_CONFIRM_DO_HAVE_SYMPTOMS:
        {
          return confirmDoHaveSymptomsCardContent();
        }
    }
    return Container();
  }


}
