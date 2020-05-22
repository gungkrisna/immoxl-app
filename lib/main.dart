import 'dart:async';
// import 'package:IMMOXL/screens/onboarding_screen/onboarding_screen.dart';
import 'package:IMMOXL/screens/foundation.dart';
import 'package:IMMOXL/screens/onboarding_screen/onboarding_screen.dart';
import 'package:IMMOXL/theme/styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'all_translations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await allTranslations.init();
  runApp(MaterialApp(
    localizationsDelegates: [
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
    ],
    supportedLocales: allTranslations.supportedLocales(),
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  String userId;

  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.currentUser().then((user) {
      userId = user.uid;
    });
    Future.delayed(
      Duration(seconds: 3),
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>
              (userId == null) ? OnboardingScreen() : Foundation(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: IMMOXLTheme.lightblue,
      body: Stack(children: <Widget>[
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Container(
            height: MediaQuery.of(context).size.height * 0.60,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(color: IMMOXLTheme.purple),
            child: Stack(
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Image.asset('assets/images/houses.png'),
                  ],
                ),
                Center(
                  child: Padding(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).size.height * 0.1),
                    child: Text(
                      "IMMOXL",
                      style: TextStyle(
                          fontFamily: 'TheNextFont',
                          fontSize: 80,
                          color: IMMOXLTheme.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              ],
            ),
          ),
        )
      ]),
    );
  }
}
