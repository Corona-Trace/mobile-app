import 'package:corona_trace/utils/app_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PageAppAvailability extends StatefulWidget {
  final PageController pageController;

  PageAppAvailability(this.pageController);

  @override
  State<StatefulWidget> createState() {
    return PageAppAvailabilityState();
  }
}

class PageAppAvailabilityState extends State<PageAppAvailability> {
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StatefulBuilder(builder: (context, setState) {
        return Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: SingleChildScrollView(
                  child: topContent(setState),
                ),
              ),
              bottomContent(context),
            ],
          ),
        );
      }),
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
              color: _emailController.value.text.isNotEmpty
                  ? Color(0xff475DF3)
                  : Color(0xffB5BEFF),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8))),
              child: Text(
                AppLocalization.text(
                  "notify.me",
                ),
                style: TextStyle(color: Colors.white, fontSize: 17),
              ),
              onPressed: () {
                widget.pageController.nextPage(
                    duration: Duration(milliseconds: 250),
                    curve: Curves.easeInToLinear);
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
                "not.right.now",
              ),
              style: TextStyle(color: Color(0xff475DF3), fontSize: 17),
            ),
            onPressed: () {
              widget.pageController.nextPage(
                  duration: Duration(milliseconds: 250),
                  curve: Curves.easeInToLinear);
            },
          ),
          margin: EdgeInsets.only(bottom: 20),
        )
      ],
    );
  }

  Container topContent(setState) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 16,
          ),
          Text(
            AppLocalization.text("onboarding.looks.like.not.available"),
            style: TextStyle(
                fontSize: 28,
                color: Color(0xff1A1D4A),
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 16,
          ),
          Text(AppLocalization.text("onboarding.notavailable.subtitle"),
              style: TextStyle(fontSize: 17)),
          SizedBox(
            height: 36,
          ),
          TextField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            onChanged: (value) {
              print("chaged $value");
              setState(() {});
            },
            decoration: InputDecoration(
                hintText: AppLocalization.text("hint.onboarding.enter.email"),
                labelStyle:
                    new TextStyle(color: Color.fromARGB(50, 26, 29, 74)),
                border: new UnderlineInputBorder(
                    borderSide: new BorderSide(color: Color(0xffBAC8E1)))),
          )
        ],
      ),
      margin: EdgeInsets.all(20),
    );
  }
}
