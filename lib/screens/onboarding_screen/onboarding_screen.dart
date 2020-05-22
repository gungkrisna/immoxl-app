import 'package:IMMOXL/screens/auth_screen/auth_screen.dart';
import 'package:IMMOXL/theme/styles.dart';
import 'package:flutter/material.dart';

import '../../all_translations.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen>
    with SingleTickerProviderStateMixin {
  double containerHeight = 0.0;
  bool isSignIn = false;
  String userId;
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
      margin: EdgeInsets.only(right: 5),
      height: 8.0,
      width: isActive ? 24.0 : 16.0,
      decoration: BoxDecoration(
        color: isActive
            ? IMMOXLTheme.lightblue
            : IMMOXLTheme.white.withOpacity(0.6),
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.transparent,
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: IMMOXLTheme.lightblue,
          gradient: LinearGradient(colors: [
            IMMOXLTheme.blue,
            IMMOXLTheme.purple,
          ], begin: Alignment.topLeft, end: Alignment.bottomRight),
        ),
        child: Stack(
          children: <Widget>[
            PageView(
                controller: _pageController,
                onPageChanged: (int page) {
                  setState(() {
                    _currentPage = page;
                  });
                },
                children: <Widget>[
                  _step1(),
                  _step2(),
                  _step3(),
                  _step4(),
                ]),
            Positioned.fill(
              top: MediaQuery.of(context).padding.top + 36,
              child: Align(
                alignment: Alignment.topCenter,
                child: Text(
                  "IMMOXL",
                  style: TextStyle(
                      fontFamily: 'TheNextFont',
                      fontSize: 36,
                      color: IMMOXLTheme.white),
                ),
              ),
            ),
            Positioned.fill(
              bottom: 24,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _buildPageIndicator(),
                ),
              ),
            ),
            Visibility(
              visible: _currentPage == 3 ? true : false,
              child: Positioned.fill(
                bottom: 65,
                left: 15,
                right: 15,
                child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        FlatButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          color: IMMOXLTheme.lightblue,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 8, horizontal: 25),
                            child: Text(
                              "Guest",
                              style: TextStyle(
                                fontSize: 18,
                                color: IMMOXLTheme.white,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'PTSans',
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 16),
                        FlatButton(
                          onPressed: () {
                            authUser(context);
                          },
                          color: IMMOXLTheme.lightblue,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 8, horizontal: 25),
                            child: Text(
                              "Create",
                              style: TextStyle(
                                fontSize: 18,
                                color: IMMOXLTheme.white,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'PTSans',
                              ),
                            ),
                          ),
                        ),
                      ],
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _step1() {
    return Align(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset("assets/images/1-pin-house.png",
              width: MediaQuery.of(context).size.width * 0.4,
              fit: BoxFit.fitWidth),
          SizedBox(
            height: 30,
          ),
          Text(
            allTranslations.text('onboarding',
                'Find Industrial, Shop & Retail\nand Offices listings'),
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20,
              fontFamily: 'PTSans',
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _step2() {
    return Align(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset("assets/images/2-save-listing-icon.png",
              width: MediaQuery.of(context).size.width * 0.4,
              fit: BoxFit.fitWidth),
          SizedBox(
            height: 30,
          ),
          Text(
            allTranslations.text(
                'onboarding', 'Save your favorite listing or\nsearch term'),
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20,
              fontFamily: 'PTSans',
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _step3() {
    return Align(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset("assets/images/3-sell-rent-listing-icon.png",
              width: MediaQuery.of(context).size.width * 0.4,
              fit: BoxFit.fitWidth),
          SizedBox(
            height: 30,
          ),
          Text(
            allTranslations.text('onboarding',
                'Listings are free, sell or rent\nyour property on IMMOXL'),
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20,
              fontFamily: 'PTSans',
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _step4() {
    return Align(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset("assets/images/4-get-started-icon.png",
              width: MediaQuery.of(context).size.width * 0.4,
              fit: BoxFit.fitWidth),
          SizedBox(
            height: 30,
          ),
          Text(
            allTranslations.text('onboarding',
                'Create an account for free or\ngo further as guest'),
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20,
              fontFamily: 'PTSans',
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }

  void authUser(context) {
    showModalBottomSheet(
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12), topRight: Radius.circular(12)),
      ),
      backgroundColor: Colors.white,
      context: context,
      builder: (builder) {
        return AuthScreen();
      },
    );
  }
}
