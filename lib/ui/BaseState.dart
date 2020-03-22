import 'package:flutter/material.dart';

abstract class BaseState<T extends StatefulWidget> extends State<T> {
  bool isVisible = false;
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return prepareWidget(context);
  }

  Widget prepareWidget(BuildContext context);

  showLoadingDialog({bool tapDismiss}) {
    if (!isVisible) {
      scaffoldKey.currentState.showSnackBar(SnackBar(
        duration: Duration(days: 1),
        content: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onVerticalDragStart: (_) {
            if (tapDismiss) {
              hideLoadingDialog();
            }
          },
          child: Container(
            child: Stack(
              children: [
                new Center(
                  child: new CircularProgressIndicator(
                    backgroundColor: Colors.indigo,
                  ),
                ),
              ],
            ),
          ),
        ),
        backgroundColor: Colors.black.withOpacity(0.3),
      ));
    }
    isVisible = true;
  }

  hideLoadingDialog() {
    if (isVisible) {
      scaffoldKey.currentState.hideCurrentSnackBar();
    }
    isVisible = false;
  }
}
