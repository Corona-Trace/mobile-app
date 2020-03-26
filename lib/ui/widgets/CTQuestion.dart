import 'package:flutter/material.dart';

class CTQuestion extends StatelessWidget {
  const CTQuestion(
      {this.headerText,
      this.subtitleText,
      this.onClick,
      this.showAsRed = false,
      this.showArrows = false});

  final String headerText;
  final String subtitleText;
  final Function onClick;
  final bool showAsRed;
  final bool showArrows;

  @override
  Widget build(BuildContext context) {
    Widget subtitleWidget = (subtitleText.isEmpty)
        ? null
        : Padding(
            child: Text(
              subtitleText,
              textAlign: showArrows ? TextAlign.left : TextAlign.center,
              style: TextStyle(
                  color: showAsRed ? Colors.white : Colors.grey[900],
                  fontSize: 14.0),
            ),
            padding: EdgeInsets.only(left: 5, right: 5, bottom: 5, top: 0),
          );

    double padding = (subtitleText.isEmpty) ? 10 : 5;

    return Container(
      decoration: new BoxDecoration(
          color: showAsRed ? Color.fromRGBO(219,102,81, 1) : Colors.transparent,
          border: showAsRed ? null : Border.all(color: Colors.indigo.shade400),
          borderRadius: new BorderRadius.all(const Radius.circular(8.0))),
      child: ListTile(
        onTap: onClick,
        trailing:
            showArrows ? Icon(Icons.arrow_forward, color: Colors.indigo) : null,
        title: Padding(
          child: Text(
              headerText,
              textAlign: showArrows ? TextAlign.left : TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: showAsRed ? Colors.white : Colors.black)),
          padding: EdgeInsets.all(padding),
        ),
        subtitle: subtitleWidget,
      ),
    );
  }
}
