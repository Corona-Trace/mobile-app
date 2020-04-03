import 'package:corona_trace/CTAnalyticsManager.dart';
import 'package:corona_trace/main.dart';
import 'package:corona_trace/ui/notifications/ct_loader.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class BaseState<T extends StatefulWidget> extends State<T> {
  bool isVisible = false;
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    CTAnalyticsManager.instance.getFBAnalytics().setCurrentScreen(screenName: screenName()).catchError(
      (Object error) {
        debugPrint('$FirebaseAnalyticsObserver: $error');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 375, height: 812, allowFontScaling: false);
    return prepareWidget(context);
  }

  Widget prepareWidget(BuildContext context);

  String screenName();

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
                  child: CTLoader(50, 50),
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
