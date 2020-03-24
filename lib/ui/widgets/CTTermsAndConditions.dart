import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

const TERMS_AND_CONDITIONS = "TERMS_AND_CONDITIONS";
const PRIVACY_POLICY = "PRIVACY_POLICY";

class TermsAndConditions extends StatelessWidget {
  TermsAndConditions({this.onTermsConditionsClick});

  final Function onTermsConditionsClick;

  @override
  Widget build(BuildContext context) {
    return Align(
      child: RichText(
        textAlign: TextAlign.center,
        text: new TextSpan(
          style: new TextStyle(
            fontSize: 14.0,
            color: Colors.black,
          ),
          children: <TextSpan>[
            new TextSpan(
                text: 'By responding, I accept the\n'
                    ''),
            new TextSpan(
                text: 'Terms and Conditions ',
                recognizer: new TapGestureRecognizer()
                  ..onTap = () {
                    onTermsConditionsClick(TERMS_AND_CONDITIONS);
                  },
                style: new TextStyle(fontWeight: FontWeight.bold)),
            new TextSpan(text: ' and '),
            new TextSpan(
                text: ' Privacy Policy.',
                recognizer: new TapGestureRecognizer()
                  ..onTap = () {
                    onTermsConditionsClick(PRIVACY_POLICY);
                  },
                style: new TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      ),
      alignment: Alignment.center,
    );
  }
}
