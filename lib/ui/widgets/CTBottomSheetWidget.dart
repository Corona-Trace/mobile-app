import 'package:corona_trace/ui/widgets/CTQuestionPair.dart';
import 'package:flutter/material.dart';

import 'CTTermsAndConditions.dart';

class CTBottomSheetWidget extends StatelessWidget {
  const CTBottomSheetWidget(
      {this.mainQuestionText,
      this.subSectionDescription,
      this.questionPairWidget,
      this.onTermsConditionsClick});

  final String mainQuestionText;
  final String subSectionDescription;
  final CTQuestionPair questionPairWidget;
  final Function onTermsConditionsClick;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          mainQuestionText,
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          subSectionDescription,
          style: TextStyle(fontSize: 16),
        ),
        SizedBox(
          height: 40,
        ),
        questionPairWidget,
        SizedBox(
          height: 20,
        ),
        TermsAndConditions(onTermsConditionsClick: onTermsConditionsClick),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
