import 'package:corona_trace/ui/base_state.dart';
import 'package:corona_trace/ui/screens/getting_started_screen.dart';
import 'package:corona_trace/utils/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

final kMainTitleStyle = TextStyle(
  color: Color.fromRGBO(227, 203, 228, 1),
  fontSize: 32.0,
);

final kSubtitleStyle = TextStyle(
  color: Color.fromRGBO(227, 203, 228, 1),
  fontSize: 24.0,
);

final kMainTextStyle = TextStyle(
  color: Color.fromRGBO(227, 203, 228, 1),
  fontSize: 17.0,
);

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends BaseState<OnboardingScreen> {
  final int _numPages = 4;
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _numPages; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      height: 12.0,
      width: 12.0,
      decoration: BoxDecoration(
        color: isActive ? Color(0xFF475DF3) : Color.fromARGB(50, 255, 255, 255),
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );
  }

  @override
  Widget prepareWidget(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Container(
          color: Color(0xFF2c3054),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 20.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Expanded(
                  child: PageView(
                    physics: ClampingScrollPhysics(),
                    controller: _pageController,
                    onPageChanged: (int page) {
                      setState(() {
                        _currentPage = page;
                      });
                    },
                    children: <Widget>[
                      getFirstPage(),
                      getSecondPage(),
                      getThirdPage(),
                      getFourthPage(),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _buildPageIndicator(),
                ),
                getBottomButton()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget getFirstPage() {
    return SingleChildScrollView(
      child: ConstrainedBox(
        constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height * 0.85),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset("assets/images/firstonboarding.png"),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
              child: Text(
                AppLocalization.text("Onboarding.Stop.Spread"),
                style: kMainTitleStyle,
              ),
            ),
            SizedBox(height: 15.0),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
              child: Text(
                AppLocalization.text("Onboarding.Single.Answer"),
                style: kSubtitleStyle,
              ),
            ),
            SizedBox(height: 15.0),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
              child: Text(
                AppLocalization.text("Onboarding.Anonymous"),
                style: kMainTextStyle,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getSecondPage() {
    return Padding(
      padding: EdgeInsets.only(left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Align(
            child: Image(
              image: AssetImage(
                "assets/images/Illustration_Anonymous.png",
              ),
            ),
            alignment: Alignment.center,
          ),
          Text(
            AppLocalization.text("Onboarding.CheckIn"),
            textAlign: TextAlign.start,
            style: kSubtitleStyle,
          ),
          SizedBox(height: 15.0),
          Align(
            child: Text(
              AppLocalization.text("Onboarding.Help"),
              textAlign: TextAlign.left,
              style: kMainTextStyle,
            ),
            alignment: Alignment.centerLeft,
          ),
        ],
      ),
    );
  }

  Widget getThirdPage() {
    return SingleChildScrollView(
      child: ConstrainedBox(
        constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height * 0.85),
        child: Padding(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset("assets/images/Illustration_GetNotified.png"),
              SizedBox(height: 15.0),
              Text(
                AppLocalization.text("Onboarding.Notified"),
                style: kSubtitleStyle,
              ),
              SizedBox(height: 15.0),
              Text(
                AppLocalization.text("Onboarding.Notified.CrossPaths"),
                textAlign: TextAlign.left,
                style: kMainTextStyle,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getFourthPage() {
    return SingleChildScrollView(
        child: ConstrainedBox(
      constraints:
          BoxConstraints(minHeight: MediaQuery.of(context).size.height * 0.85),
      child: Padding(
        padding: EdgeInsets.only(left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Align(
              child: Image(
                image: AssetImage(
                  "assets/images/Illustration_ClearStatus.png",
                ),
              ),
              alignment: Alignment.center,
            ),
            Text(
              AppLocalization.text("Onboarding.Meaningful"),
              style: kSubtitleStyle,
            ),
            SizedBox(height: 15.0),
            Text(
              AppLocalization.text("Onboarding.Meaningful.Guidelines"),
              style: kMainTextStyle,
            ),
          ],
        ),
      ),
    ));
  }

  Widget getBottomButton() {
    String buttonTitle = "";

    switch (_currentPage) {
      case 0:
        {
          buttonTitle = AppLocalization.text("Onboarding.SeeHow");
        }
        break;
      case 3:
        {
          buttonTitle = AppLocalization.text("Onboarding.GetStarted");
        }
        break;
      default:
        {
          buttonTitle = AppLocalization.text("Continue");
        }
    }
    print(_currentPage);
    return Padding(
        padding: const EdgeInsets.fromLTRB(12.0, 36.0, 12.0, 0.0),
        child: MaterialButton(
          padding: EdgeInsets.symmetric(vertical: 14.0),
          shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(8.0),
          ),
          color: Color(0xFF475df3),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                buttonTitle,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(
                width: 20,
              ),
              Visibility(
                child: Icon(Icons.arrow_forward, color: Colors.white),
                visible: _currentPage == 0 || _currentPage == 3,
              )
            ],
          ),
          onPressed: () async {
            if (_currentPage < 3) {
              _pageController.nextPage(
                duration: Duration(milliseconds: 500),
                curve: Curves.ease,
              );
            } else {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => GettingStarted()),
                  (route) => false);
            }
          },
        ));
  }
}
