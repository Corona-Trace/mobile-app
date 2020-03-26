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
            CTCoronaTraceCommonHeader(),
            Expanded(
              child: Card(
                margin: EdgeInsets.all(0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15))),
                child: Column(
                  children: <Widget>[
                    Container(
                      child: Padding(
                        padding: EdgeInsets.only(top: 20, left: 20),
                        child: Align(
                          child: Text(
                            "NOTIFICATIONS",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          alignment: Alignment.centerLeft,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: notificationsList(),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      color: Color.fromRGBO(241, 227, 178, 1),
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: 20, bottom: 20, left: 16, right: 16),
                        child: Text(
                            "Please updated your status if you test positive for COVID-19."),
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Container(
                          child: ListTile(
                            title: Text(
                              "No Symptoms",
                              style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text("Your Anonymous Status"),
                            leading: Icon(
                              Icons.remove_circle_outline,
                              color: Colors.green,
                            ),
                          ),
                          height: 100,
                          width: MediaQuery.of(context).size.width * 0.75,
                        ),
                        Row()
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  notificationsList() {
    return ListView.separated(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
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
