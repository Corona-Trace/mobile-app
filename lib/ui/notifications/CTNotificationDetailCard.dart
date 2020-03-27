import 'package:corona_trace/AppConstants.dart';
import 'package:corona_trace/network/ResponseNotifications.dart';
import 'package:corona_trace/ui/notifications/CTNotificationItem.dart';
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
                    "What do I do now?",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Padding(
                    child: Text(
                      "Please stay home and monitor your health and contact a medical professional if you have any symptoms.",
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
                    "CDC Recommendations",
                    style: TextStyle(
                        color: Colors.indigo, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                      "Center for Disease Conrtorl and Prevention Online Resounces"),
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
                    "Where to Get Tested",
                    style: TextStyle(
                        color: Colors.indigo, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                      "Find a medical facility that offers COVID-19 testing."),
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
