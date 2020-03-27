import 'package:flutter/material.dart';

import 'CTQuestion.dart';

class CTQuestionPair extends StatelessWidget {
  const CTQuestionPair(
      {this.positiveQuestionText,
      this.positiveSubtitleBottomQuestionText,
      this.negativeQuestionSubtitleText = "",
      this.negativeQuestionTitleText = "",
      this.neutralQuestionTitleText,
      this.neutralQuestionSubtitleText,
      this.hasCustomColor = false,
      this.customColor,
      this.showArrows = false,
      this.onPositiveQuestionClick,
      this.onNegativeQuestionClick,
      this.onNeutralQuestionClick,
      this.iconPositive,
      this.iconNegative,
      this.iconNeutral});

  final String positiveQuestionText;
  final String positiveSubtitleBottomQuestionText;

  final String negativeQuestionTitleText;
  final String negativeQuestionSubtitleText;

  final neutralQuestionTitleText;
  final neutralQuestionSubtitleText;

  final Function onPositiveQuestionClick;
  final Function onNegativeQuestionClick;
  final Function onNeutralQuestionClick;

  final bool hasCustomColor;
  final Color customColor;
  final bool showArrows;
  final Widget iconPositive;
  final Widget iconNegative;
  final Widget iconNeutral;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Align(
          child: CTQuestion(
              headerText: positiveQuestionText,
              subtitleText: positiveSubtitleBottomQuestionText,
              onClick: onPositiveQuestionClick,
              showArrows: showArrows,
              icon: iconPositive),
          alignment: Alignment.center,
        ),
        SizedBox(
          height: 20,
        ),
        Align(
          child: CTQuestion(
              headerText: negativeQuestionTitleText,
              subtitleText: negativeQuestionSubtitleText,
              onClick: onNegativeQuestionClick,
              hasCustomColor: hasCustomColor,
              customColor: customColor,
              showArrows: showArrows,
              icon: iconNegative),
          alignment: Alignment.center,
        ),
        SizedBox(
          height: 20,
        ),
        neutralQuestionTitleText != null
            ? Align(
                child: CTQuestion(
                    headerText: neutralQuestionTitleText,
                    subtitleText: neutralQuestionSubtitleText,
                    onClick: onNeutralQuestionClick,
                    hasCustomColor: hasCustomColor,
                    customColor: customColor,
                    showArrows: showArrows,
                    icon: iconNeutral),
                alignment: Alignment.center,
              )
            : Container(),
      ],
    );
  }
}
