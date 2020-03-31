import 'package:corona_trace/ui/widgets/ct_question_pair.dart';
import 'package:corona_trace/ui/widgets/ct_terms_and_conditions.dart';
import 'package:flutter/material.dart';

class CTBottomSheetWidget extends StatelessWidget {
  const CTBottomSheetWidget(
      {this.mainQuestionText,
      this.subSectionDescription,
      this.subHeaderTitleText,
      this.questionPairWidget,
      this.onTermsConditionsClick});

  final String mainQuestionText;
  final String subSectionDescription;
  final String subHeaderTitleText;
  final CTQuestionPair questionPairWidget;
  final Function onTermsConditionsClick;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 20,
                ),
                Text(
                  mainQuestionText,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  subSectionDescription,
                  style: TextStyle(fontSize: 15),
                ),
                subHeaderTitleText != null
                    ? Column(
                        children: <Widget>[
                          SizedBox(
                            height: 25,
                          ),
                          Text(
                            subHeaderTitleText,
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold),
                          )
                        ],
                      )
                    : Container(),
                SizedBox(
                  height: 25,
                ),
                questionPairWidget,
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
        Column(
          children: <Widget>[
            TermsAndConditions(onTermsConditionsClick: onTermsConditionsClick),
            SizedBox(
              height: 30,
            )
          ],
        )
      ],
    );
  }
}
