import 'package:corona_trace/utils/app_localization.dart';
import 'package:flutter/material.dart';

class DeleteDataScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StatefulBuilder(builder: (context, setState) {
        return Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: SingleChildScrollView(
                  child: topContent(setState),
                ),
              ),
              bottomContent(context),
            ],
          ),
        );
      }),
    );
  }

  Widget bottomContent(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          child: Material(
            child: MaterialButton(
              height: 50,
              minWidth: MediaQuery.of(context).size.width * 0.85,
              color: Color(0xffFF3A6A),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8))),
              child: Text(
                AppLocalization.text(
                  "delete.my.data",
                ),
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.bold),
              ),
              onPressed: () {

              },
            ),
          ),
          margin: EdgeInsets.only(bottom: 20),
        ),
        Container(
          child: MaterialButton(
            height: 50,
            minWidth: MediaQuery.of(context).size.width * 0.85,
            color: Color(0xffB5BEFF),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8))),
            child: Text(
              AppLocalization.text(
                "cancel_camel",
              ),
              style: TextStyle(
                  color: Color(0xff475DF3),
                  fontSize: 17,
                  fontWeight: FontWeight.bold),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          margin: EdgeInsets.only(bottom: 20),
        )
      ],
    );
  }

  Container topContent(setState) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 16,
          ),
          Text(
            AppLocalization.text("confirm.delete.data"),
            style: TextStyle(
                fontSize: 28,
                color: Color(0xff1A1D4A),
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
      margin: EdgeInsets.all(20),
    );
  }
}
