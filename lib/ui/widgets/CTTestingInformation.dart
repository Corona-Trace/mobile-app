import 'package:corona_trace/AppConstants.dart';
import 'package:flutter/material.dart';

import 'CTQuestion.dart';

class CTTestingInformation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 20,
        ),
        CTQuestion(
          headerText: "How to get tested",
          subtitleText: "COVID-19 Testing Resources",
          showArrows: true,
          onClick: () {
            AppConstants.launchUrl(AppConstants.TESTED_URL);
          },
        ),
        SizedBox(
          height: 20,
        ),
        CTQuestion(
          headerText: "How to get documentation",
          subtitleText: "COVID-19 Testing Documentation Resources",
          showArrows: true,
          onClick: () {
            AppConstants.launchUrl(AppConstants.TESTED_URL);
          },
        ),
      ],
    );
  }
}
