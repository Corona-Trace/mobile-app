import 'package:corona_trace/ui_v1_1/OnboardingStatus.dart';
import 'package:corona_trace/utils/app_localization.dart';
import 'package:flutter/material.dart';

class OnboardingCheckAvailabilityCheckZip extends StatefulWidget {
  final Function(OnboaringStatus status) onboardStatusUpdate;

  OnboardingCheckAvailabilityCheckZip(this.onboardStatusUpdate);

  @override
  State<StatefulWidget> createState() {
    return OnboardingCheckAvailabilityCheckZipState();
  }
}

class OnboardingCheckAvailabilityCheckZipState
    extends State<OnboardingCheckAvailabilityCheckZip> {
  final TextEditingController _zipController = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            topContent(setState),
            bottomContent(context),
          ],
        ),
      ),
    );
  }

  Container bottomContent(BuildContext context) {
    return Container(
      child: Material(
        child: MaterialButton(
          height: 50,
          minWidth: MediaQuery.of(context).size.width * 0.85,
          color: _zipController.value.text.isNotEmpty
              ? Color(0xff475DF3)
              : Color(0xffB5BEFF),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8))),
          child: Text(
            AppLocalization.text(
              "submit",
            ),
            style: TextStyle(color: Colors.white, fontSize: 17),
          ),
          onPressed: () {
            if (zipAvailable()) {
              FocusScope.of(context).unfocus();
              widget.onboardStatusUpdate
                  .call(OnboaringStatusZip(_zipController.value.text));
            }
          },
        ),
      ),
      margin: EdgeInsets.only(bottom: 20),
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
            AppLocalization.text("onboarding.enter.zip"),
            style: TextStyle(
                fontSize: 28,
                color: Color(0xff1A1D4A),
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 8,
          ),
          TextField(
            controller: _zipController,
            keyboardType: TextInputType.number,
            onChanged: (value) {
              setState(() {});
              print("chaged $value");
            },
            decoration: InputDecoration(
                hintText: AppLocalization.text("hint.onboarding.enter.zip"),
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

  bool zipAvailable() {
    return _zipController.value.text.isNotEmpty;
  }
}
