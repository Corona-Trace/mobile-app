import 'package:corona_trace/app_constants.dart';
import 'package:corona_trace/network/notification/response_notification_item.dart';
import 'package:corona_trace/ui/notifications/ct_notification_item.dart';
import 'package:corona_trace/utils/app_localization.dart';
import 'package:flutter/material.dart';

class CTNotificationDetailCard extends StatelessWidget {
  final bool crossedPaths;
  final ResponseNotificationItem notificationItem;

  CTNotificationDetailCard({this.crossedPaths, this.notificationItem});

  @override
  Widget build(BuildContext context) {
    return getNotificationDetail(context);
  }

  getNotificationDetail(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(0),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25), topRight: Radius.circular(25))),
      child: Column(
        children: <Widget>[
          CTNotificationItem(
            crossedPaths: crossedPaths,
            notification: notificationItem,
          ),
          crossedPaths
              ? ListTile(
                  leading: Icon(
                    Icons.info_outline,
                  ),
                  title: Text(
                    AppLocalization.text("CrossedPaths.NextSteps.Title"),
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Padding(
                    child: Text(
                      AppLocalization.text("CrossedPaths.NextSteps.SubTitle"),
                      style: TextStyle(fontSize: 15),
                    ),
                    padding: EdgeInsets.only(top: 10),
                  ),
                )
              : Container(),
          crossedPaths
              ? SizedBox(
                  height: 20,
                )
              : Container(),
          crossedPaths
              ? cdcDocumentation(emptyLeadingSpace: true)
              : Container(),
          crossedPaths ? cdcTesting(emptyLeadingSpace: true) : Container(),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}

ListTile cdcDocumentation({bool emptyLeadingSpace}) {
  return ListTile(
    onTap: () {
      AppConstants.launchUrl(AppConstants.DOCUMENTATION_URL);
    },
    leading: emptyLeadingSpace
        ? Icon(
            Icons.info,
            color: Colors.white,
          )
        : null,
    title: Text(
      AppLocalization.text("CrossedPaths.CDC.Title"),
      style: TextStyle(
          color: Colors.indigo, fontWeight: FontWeight.bold, fontSize: 17),
    ),
    subtitle: Text(AppLocalization.text("CrossedPaths.CDC.SubTitle")),
    trailing: IconButton(
      onPressed: null,
      icon: Icon(
        Icons.arrow_forward,
        color: Colors.indigo,
      ),
    ),
  );
}

ListTile cdcTesting({bool emptyLeadingSpace}) {
  return ListTile(
    onTap: () {
      AppConstants.launchUrl(AppConstants.TESTED_URL);
    },
    leading: emptyLeadingSpace
        ? Icon(
            Icons.info,
            color: Colors.white,
          )
        : null,
    title: Text(
      AppLocalization.text("CrossedPaths.Testing.Title"),
      style: TextStyle(color: Colors.indigo, fontWeight: FontWeight.bold, fontSize: 17),
    ),
    subtitle: Text(AppLocalization.text("CrossedPaths.Testing.SubTitle")),
    trailing: IconButton(
      onPressed: null,
      icon: Icon(
        Icons.arrow_forward,
        color: Colors.indigo,
      ),
    ),
  );
}
