import 'package:corona_trace/main.dart';
import 'package:corona_trace/ui/CTCoronaTraceCommonHeader.dart';
import 'package:corona_trace/ui/notifications/CTNotificationMapDetail.dart';
import 'package:corona_trace/ui/widgets/CTHeaderTile.dart';
import 'package:flutter/material.dart';

import 'CTNotificationItem.dart';

class NotificationsListScreen extends StatefulWidget {
  @override
  _NotificationsListScreenState createState() =>
      _NotificationsListScreenState();
}

class _NotificationsListScreenState extends State<NotificationsListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColor,
      body: SafeArea(
        top: false,
        bottom: false,
        child: Column(
          children: <Widget>[
            Container(
              child: CTCoronaTraceCommonHeader(),
            ),
            Expanded(
              child: Container(
                child: Card(
                  margin: EdgeInsets.all(0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15))),
                  child: notificationsList(),
                ),
                height: MediaQuery.of(context).size.height,
              ),
            )
          ],
        ),
      ),
    );
  }

  notificationsList() {
    return ListView.separated(
      separatorBuilder: (context, index) {
        return Divider(
          color: Colors.grey,
        );
      },
      itemBuilder: (context, index) {
        bool crossedPaths = DateTime.now().millisecondsSinceEpoch % 2 == 0;
        return InkWell(
          child: CTNotificationItem(crossedPaths: crossedPaths),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (BuildContext context) {
              return CTNotificationMapDetail(crossedPaths: crossedPaths);
            }));
          },
        );
      },
      itemCount: 10,
    );
  }
}
