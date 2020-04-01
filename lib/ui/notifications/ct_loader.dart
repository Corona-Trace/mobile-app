import 'package:corona_trace/main.dart';
import 'package:flutter/material.dart';

class CTLoader extends StatelessWidget {
  final double width;
  final double height;

  CTLoader(this.width, this.height);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Center(
        child: SizedBox(
          width: width,
          height: height,
          child: CircularProgressIndicator(
            backgroundColor: appColor,
            strokeWidth: 3.0,
          ),
        ),
      ),
    );
  }
}
