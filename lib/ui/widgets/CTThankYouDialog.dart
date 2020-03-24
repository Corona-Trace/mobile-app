import 'package:flutter/material.dart';

class CTThankYouDialog extends StatelessWidget {
  CTThankYouDialog({this.onButtonClick});

  final Function onButtonClick;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "Thank you for your response!",
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          "Thank you for joining hands and helping humanity. Remember you can always comeback and submit an updated status.",
          style: TextStyle(fontSize: 16),
        ),
        SizedBox(
          height: 160,
        ),
        Align(
          child: SizedBox(
            width: double.infinity,
            height: 50,
            child: MaterialButton(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(8.0),
                side: BorderSide(color: Colors.black),
              ),
              onPressed: onButtonClick,
              child: Text(
                "Got It",
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),
            ),
          ),
          alignment: Alignment.center,
        )
      ],
    );
  }
}
