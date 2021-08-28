import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:introduction_screen/introduction_screen.dart';

import 'welcome_screen.dart';

//import 'package:all_news/select_page.dart';

class OnBoardingPage extends StatefulWidget {
  @override
  _OnBoardingPageState createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (_) => WelcomeScreen()));
  }

  Widget _buildImage(String assetName) {
    return Align(
      child: Image.asset(
        'images/$assetName.png',
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
      ),
      alignment: Alignment.bottomCenter,
    );
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 19.0, color: Color(0xffA6ACB5));
    const pageDecoration = const PageDecoration(
      titleTextStyle: TextStyle(
          fontSize: 28.0, fontFamily: 'Lobster', fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );
    return IntroductionScreen(
      key: introKey,
      pages: [
        PageViewModel(
          title: "Let the journey start",
          body:
              'Find the best pair to fit your lifestyle and fulfill your life',
          image: Image.asset(
            'images/onboarding.png',
            height: 285.0,
            width: 285.0,
            alignment: Alignment.center,
          ),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Let the journey start",
          //  body:
          //    'Find the best pair to fit your lifestyle and fulfill your life',
          image: Image.asset(
            'images/onboarding.png',
            height: 285.0,
            width: 285.0,
            alignment: Alignment.center,
          ),
          decoration: pageDecoration,
          bodyWidget: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Find the best pair to fit your lifestyle and fulfill your life',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xffA6ACB5),
                  fontSize: 19.0,
                ),
              ),
              SizedBox(
                height: 100,
              ),
              FlatButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  height: 50,
                  onPressed: () {},
                  child: Text(
                    'Start now',
                    style: TextStyle(color: Colors.white),
                  ),
                  color: Colors.lightBlueAccent),
            ],
          ),
        ),
      ],
      onDone: () => _onIntroEnd(context),
      showSkipButton: true,
      skipFlex: 0,
      nextFlex: 0,
      skip: const Text('Skip'),
      next: const Icon(Icons.arrow_forward),
      done: const Text('Done', style: TextStyle(fontWeight: FontWeight.w600)),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Color(0xFFBDBDBD),
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
    );
  }
}
