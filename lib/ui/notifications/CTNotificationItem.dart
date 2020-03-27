import 'package:corona_trace/network/ResponseNotifications.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'CTNotificationMapDetail.dart';

class CTNotificationItem extends StatelessWidget {
  final bool crossedPaths;
  final ResponseNotificationItem notification;

  CTNotificationItem({this.crossedPaths, this.notification});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(height: 4,),
        ListTile(
          leading: crossedPaths
              ? Icon(
                  Icons.info_outline,
                  color: Colors.red,
                )
              : Image.asset("assets/images/green_circle.png"),
          title: Text(
            notification.address,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            "${formattedDate()}",
            style: TextStyle(color: Colors.black),
          ),
          trailing: crossedPaths
              ? Image.asset(
                  "assets/images/map_pin.png",
                )
              : Icon(
                  Icons.build,
                  color: Colors.white,
                ),
        ),
        ListTile(
          title: youMayHaveCrossedPaths(),
          leading: Icon(
            Icons.build,
            color: Colors.white,
          ),
        ),
        crossedPaths
            ? ListTile(
                title: phonesLocation(),
                leading: Icon(
                  Icons.build,
                  color: Colors.white,
                ))
            : Container()
      ],
    );
  }

  Text phonesLocation() {
    return Text(
      "Your phone’s location and time came within a short distance and timeframe as someone who has tested positive for COVID-19.",
      style: TextStyle(fontSize: 16),
    );
  }

  Widget youMayHaveCrossedPaths() {
    return RichText(
      text: new TextSpan(
        style: new TextStyle(
          fontSize: 16.0,
          fontFamily: "Montserrat",
          color: Colors.black,
        ),
        children: <TextSpan>[
          new TextSpan(
              text: 'You '
                  ''),
          new TextSpan(
              text: crossedPaths
                  ? 'may have crossed paths'
                  : 'have not crossed paths',
              style: new TextStyle(fontWeight: FontWeight.bold)),
          new TextSpan(
            text:
                ' with someone who tested positive for COVID-19 since you were out.',
          ),
        ],
      ),
    );
  }

  formattedDate() {
    var format = DateFormat("dd MMMM, hh:mm a");
    try {
      return format
          .format(DateTime.tryParse(notification.timestamp.toString()));
    } catch (ex) {
      return "";
    }
  }
}
