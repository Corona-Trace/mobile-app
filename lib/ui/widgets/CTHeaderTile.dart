import 'package:flutter/material.dart';

class CTHeaderTile extends StatelessWidget {

  final String title;
  final String subtitle;
  CTHeaderTile(this.title,this.subtitle);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(
            color: Color.fromRGBO(254, 198, 208, 1),
            fontSize: 20,
            fontWeight: FontWeight.bold),
      ),
      subtitle: Padding(
        child: Text(
          subtitle,
          style:
              TextStyle(color: Color.fromRGBO(254, 198, 208, 1), fontSize: 14),
        ),
        padding: EdgeInsets.only(top: 20, bottom: 20),
      ),
    );
  }
}
