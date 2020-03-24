import 'package:flutter/material.dart';

class CTHeaderTile extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        "Help Save Lives!",
        style: TextStyle(
            color: Color.fromRGBO(254, 198, 208, 1),
            fontSize: 28,
            fontWeight: FontWeight.bold),
      ),
      subtitle: Padding(
        child: Text(
          "WHO announces COVID-19\noutbreak a pandemic",
          style:
              TextStyle(color: Color.fromRGBO(254, 198, 208, 1), fontSize: 20),
        ),
        padding: EdgeInsets.only(top: 20, bottom: 20),
      ),
    );
  }
}
