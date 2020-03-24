import 'package:flutter/material.dart';

class CTQuestionPair extends StatelessWidget {
  const CTQuestionPair(
      {this.positiveQuestionText,
      this.negativeQuestionText,
      this.onPositiveQuestionClick,
      this.onNegativeQuestionClick});

  final String positiveQuestionText;
  final String negativeQuestionText;

  final Function onPositiveQuestionClick;
  final Function onNegativeQuestionClick;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Align(
          child: SizedBox(
            width: double.infinity,
            height: 50,
            child: MaterialButton(
              color: Colors.red,
              shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(8.0),
              ),
              onPressed: onNegativeQuestionClick,
              child: Text(
                negativeQuestionText,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          ),
          alignment: Alignment.center,
        ),
        SizedBox(
          height: 10,
        ),
        Align(
          child: SizedBox(
            width: double.infinity,
            child: MaterialButton(
              color: Colors.green,
              height: 50,
              shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(8.0),
              ),
              onPressed: onPositiveQuestionClick,
              child: Text(
                positiveQuestionText,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          ),
          alignment: Alignment.center,
        ),
      ],
    );
  }
}
