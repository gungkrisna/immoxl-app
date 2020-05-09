import 'dart:async';
import 'package:IMMOXL/theme/styles.dart';
import 'package:flutter/gestures.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:IMMOXL/translations.dart';

class AuthContainer extends StatefulWidget {
  @override
  _AuthContainerState createState() => _AuthContainerState();
}

class _AuthContainerState extends State<AuthContainer>
    with SingleTickerProviderStateMixin {
  double containerHeight = 0.0;
  bool isSignIn = true;

  @override
  void initState() {
    super.initState();
    Future.delayed(
        Duration(seconds: 1),
        () => setState(() {
              containerHeight = 0.75;
            }));
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: animatedContainer(context),
    );
  }

  Widget animatedContainer(context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 400),
      curve: Curves.easeIn,
      height: MediaQuery.of(context).size.height * containerHeight,
      decoration: BoxDecoration(
          color: IMMOXLTheme.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
              padding: EdgeInsets.fromLTRB(30, 20, 30, 0),
              child: AnimatedSwitcher(
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return ScaleTransition(
                    child: child,
                    scale: animation,
                  );
                },
                child: isSignIn ? signInMode(context) : signUpMode(context),
                duration: (Duration(milliseconds: 400)),
              ))),
    );
  }

  Widget signInMode(context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          Translations.of(context).text('main', 'Sign In'),
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 25,
            fontFamily: 'PTSans',
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          Translations.of(context).text('main', 'Email'),
          style: TextStyle(
            color: IMMOXLTheme.purple,
            fontWeight: FontWeight.bold,
            fontSize: 14,
            fontFamily: 'PTSans',
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 5, bottom: 10),
          child: Container(
            decoration: BoxDecoration(
                color: IMMOXLTheme.lightgrey,
                borderRadius: BorderRadius.all(Radius.circular(8))),
            child: Padding(
              padding: EdgeInsets.all(12),
              child: Row(children: <Widget>[
                Icon(Icons.email),
                SizedBox(
                  width: 12,
                ),
                Text(
                  'johndoe@immoxl.com',
                  style: TextStyle(
                    fontSize: 12,
                    color: IMMOXLTheme.darkgrey,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'PTSans',
                  ),
                )
              ]),
            ),
          ),
        ),
        Text(
          Translations.of(context).text('main', 'Password'),
          style: TextStyle(
            color: IMMOXLTheme.purple,
            fontWeight: FontWeight.bold,
            fontSize: 14,
            fontFamily: 'PTSans',
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 5, bottom: 5),
          child: Container(
            decoration: BoxDecoration(
                color: IMMOXLTheme.lightgrey,
                borderRadius: BorderRadius.all(Radius.circular(8))),
            child: Padding(
              padding: EdgeInsets.all(12),
              child: Row(children: <Widget>[
                Icon(Icons.email),
                SizedBox(
                  width: 12,
                ),
                Text(
                  '••••••••',
                  style: TextStyle(
                    fontSize: 12,
                    color: IMMOXLTheme.darkgrey,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'PTSans',
                  ),
                )
              ]),
            ),
          ),
        ),
        Text(
          Translations.of(context).text('main', 'Forgot your password?'),
          style: TextStyle(
            fontSize: 12,
            color: IMMOXLTheme.darkgrey,
            fontFamily: 'PTSans',
          ),
        ),
        SizedBox(
          height: 10,
        ),
        SizedBox(
          width: double.maxFinite,
          child: FlatButton(
            onPressed: () {},
            color: IMMOXLTheme.lightblue,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            child: Padding(
              padding: EdgeInsets.all(15),
              child: Text(
                Translations.of(context).text('main', 'Sign In'),
                style: TextStyle(
                  fontSize: 16,
                  color: IMMOXLTheme.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'PTSans',
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 20, bottom: 20),
          child: Row(children: <Widget>[
            Expanded(
                child: Divider(
              thickness: 1.5,
            )),
            SizedBox(
              width: 10,
            ),
            Text(
              Translations.of(context).text('main', "OR"),
              style: TextStyle(
                fontSize: 14,
                color: IMMOXLTheme.darkgrey,
                fontFamily: 'PTSans',
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
                child: Divider(
              thickness: 1.5,
            )),
          ]),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              MaterialButton(
                height: 50,
                minWidth: 50,
                padding: EdgeInsets.all(0),
                color: IMMOXLTheme.lightgrey,
                splashColor: Colors.white30,
                elevation: 2.0,
                onPressed: () {},
                child: Container(
                  width: 35.0,
                  height: 35.0,
                  child: Image(image: AssetImage('assets/images/google.png')),
                ),
                shape: ButtonTheme.of(context).shape,
              ),
              MaterialButton(
                height: 50,
                minWidth: 50,
                padding: EdgeInsets.all(0),
                color: Colors.black,
                splashColor: Colors.white30,
                elevation: 2.0,
                onPressed: () {},
                child: Container(
                  width: 35.0,
                  height: 35.0,
                  child: Image(image: AssetImage('assets/images/apple.png')),
                ),
                shape: ButtonTheme.of(context).shape,
              ),
              MaterialButton(
                height: 50,
                minWidth: 50,
                padding: EdgeInsets.all(0),
                color: Colors.white,
                splashColor: Colors.white30,
                elevation: 2.0,
                onPressed: () {},
                child: Container(
                  width: 50.0,
                  height: 50.0,
                  child: Image(image: AssetImage('assets/images/facebook.png')),
                ),
                shape: ButtonTheme.of(context).shape,
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RichText(
              text: TextSpan(
                children: <TextSpan>[
                  TextSpan(
                    text: Translations.of(context)
                        .text('main', "Dont have an account? "),
                  ),
                  TextSpan(
                    text: Translations.of(context).text('main', "Sign Up!"),
                    style: TextStyle(
                      color: IMMOXLTheme.purple,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        setState(() {
                          containerHeight =
                              containerHeight == 0.75 ? 0.88 : 0.75;
                          isSignIn = isSignIn == true ? false : true;
                        });
                      },
                  )
                ],
                style: TextStyle(
                  fontSize: 14,
                  color: IMMOXLTheme.darkgrey,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'PTSans',
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget signUpMode(context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          Translations.of(context).text('main', 'Create Account'),
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 25,
            fontFamily: 'PTSans',
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          Translations.of(context).text('main', 'Name'),
          style: TextStyle(
            color: IMMOXLTheme.purple,
            fontWeight: FontWeight.bold,
            fontSize: 14,
            fontFamily: 'PTSans',
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 5, bottom: 10),
          child: Container(
            decoration: BoxDecoration(
                color: IMMOXLTheme.lightgrey,
                borderRadius: BorderRadius.all(Radius.circular(8))),
            child: Padding(
              padding: EdgeInsets.all(12),
              child: Row(children: <Widget>[
                Icon(Icons.account_circle),
                SizedBox(
                  width: 12,
                ),
                Text(
                  'John Doe',
                  style: TextStyle(
                    fontSize: 12,
                    color: IMMOXLTheme.darkgrey,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'PTSans',
                  ),
                )
              ]),
            ),
          ),
        ),
        Text(
          Translations.of(context).text('main', 'Email'),
          style: TextStyle(
            color: IMMOXLTheme.purple,
            fontWeight: FontWeight.bold,
            fontSize: 14,
            fontFamily: 'PTSans',
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 5, bottom: 10),
          child: Container(
            decoration: BoxDecoration(
                color: IMMOXLTheme.lightgrey,
                borderRadius: BorderRadius.all(Radius.circular(8))),
            child: Padding(
              padding: EdgeInsets.all(12),
              child: Row(children: <Widget>[
                Icon(Icons.email),
                SizedBox(
                  width: 12,
                ),
                Text(
                  'johndoe@immoxl.com',
                  style: TextStyle(
                    fontSize: 12,
                    color: IMMOXLTheme.darkgrey,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'PTSans',
                  ),
                )
              ]),
            ),
          ),
        ),
        Text(
          Translations.of(context).text('main', 'Password'),
          style: TextStyle(
            color: IMMOXLTheme.purple,
            fontWeight: FontWeight.bold,
            fontSize: 14,
            fontFamily: 'PTSans',
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 5, bottom: 5),
          child: Container(
            decoration: BoxDecoration(
                color: IMMOXLTheme.lightgrey,
                borderRadius: BorderRadius.all(Radius.circular(8))),
            child: Padding(
              padding: EdgeInsets.all(12),
              child: Row(children: <Widget>[
                Icon(Icons.email),
                SizedBox(
                  width: 12,
                ),
                Text(
                  '••••••••',
                  style: TextStyle(
                    fontSize: 12,
                    color: IMMOXLTheme.darkgrey,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'PTSans',
                  ),
                )
              ]),
            ),
          ),
        ),
        Text(
          Translations.of(context).text('main', 'Forgot your password?'),
          style: TextStyle(
            fontSize: 12,
            color: IMMOXLTheme.darkgrey,
            fontFamily: 'PTSans',
          ),
        ),
        SizedBox(
          height: 10,
        ),
        SizedBox(
          width: double.maxFinite,
          child: FlatButton(
            onPressed: () {},
            color: IMMOXLTheme.lightblue,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            child: Padding(
              padding: EdgeInsets.all(15),
              child: Text(
                Translations.of(context).text('main', 'Sign Up'),
                style: TextStyle(
                  fontSize: 16,
                  color: IMMOXLTheme.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'PTSans',
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 20, bottom: 20),
          child: Row(children: <Widget>[
            Expanded(
                child: Divider(
              thickness: 1.5,
            )),
            SizedBox(
              width: 10,
            ),
            Text(
              Translations.of(context).text('main', "OR"),
              style: TextStyle(
                fontSize: 14,
                color: IMMOXLTheme.darkgrey,
                fontFamily: 'PTSans',
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
                child: Divider(
              thickness: 1.5,
            )),
          ]),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              MaterialButton(
                height: 50,
                minWidth: 50,
                padding: EdgeInsets.all(0),
                color: IMMOXLTheme.lightgrey,
                splashColor: Colors.white30,
                elevation: 2.0,
                onPressed: () {},
                child: Container(
                  width: 35.0,
                  height: 35.0,
                  child: Image(image: AssetImage('assets/images/google.png')),
                ),
                shape: ButtonTheme.of(context).shape,
              ),
              MaterialButton(
                height: 50,
                minWidth: 50,
                padding: EdgeInsets.all(0),
                color: Colors.black,
                splashColor: Colors.white30,
                elevation: 2.0,
                onPressed: () {},
                child: Container(
                  width: 35.0,
                  height: 35.0,
                  child: Image(image: AssetImage('assets/images/apple.png')),
                ),
                shape: ButtonTheme.of(context).shape,
              ),
              MaterialButton(
                height: 50,
                minWidth: 50,
                padding: EdgeInsets.all(0),
                color: Colors.white,
                splashColor: Colors.white30,
                elevation: 2.0,
                onPressed: () {},
                child: Container(
                  width: 50.0,
                  height: 50.0,
                  child: Image(image: AssetImage('assets/images/facebook.png')),
                ),
                shape: ButtonTheme.of(context).shape,
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RichText(
              text: TextSpan(
                children: <TextSpan>[
                  TextSpan(
                    text: Translations.of(context)
                        .text('main', "Already have an account? "),
                  ),
                  TextSpan(
                    text: Translations.of(context).text('main', "Sign In!"),
                    style: TextStyle(
                      color: IMMOXLTheme.purple,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        setState(() {
                          containerHeight =
                              containerHeight == 0.75 ? 0.88 : 0.75;
                          isSignIn = isSignIn == true ? false : true;
                        });
                      },
                  )
                ],
                style: TextStyle(
                  fontSize: 14,
                  color: IMMOXLTheme.darkgrey,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'PTSans',
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}