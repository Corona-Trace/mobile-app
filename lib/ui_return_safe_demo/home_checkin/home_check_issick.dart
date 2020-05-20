import 'package:corona_trace/app_constants.dart';
import 'package:corona_trace/ui_return_safe_demo/common/ui/CTCommonRadioGroup.dart';
import 'package:corona_trace/ui_return_safe_demo/home_checkin/WatchForSymptomsWidget.dart';
import 'package:corona_trace/ui_return_safe_demo/home_checkin/home_confirm_not_sick.dart';
import 'package:corona_trace/utils/app_localization.dart';
import 'package:flutter/material.dart';

class HomeCheckIsSick extends StatefulWidget {
  final Function(Widget response) onNextScreen;

  HomeCheckIsSick({this.onNextScreen});

  @override
  _HomeCheckIsSickState createState() => _HomeCheckIsSickState();
}

class _HomeCheckIsSickState extends State<HomeCheckIsSick> {
  int _selectedItem;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[topContent(), bottomContent(context)],
        ),
      ),
    );
  }

  Widget topContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: 32,
        ),
        Text(
          AppLocalization.text("are.feeling.sick"),
          style: TextStyle(
              fontSize: 28,
              color: Color(0xff1A1D4A),
              fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 32,
        ),
        CTCommonRadioGroup([
          AppLocalization.text("yes.feel.sick"),
          AppLocalization.text("not.feel.sick")
        ], (int selected) {
          _selectedItem = selected;
          setState(() {});
        })
      ],
    );
  }

  Widget bottomContent(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          child: Material(
            child: MaterialButton(
              height: 50,
              minWidth: MediaQuery.of(context).size.width * 0.85,
              color:
                  _selectedItem != null ? Color(0xff379FFF) : Color(0xff91CAFF),
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
                  if (_selectedItem == 0) {
                    print("gone watch for symptoms");
                    widget.onNextScreen.call(WatchForSymptomsWidget(
                            showBottomButtons: true,
                            status: AppConstants.NOT_TESTED_FEEL_SICK,
                            onNextScreen: widget.onNextScreen,
                            needsScroll: true)
                        .get(context));
                  } else {
                    print("HomeConfirmProcessSick 1");
                    widget.onNextScreen.call(HomeConfirmProcessSick(
                        status: AppConstants.NOT_TESTTED_NOT_SICK,
                        onNextScreen: widget.onNextScreen));
                  }
                }
              },
            ),
          ),
          margin: EdgeInsets.only(bottom: 20),
        ),
        Container(
          child: MaterialButton(
            height: 50,
            minWidth: MediaQuery.of(context).size.width * 0.85,
            color: Color(0xffDFE3FF),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8))),
            child: Text(
              AppLocalization.text(
                "prev.ques",
              ),
              style: TextStyle(color: Color(0xff379FFF), fontSize: 17),
            ),
            onPressed: () {
              widget.onNextScreen.call(null);
            },
          ),
          margin: EdgeInsets.only(bottom: 20),
        )
      ],
    );
  }
}
