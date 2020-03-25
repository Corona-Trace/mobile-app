import 'package:flutter/material.dart';

import 'CTQuestion.dart';

class CTQuestionPair extends StatelessWidget {
  const CTQuestionPair(
      {this.topQuestionText,
      this.bottomQuestionText,
      this.bottomQuestionSubtitleText = "",
      this.topQuestionSubtitleText = "",
      this.showBottomAsRed = false,
      this.showArrows = false,
      this.onTopQuestionClick,
      this.onBottomQuestionClick});

  final String topQuestionText;
  final String bottomQuestionText;

  final String topQuestionSubtitleText;
  final String bottomQuestionSubtitleText;

  final Function onTopQuestionClick;
  final Function onBottomQuestionClick;

  final bool showBottomAsRed;
  final bool showArrows;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Align(
          child: CTQuestion(
            headerText: topQuestionText,
            subtitleText: topQuestionSubtitleText,
            onClick: onTopQuestionClick,
            showArrows: showArrows,
          ),
          alignment: Alignment.center,
        ),
        SizedBox(
          height: 20,
        ),
        Align(
          child: CTQuestion(
            headerText: bottomQuestionText,
            subtitleText: bottomQuestionSubtitleText,
            onClick: onBottomQuestionClick,
            showAsRed: showBottomAsRed,
            showArrows: showArrows,
          ),
          alignment: Alignment.center,
        ),
      ],
    );
  }
}
