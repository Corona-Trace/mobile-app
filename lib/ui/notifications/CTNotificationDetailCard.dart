import 'package:corona_trace/AppConstants.dart';
import 'package:corona_trace/network/ResponseNotifications.dart';
import 'package:corona_trace/ui/notifications/CTNotificationItem.dart';
import 'package:corona_trace/utils/AppLocalization.dart';
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
                    style: TextStyle(fontWeight: FontWeight.bold),
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
              ? ListTile(
                  onTap: () {
                    AppConstants.launchUrl(AppConstants.DOCUMENTATION_URL);
                  },
                  leading: Icon(
                    Icons.info,
                    color: Colors.white,
                  ),
                  title: Text(
                    AppLocalization.text("CrossedPaths.CDC.Title"),
                    style: TextStyle(
                        color: Colors.indigo, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                      AppLocalization.text("CrossedPaths.CDC.SubTitle")),
                  trailing: IconButton(
                    icon: Icon(
                      Icons.arrow_forward,
                      color: Colors.indigo,
                    ),
                  ),
                )
              : Container(),
          crossedPaths
              ? ListTile(
                  onTap: () {
                    AppConstants.launchUrl(AppConstants.TESTED_URL);
                  },
                  leading: Icon(
                    Icons.info,
                    color: Colors.white,
                  ),
                  title: Text(
                    AppLocalization.text("CrossedPaths.Testing.Title"),
                    style: TextStyle(
                        color: Colors.indigo, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                      AppLocalization.text("CrossedPaths.Testing.SubTitle")),
                  trailing: IconButton(
                    icon: Icon(
                      Icons.arrow_forward,
                      color: Colors.indigo,
                    ),
                  ),
                )
              : Container(),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
