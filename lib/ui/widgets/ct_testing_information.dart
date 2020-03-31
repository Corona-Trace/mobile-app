import 'package:corona_trace/app_constants.dart';
import 'package:corona_trace/utils/app_localization.dart';
import 'package:flutter/material.dart';

import 'ct_question.dart';

class CTTestingInformation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 20,
        ),
        CTQuestion(
          headerText: AppLocalization.text("Testing.How"),
          subtitleText: AppLocalization.text("Testing.Resources"),
          showArrows: true,
          onClick: () {
            AppConstants.launchUrl(AppConstants.TESTED_URL);
          },
        ),
        SizedBox(
          height: 20,
        ),
        CTQuestion(
          headerText: AppLocalization.text("Documentation.How"),
          subtitleText: AppLocalization.text("Documentation.Resources"),
          showArrows: true,
          onClick: () {
            AppConstants.launchUrl(AppConstants.TESTED_URL);
          },
        ),
      ],
    );
  }
}
