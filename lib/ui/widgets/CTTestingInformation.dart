import 'package:corona_trace/AppConstants.dart';
import 'package:flutter/material.dart';

class CTTestingInformation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 20,
        ),
        Container(
          decoration: new BoxDecoration(
              color: Colors.transparent,
              border: Border.all(color: Colors.indigo.shade400),
              borderRadius: new BorderRadius.all(const Radius.circular(8.0))),
          child: ListTile(
            onTap: () {
              AppConstants.launchUrl(AppConstants.TESTED_URL);
            },
            trailing: Icon(Icons.arrow_forward, color: Colors.indigo),
            title: Padding(
              child: Text(
                "How to get tested",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              padding: EdgeInsets.all(5),
            ),
            subtitle: Padding(
              child: Text("COVID-19 Testing Resources"),
              padding: EdgeInsets.all(5),
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Container(
          decoration: new BoxDecoration(
              color: Colors.transparent,
              border: Border.all(color: Colors.indigo.shade400),
              borderRadius: new BorderRadius.all(const Radius.circular(8.0))),
          child: ListTile(
            onTap: () {
              AppConstants.launchUrl(AppConstants.TESTED_URL);
            },
            trailing: Icon(Icons.arrow_forward, color: Colors.indigo),
            title: Padding(
              child: Text("How to get documentation",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              padding: EdgeInsets.all(5),
            ),
            subtitle: Padding(
              child: Text("COVID-19 Testing Documentation Resources"),
              padding: EdgeInsets.all(5),
            ),
          ),
        ),
        SizedBox(
          height: 120,
        ),
      ],
    );
  }
}
