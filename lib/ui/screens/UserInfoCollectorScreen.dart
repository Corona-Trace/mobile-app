import 'package:corona_trace/APIRepository.dart';
import 'package:corona_trace/AppConstants.dart';
import 'package:corona_trace/ui/BaseState.dart';
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
        Stack(
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
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
              child: Container(
                margin: EdgeInsets.only(top: 80),
                transform: Matrix4.translationValues(20.0, 0.0, 0.0),
                child: Image.asset(
                  "assets/combined_shape.png",
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
        SizedBox(
          height: 10,
        ),
        Expanded(
          child: SingleChildScrollView(
            controller: _scrollController,
            child: getCardBodySeverity(),
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
        padding: EdgeInsets.only(left: 20, right: 20, top: 30, bottom: 50),
        child: getCurrentScreen(),
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
    return CTTestingInformation();
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
