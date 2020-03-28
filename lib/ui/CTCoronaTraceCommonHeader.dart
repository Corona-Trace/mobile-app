import 'package:corona_trace/ui/widgets/CTHeaderTile.dart';
import 'package:corona_trace/utils/AppLocalization.dart';
import 'package:flutter/material.dart';

class CTCoronaTraceCommonHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                child: Text(
                  AppLocalization.text("Coronatrace"),
                  style: TextStyle(
                      color: Color.fromRGBO(254, 198, 208, 1),
                      fontSize: 16),
                ),
                padding:
                EdgeInsets.only(top: 20, bottom: 5, left: 20),
              ),
              CTHeaderTile(AppLocalization.text("Coronatrace.Tagline"),
                  AppLocalization.text("Coronatrace.SubTagline")),
            ],
          ),
          margin: EdgeInsets.only(top: 20, right: 20),
        ),
        Align(
          child: Container(
            margin: EdgeInsets.only(top: 80),
            child: Image.asset(
              "assets/images/oval_notification.png",
            ),
          ),
          alignment: Alignment.centerRight,
        ),
      ],
    );
  }
}
