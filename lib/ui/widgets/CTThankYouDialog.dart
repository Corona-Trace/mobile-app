import 'package:corona_trace/main.dart';
import 'package:corona_trace/ui/widgets/CTTermsAndConditions.dart';
import 'package:corona_trace/utils/AppLocalization.dart';
import 'package:flutter/material.dart';

class CTThankYouDialog extends StatelessWidget {

  CTThankYouDialog({this.onButtonClick});

  final Function onButtonClick;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
              minWidth: constraints.maxWidth, minHeight: constraints.maxHeight),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 30.0,
              ),
              Text(
                AppLocalization.text("Response.ThankYou"),
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                AppLocalization.text("Response.ReportingHelps"),
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(
                height: 100,
              ),
              Align(
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: MaterialButton(
                    color: Color.fromRGBO(71, 93, 243, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(8.0),
                    ),
                    onPressed: onButtonClick,
                    child: Text(
                      AppLocalization.text("Ok"),
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ),
                alignment: Alignment.center,
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      );
    });
  }
}
