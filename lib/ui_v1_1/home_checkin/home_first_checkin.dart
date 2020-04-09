import 'package:corona_trace/ui_v1_1/home_checkin/home_checkin_questions.dart';
import 'package:corona_trace/utils/app_localization.dart';
import 'package:flutter/material.dart';

class HomeFirstTimeCheckInScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeFirstTimeCheckInScreenState();
  }
}

class HomeFirstTimeCheckInScreenState
    extends State<HomeFirstTimeCheckInScreen> {
  final PageController _pageController = PageController();

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
          color: Color(0xff475DF3),
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
    _pageList.clear();
    _pageList.add(HomeCheckinQuestions(onNextScreen: onNextScreen));
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        builder: (context) {
          print("building bottom sheet again");
          return FractionallySizedBox(
            child: PageView(
              physics: NeverScrollableScrollPhysics(),
              controller: _pageController,
              children: _pageList,
            ),
            heightFactor: 0.85,
          );
        });
  }

  void onNextScreen(Widget response) {
    if (response == null) {
      _pageList.removeLast();
      _pageController.jumpToPage(_pageList.length - 1);
    } else {
      _pageList.add(response);
      setState(() {});
      _pageController.jumpToPage(_pageList.length - 1);
    }
  }
}
