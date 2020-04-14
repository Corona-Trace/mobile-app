import 'package:corona_trace/ui_v1_1/common/ui/CTCommonRadioGroup.dart';
import 'package:corona_trace/ui_v1_1/home_checkin/home_check_issick.dart';
import 'package:corona_trace/utils/app_localization.dart';
import 'package:flutter/material.dart';

class HomeCheckinQuestions extends StatefulWidget {
  final Function(Widget response) onNextScreen;

  HomeCheckinQuestions({this.onNextScreen});

  @override
  State<StatefulWidget> createState() {
    return HomeCheckinQuestionsState();
  }
}

class HomeCheckinQuestionsState extends State<HomeCheckinQuestions> {
  int _selectedItem;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[topContent(), bottomContent()],
        ),
      ),
    );
  }

  Widget topContent() {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 16,
        ),
        Text(
          AppLocalization.text("have.you.been.tested"),
          style: TextStyle(
              fontSize: 28,
              color: Color(0xff1A1D4A),
              fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 16,
        ),
        CTCommonRadioGroup([
          AppLocalization.text("yes.tested.for"),
          AppLocalization.text("not.tested.for")
        ], (int selected) {
          _selectedItem = selected;
          setState(() {});
        })
      ],
    );
  }

  Widget bottomContent() {
    return Container(
      child: Material(
        child: MaterialButton(
          height: 50,
          minWidth: MediaQuery.of(context).size.width * 0.85,
          color: _selectedItem != null ? Color(0xff475DF3) : Color(0xffB5BEFF),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8))),
          child: Text(
            AppLocalization.text(
              "next",
            ),
            style: TextStyle(color: Colors.white, fontSize: 17),
          ),
          onPressed: () {
            if (_selectedItem != null) {
              print(_selectedItem);
              if (_selectedItem == 0) {
                //TODO (API ? or LOCAL)
              } else {
                //TODO (API ? or LOCAL)
              }
              widget.onNextScreen
                  .call(HomeCheckIsSick(onNextScreen: widget.onNextScreen));
            }
          },
        ),
      ),
      margin: EdgeInsets.only(bottom: 20),
    );
  }
}
