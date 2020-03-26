import 'package:corona_trace/network/APIRepository.dart';
import 'package:corona_trace/AppConstants.dart';
import 'package:corona_trace/ui/BaseState.dart';
import 'package:corona_trace/ui/notifications/CTNotificationMapDetail.dart';
import 'package:corona_trace/ui/notifications/NotificationsListScreen.dart';
import 'package:corona_trace/ui/widgets/CTBottomSheetWidget.dart';
import 'package:corona_trace/ui/widgets/CTHeaderTile.dart';
import 'package:corona_trace/ui/widgets/CTQuestionPair.dart';
import 'package:corona_trace/ui/widgets/CTTestingInformation.dart';
import 'package:corona_trace/ui/widgets/CTThankYouDialog.dart';
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

class _UserInfoCollectorScreenState extends BaseState<UserInfoCollectorScreen> {
  int _currentScreen = SCREEN_FEELING_TODAY;

  var _scrollController = ScrollController();

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
        Expanded(
          child: Stack(
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    backIcon(),
                    CTHeaderTile("Help Save Lives!",
                        "WHO announces COVID-19\noutbreak a pandemic"),
                    testingInformation()
                  ],
                ),
                margin: EdgeInsets.only(top: 50, bottom: 20),
              ),
              Align(
                child: Container(
                  margin: EdgeInsets.only(top: 80),
                  transform: Matrix4.translationValues(20.0, 0.0, 0.0),
                  child: Image.asset(
                    "assets/images/combined_shape.png",
                    height: 150,
                    width: 150,
                  ),
                ),
                alignment: Alignment.topRight,
              ),
              SizedBox(
                height: 30,
              ),
            ],
          ),
          flex: 1,
        ),
        Expanded(
          child: SingleChildScrollView(
            controller: _scrollController,
            child: Container(
              child: getCardBodySeverity(),
              height: MediaQuery.of(context).size.height / 2,
            ),
          ),
          flex: 1,
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
        topQuestionText: "YES",
        topQuestionSubtitleText: "I tested positive for COVID-19",
        bottomQuestionText: "NO",
        bottomQuestionSubtitleText: "I do not have any symptoms",
        showArrows: true,
        onBottomQuestionClick: () async {
          dialogOnResponse(SCREEN_CONFIRM_DO_NOT_HAVE_SYMPTOMS);
        },
        onTopQuestionClick: () async {
          dialogOnResponse(SCREEN_CONFIRM_TESTED_POSITIVE);
        });

    return getBottomSheetWidget(
        headerText: "Have you tested positive for COVID-19?",
        subHeaderText:
            "Select an answer to proceed.\n\nYour answer is completely anonymous and no personal information will ever be stored.",
        questionPair: questionPair);
  }

  Widget confirmTestedPositiveCardContent() {
    Widget questionPair = CTQuestionPair(
        topQuestionText: "CANCEL",
        bottomQuestionText: "YES",
        bottomQuestionSubtitleText:
            "I tested positive for COVID-19, use my location anonymously",
        showBottomAsRed: true,
        onBottomQuestionClick: () async {
          dialogOnResponse(SCREEN_ACKNOWLEDGEMENT);
          ApiRepository.setUserSeverity(1);
        },
        onTopQuestionClick: () async {
          dialogOnResponse(SCREEN_FEELING_TODAY);
        });

    return getBottomSheetWidget(
        headerText: "Please confirm your answer to continue.",
        subHeaderText:
            "Confirm your answer and CoronaTrace will timestamp and use your location anonymously to help stop the spread of COVID-19.",
        questionPair: questionPair);
  }

  Widget confirmDoNotHaveSymptomsCardContent() {
    Widget questionPair = CTQuestionPair(
        bottomQuestionText: "I DO NOT HAVE ANY SYMPTOMS",
        topQuestionText: "CANCEL",
        onTopQuestionClick: () async {
          dialogOnResponse(SCREEN_FEELING_TODAY);
        },
        onBottomQuestionClick: () async {
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
    return CTThankYouDialog(
      onButtonClick: () {
        dialogOnResponse(SCREEN_FEELING_TODAY);
        Navigator.push(context,
            MaterialPageRoute(builder: (BuildContext context) {
          return NotificationsListScreen();
        }));
      },
    );
  }

  void dialogOnResponse(screen) {
    setState(() {
      _currentScreen = screen;
    });
    // needed for small screens
    _scrollController.animateTo(0,
        duration: Duration(milliseconds: 200), curve: Curves.linear);
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
              dialogOnResponse(SCREEN_FEELING_TODAY);
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
    }
    return Container();
  }
}
