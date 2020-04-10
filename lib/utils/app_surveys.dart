
import 'package:instabug_flutter/Surveys.dart';

class AppSurveys {
  static final String _crossedPathsNotificationSurveyKey = "y1Ky6wQxoOX3VBwDDLsxFw";
  static final String _rejectedPermissionsSurveyKey = "OGr-ehnX9U6IDWzydPI-Gw";
  static final String _checkInFinishedSurveyKey = "XbSNid1yUA5scqBcmhBamw";
  static final String _appRatingSurveyKey = "1WhxTB6zN7E17GQnwoIh6A";

  static void _triggerSurvey(String surveyKey) {
    Surveys.hasRespondedToSurvey(surveyKey, (bool hasResponded){
      if (!hasResponded) {
        Surveys.showSurvey(surveyKey);
      }
    });
  }

  static void triggerCrossedPathsNotificationSurvey() {
    _triggerSurvey(_crossedPathsNotificationSurveyKey);
  }

  static void triggerRejectedPermissionsSurvey() {
    _triggerSurvey(_rejectedPermissionsSurveyKey);
  }

  static void triggerCheckInFinishedSurvey() {
    Surveys.hasRespondedToSurvey(_checkInFinishedSurveyKey, (bool hasResponded){
      print('Survey: Checkin: responed=$hasResponded');
      if (!hasResponded) {
        Surveys.showSurvey(_checkInFinishedSurveyKey);
        Surveys.setOnDismissCallback((){
          _triggerSurvey(_appRatingSurveyKey);
          Surveys.setOnDismissCallback((){});
        });
      } else {
        _triggerSurvey(_appRatingSurveyKey);
      }
    });
  }
}