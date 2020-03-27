import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

final kMainTitleStyle = TextStyle(
  color: Colors.white,
  fontSize: 32.0,
);

final kSubtitleStyle = TextStyle(
  color: Colors.white,
  fontSize: 24.0,
);

final kMainTextStyle = TextStyle(
  color: Colors.white,
  fontSize: 17.0,
);

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
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
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Container(
          color: Color(0xFF2c3054),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 40.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  height: 600.0,
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 40.0),
          child: Image.asset("assets/first_onboarding_image.png"),
        ),
        SizedBox(height: 30.0),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
          child: Text(
            'Help stop the\nspread of COVID-19',
            style: kMainTitleStyle,
          ),
        ),
        SizedBox(height: 15.0),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
          child: Text(
            'A single answer saves lives',
            style: kSubtitleStyle,
          ),
        ),
        SizedBox(height: 15.0),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
          child: Text(
            'CoronaTrace is an anonymous, real-time location-based contact tracer that alerts you about possible contact with someone who has tested positive for COVID-19 and helps stop the spread of the virus.',
            style: kMainTextStyle,
          ),
        ),
      ],
    );
  }

  Widget getSecondPage() {
    return Padding(
      padding: EdgeInsets.all(40.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 40.0),
            child: Center(
              child: Image(
                image: AssetImage(
                  "assets/second_onboarding_image.png",
                ),
                height: 300.0,
                width: 300.0,
              ),
            ),
          ),
          Text(
            'Anonymous Check-in',
            style: kSubtitleStyle,
          ),
          SizedBox(height: 15.0),
          Text(
            'Help prevent the spread of COVID-19 by sharing your status and location anonymously.',
            style: kMainTextStyle,
          ),
        ],
      ),
    );
  }

  Widget getThirdPage() {
    return Padding(
      padding: EdgeInsets.all(40.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 200.0, 0.0, 100.0),
            child: Container(
                height: 8.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  color: Color(0xFFE3CBE4),
                )),
          ),
          SizedBox(height: 30.0),
          Text(
            'Get Notified',
            style: kSubtitleStyle,
          ),
          SizedBox(height: 15.0),
          Text(
            "Get notified if you cross paths with someone who has anonymously reported themselves as positive for COVID-19 and get peace of mind when you don't.",
            style: kMainTextStyle,
          ),
        ],
      ),
    );
  }

  Widget getFourthPage() {
    return Padding(
      padding: EdgeInsets.all(40.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Center(
            child: Image(
              image: AssetImage(
                'assets/images/onboarding2.png',
              ),
              height: 300.0,
              width: 300.0,
            ),
          ),
          SizedBox(height: 30.0),
          Text(
            'Clear & Meaningful Status',
            style: kSubtitleStyle,
          ),
          SizedBox(height: 15.0),
          Text(
            'Anonymous self-reporting is based on clear guidelines with actionable next steps for people that might need help.',
            style: kMainTextStyle,
          ),
        ],
      ),
    );
  }

  Widget getBottomButton() {
    String buttonTitle = "";

    switch (_currentPage) {
      case 0:
        {
          buttonTitle = "See How it Works";
        }
        break;
      case 3:
        {
          buttonTitle = "Get Started";
        }
        break;

      default:
        {
          buttonTitle = "Continue";
        }
    }
    return Padding(
        padding: const EdgeInsets.fromLTRB(12.0, 36.0, 12.0, 0.0),
        child: MaterialButton(
          padding: EdgeInsets.symmetric(vertical: 14.0),
          shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(8.0),
          ),
          color: Color(0xFF475df3),
          child: Text(
            buttonTitle,
            style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.w500),
          ),
          onPressed: () {
            if (_currentPage < 3) {
              _pageController.nextPage(
                duration: Duration(milliseconds: 500),
                curve: Curves.ease,
              );
            } else {
              //TODO: go to next screen
            }
          },
        ));
  }
}
