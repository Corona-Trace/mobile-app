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
            strokeWidth: 3.0,
          ),
        ),
      ),
    );
  }


}
