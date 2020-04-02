import 'package:corona_trace/app_constants.dart';
import 'package:corona_trace/location_updates.dart';
import 'package:corona_trace/main.dart';
import 'package:corona_trace/network/api_repository.dart';
import 'package:corona_trace/push_notifications/push_notifications.dart';
import 'package:corona_trace/ui/base_state.dart';
import 'package:corona_trace/ui/ct_common_header.dart';
import 'package:corona_trace/ui/notifications/notification_list_screen.dart';
import 'package:corona_trace/ui/widgets/ct_bottom_sheet_widget.dart';
import 'package:corona_trace/ui/widgets/ct_question_pair.dart';
import 'package:corona_trace/ui/widgets/ct_thank_you_dialog.dart';
import 'package:corona_trace/utils/app_localization.dart';
import 'package:corona_trace/utils/slack.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class UserInfoCollectorScreen extends StatefulWidget {
  @override
  _UserInfoCollectorScreenState createState() =>
      _UserInfoCollectorScreenState();
}

const SCREEN_FEELING_TODAY = 1;
const SCREEN_ACKNOWLEDGEMENT = 2;
const SCREEN_CONFIRM_TESTED_POSITIVE = 4;
const SCREEN_CONFIRM_DO_NOT_HAVE_SYMPTOMS = 5;
const SCREEN_CONFIRM_DO_HAVE_SYMPTOMS = 6;

class _UserInfoCollectorScreenState extends BaseState<UserInfoCollectorScreen> {
  var stack = StackCollect();

  @override
  void initState() {
    super.initState();
    stack.push(SCREEN_FEELING_TODAY);
    PushNotifications.initStuff();
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
      setState(() {});
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
        positiveQuestionText: AppLocalization.text("YES"),
        positiveSubtitleBottomQuestionText:
            AppLocalization.text("Tested.Positive.COVID"),
        negativeQuestionTitleText: AppLocalization.text("NO"),
        negativeQuestionSubtitleText: AppLocalization.text("Symptoms.None"),
        neutralQuestionTitleText: AppLocalization.text("Symptoms.Some"),
        neutralQuestionSubtitleText:
            AppLocalization.text("Symptoms.Not.Tested"),
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
        headerText: AppLocalization.text("Question.Test.Positive"),
        subHeaderText: AppLocalization.text("Answer.Anonymous"),
        subHeaderTitleText: AppLocalization.text("Answer.select"),
        questionPair: questionPair);
  }

  Widget confirmTestedPositiveCardContent() {
    Widget questionPair = CTQuestionPair(
        positiveQuestionText: AppLocalization.text("CANCEL"),
        positiveSubtitleBottomQuestionText: "",
        negativeQuestionTitleText: AppLocalization.text("YES"),
        negativeQuestionSubtitleText:
            AppLocalization.text("Tested.Positive.COVID.Location.Usage"),
        hasCustomColor: true,
        customColor: Color.fromRGBO(219, 102, 81, 1),
        onNegativeQuestionClick: () async {
          showLoadingDialog(tapDismiss: false);
          var value = await LocationUpdates.initiateLocationUpdates(context);
          if (value) {
            await ApiRepository.setUserSeverity(1);
            dialogOnResponse(SCREEN_ACKNOWLEDGEMENT);
          }
          hideLoadingDialog();
        },
        onPositiveQuestionClick: () async {
          await onClickCancel();
        });

    return getBottomSheetWidget(
        headerText: AppLocalization.text("Answer.Confirm"),
        subHeaderText: AppLocalization.text("Answer.Confirm.Location.Usage"),
        questionPair: questionPair);
  }

  Future onClickCancel() async {
    var severity = await ApiRepository.getUserSeverity();
    if (severity == null || (severity != null && severity == -1)) {
    } else {
      showLoadingDialog(tapDismiss: false);
      await ApiRepository.setUserSeverity(-1);
      hideLoadingDialog();
      LocationUpdates.stopLocationUpdates(context);
    }
    _onPopScope();
  }

  Widget confirmDoHaveSymptomsCardContent() {
    Widget questionPair = CTQuestionPair(
        negativeQuestionSubtitleText:
            AppLocalization.text("Symptoms.Not.Tested"),
        positiveQuestionText: AppLocalization.text("CANCEL"),
        negativeQuestionTitleText: AppLocalization.text("Symptoms.Some"),
        positiveSubtitleBottomQuestionText: "",
        hasCustomColor: true,
        customColor: Color.fromRGBO(240, 193, 28, 1),
        onPositiveQuestionClick: () async {
          await onClickCancel();
        },
        onNegativeQuestionClick: () async {
          showLoadingDialog(tapDismiss: false);
          var value = await LocationUpdates.initiateLocationUpdates(context);
          if (value) {
            await ApiRepository.setUserSeverity(2);
            dialogOnResponse(SCREEN_ACKNOWLEDGEMENT);
          }
          hideLoadingDialog();
        });

    return getBottomSheetWidget(
        headerText: AppLocalization.text("Answer.Confirm"),
        subHeaderText: AppLocalization.text("Answer.Confirm.Location.Usage"),
        questionPair: questionPair);
  }

  Widget confirmDoNotHaveSymptomsCardContent() {
    Widget questionPair = CTQuestionPair(
        negativeQuestionSubtitleText: AppLocalization.text("Symptoms.None"),
        positiveQuestionText: AppLocalization.text("CANCEL"),
        negativeQuestionTitleText: AppLocalization.text("NO"),
        positiveSubtitleBottomQuestionText: "",
        hasCustomColor: true,
        customColor: Colors.green,
        onPositiveQuestionClick: () async {
          await onClickCancel();
        },
        onNegativeQuestionClick: () async {
          showLoadingDialog(tapDismiss: false);
          var value = await LocationUpdates.initiateLocationUpdates(context);
          if (value) {
            await ApiRepository.setUserSeverity(0);
            dialogOnResponse(SCREEN_ACKNOWLEDGEMENT);
          }
          hideLoadingDialog();
        });

    return getBottomSheetWidget(
        headerText: AppLocalization.text("Answer.Confirm"),
        subHeaderText: AppLocalization.text("Answer.Confirm.Location.Usage"),
        questionPair: questionPair);
  }

  Widget thankYouCardContent() {
    return CTThankYouDialog(onButtonClick: () {
      stack = StackCollect();
      dialogOnResponse(SCREEN_FEELING_TODAY);
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (BuildContext context) {
        return NotificationsListScreen();
      }), (route) => false);
    });
  }

  void dialogOnResponse(screen) {
    setState(() {
      stack.push(screen);
    });
  }

  CTBottomSheetWidget getBottomSheetWidget(
      {CTQuestionPair questionPair,
      String headerText,
      String subHeaderText,
      String subHeaderTitleText}) {
    return CTBottomSheetWidget(
        mainQuestionText: headerText,
        subSectionDescription: subHeaderText,
        subHeaderTitleText: subHeaderTitleText,
        questionPairWidget: questionPair,
        onTermsConditionsClick: (String url) async {
          AppConstants.launchUrl(url);
        });
  }

  Widget getCurrentScreen() {
    switch (stack.top()) {
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
