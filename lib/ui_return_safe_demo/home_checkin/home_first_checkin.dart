import 'package:corona_trace/ui_return_safe_demo/home_checkin/home_checkin_questions.dart';
import 'package:corona_trace/utils/app_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeFirstTimeCheckInScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeFirstTimeCheckInScreenState();
  }
}

class HomeFirstTimeCheckInScreenState
    extends State<HomeFirstTimeCheckInScreen> {
  final List<Widget> _pageList = List<Widget>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          topContent(),
          bottomContent(context),
        ],
      ),
    ));
  }

  Container bottomContent(BuildContext context) {
    return Container(
      child: Material(
        child: MaterialButton(
          height: 50,
          minWidth: MediaQuery.of(context).size.width * 0.85,
          color: Color(0xff379FFF),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8))),
          child: Text(
            AppLocalization.text(
              "check.in",
            ),
            style: TextStyle(color: Colors.white, fontSize: 17),
          ),
          onPressed: () {
            bottomSheetQuestions(context);
          },
        ),
      ),
      margin: EdgeInsets.only(bottom: 20),
    );
  }

  Container topContent() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 16,
          ),
          Text(
            AppLocalization.text("check.in.start.fight"),
            style: TextStyle(
                fontSize: 28,
                color: Color(0xff1A1D4A),
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 16,
          ),
          Text(
            AppLocalization.text("answers.to.next.few.help"),
            style: TextStyle(fontSize: 17),
          ),
        ],
      ),
      margin: EdgeInsets.all(20),
    );
  }

  void bottomSheetQuestions(context) {
    print("cleared pages");
    _pageList.clear();
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        useRootNavigator: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        builder: (context) {
          print("building bottom sheet again");
          return BottomSheet(
            onClosing: () {},
            builder: (context) {
              return StatefulBuilder(builder: (builder, setState) {
                void onNextScreen(Widget response) {
                  if (response == null) {
                    _pageList.removeLast();
                    setState(() {});
                  } else {
                    _pageList.add(response);
                    setState(() {});
                  }
                  print(_pageList.length);
                }

                if (_pageList.isEmpty) {
                  _pageList
                      .add(HomeCheckinQuestions(onNextScreen: onNextScreen));
                }

                return FractionallySizedBox(
                  child: _pageList.last,
                  heightFactor: 0.85,
                );
              });
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          );
        });
  }
}
