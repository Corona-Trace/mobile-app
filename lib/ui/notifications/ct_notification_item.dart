import 'package:corona_trace/network/repository_notifications.dart';
import 'package:corona_trace/utils/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CTNotificationItem extends StatelessWidget {
  final bool crossedPaths;
  final ResponseNotificationItem notification;

  CTNotificationItem({this.crossedPaths, this.notification});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 4,
        ),
        ListTile(
          leading: crossedPaths
              ? Icon(
                  Icons.info_outline,
                  color: Colors.red,
                )
              : Image.asset("assets/images/green_circle.png"),
          title: Text(
            notification.address,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
          ),
          subtitle: Text(
            "${formattedDate()}",
            style: TextStyle(color: Colors.black, fontSize: 15),
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
      AppLocalization.text("CrossedPaths.PhonesLocation"),
      style: TextStyle(fontSize: 16),
    );
  }

  Widget youMayHaveCrossedPaths() {
    return RichText(
      text: new TextSpan(
        style: new TextStyle(
          fontSize: 15.0,
          fontFamily: "Montserrat",
          color: Colors.black,
        ),
        children: <TextSpan>[
          new TextSpan(text: AppLocalization.text("CrossedPaths.You")),
          new TextSpan(
              text: crossedPaths
                  ? AppLocalization.text("CrossedPaths.HaveCrossed")
                  : AppLocalization.text("CrossedPaths.NotCrossed"),
              style: new TextStyle(fontWeight: FontWeight.bold)),
          new TextSpan(
            text: AppLocalization.text("CrossedPaths.Someone.Positive"),
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
