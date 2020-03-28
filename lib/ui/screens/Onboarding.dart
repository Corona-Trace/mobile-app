import 'package:corona_trace/network/APIRepository.dart';
import 'package:corona_trace/ui/screens/UserInfoCollectorScreen.dart';
import 'package:corona_trace/utils/AppLocalization.dart';
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Image.asset("assets/images/firstonboarding.png"),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
          child: Text(
            AppLocalization.text("Onboarding.Stop.Spread"),
            style: kMainTitleStyle,
          ),
        ),
        SizedBox(height: 15.0),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
          child: Text(
            AppLocalization.text("Onboarding.Single.Answer"),
            style: kSubtitleStyle,
          ),
        ),
        SizedBox(height: 15.0),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
          child: Text(
            AppLocalization.text("Onboarding.Anonymous"),
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
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Image(
              image: AssetImage(
                "assets/images/Illustration_Anonymous.png",
              ),
              height: 300.0,
              width: 300.0,
            ),
          ),
          Text(
            AppLocalization.text("Onboarding.CheckIn"),
            style: kSubtitleStyle,
          ),
          SizedBox(height: 15.0),
          Align(
            child: Text(
              AppLocalization.text("Onboarding.Help"),
              textAlign: TextAlign.center,
              style: kMainTextStyle,
            ),
            alignment: Alignment.center,
          ),
        ],
      ),
    );
  }

  Widget getThirdPage() {
    return Padding(
      padding: EdgeInsets.all(40.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
              height: 8.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                color: Color(0xFFE3CBE4),
              )),
          SizedBox(height: 30.0),
          Text(
            AppLocalization.text("Onboarding.Notified"),
            style: kSubtitleStyle,
          ),
          SizedBox(height: 15.0),
          Text(
            AppLocalization.text("Onboarding.Notified.CrossPaths"),
            textAlign: TextAlign.center,
            style: kMainTextStyle,
          ),
        ],
      ),
    );
  }

  Widget getFourthPage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Center(
          child: Image(
            image: AssetImage(
              'assets/images/Illustration_Anonymous.png',
            ),
            height: 300.0,
            width: 300.0,
          ),
        ),
        SizedBox(height: 10.0),
        Text(
          AppLocalization.text("Onboarding.Meaningful"),
          style: kSubtitleStyle,
        ),
        SizedBox(height: 15.0),
        Padding(
          child: Text(
            AppLocalization.text("Onboarding.Meaningful.Guidelines"),
            style: kMainTextStyle,
          ),
          padding: EdgeInsets.only(left: 20, right: 20),
        ),
      ],
    );
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
          onPressed: () async {
            if (_currentPage < 3) {
              _pageController.nextPage(
                duration: Duration(milliseconds: 500),
                curve: Curves.ease,
              );
            } else {
              await ApiRepository.setOnboardingDone(true);
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) =>
                          UserInfoCollectorScreen()),
                  (route) => false);
            }
          },
        ));
  }
}
