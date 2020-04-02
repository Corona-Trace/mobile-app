import 'package:corona_trace/app_constants.dart';
import 'package:corona_trace/network/api_repository.dart';
import 'package:corona_trace/utils/app_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class TermsAndConditions extends StatelessWidget {
  TermsAndConditions({this.onTermsConditionsClick});

  final Function onTermsConditionsClick;

  @override
  Widget build(BuildContext context) {
    return Align(
      child: RichText(
        textAlign: TextAlign.center,
        text: new TextSpan(
          style: Theme.of(context).textTheme.caption.apply(color: Colors.black),
          children: <TextSpan>[
            new TextSpan(text: AppLocalization.text("Legal.I.Accept")),
            new TextSpan(
                text: AppLocalization.text("Legal.Terms.Conditions"),
                recognizer: new TapGestureRecognizer()
                  ..onTap = () {
                    onTermsConditionsClick(ApiRepository.TERMS_AND_CONDITIONS);
                  },
                style: new TextStyle(fontWeight: FontWeight.bold)),
            new TextSpan(text: AppLocalization.text("Legal.And")),
            new TextSpan(
                text: AppLocalization.text("Legal.Privacy.Policy"),
                recognizer: new TapGestureRecognizer()
                  ..onTap = () {
                    onTermsConditionsClick(ApiRepository.PRIVACY_POLICY);
                  },
                style: new TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      ),
      alignment: Alignment.center,
    );
  }
}
