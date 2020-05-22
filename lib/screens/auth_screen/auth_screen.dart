import 'package:IMMOXL/screens/foundation.dart';
import 'package:IMMOXL/services/services.dart';
import 'package:IMMOXL/theme/styles.dart';
import 'package:IMMOXL/all_translations.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen>
    with SingleTickerProviderStateMixin {
  bool isSignIn = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  bool isEmailValid = false;
  bool isPasswordValid = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
            padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
            child: AnimatedSwitcher(
              transitionBuilder: (Widget child, Animation<double> animation) {
                return ScaleTransition(
                  child: child,
                  scale: animation,
                );
              },
              child: isSignIn ? signInMode(context) : signUpMode(context),
              duration: (Duration(milliseconds: 400)),
            )));
  }

  Widget signInMode(context) {
    return Wrap(children: <Widget>[
      SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: SingleChildScrollView(
              child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                Text(
                  allTranslations.text('main', 'Sign In'),
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
                  allTranslations.text('main', 'Email'),
                  style: TextStyle(
                    color: IMMOXLTheme.purple,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    fontFamily: 'PTSans',
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 5, bottom: 10),
                  child: TextField(
                    onChanged: (text) {
                      setState(() {
                        isEmailValid = EmailValidator.validate(text);
                      });
                    },
                    controller: emailController,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'PTSans',
                    ),
                    decoration: InputDecoration(
                      hintText: "johndoe@immoxl.com",
                      hintStyle: TextStyle(
                        fontSize: 12,
                        color: IMMOXLTheme.darkgrey,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'PTSans',
                      ),
                      fillColor: IMMOXLTheme.lightgrey,
                      filled: true,
                      prefixIcon: Container(
                        height: 20,
                        width: 20,
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: SvgPicture.asset(
                            'assets/icons/mail_outline.svg',
                            color: Colors.black,
                          ),
                        ),
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          borderSide: BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          )),
                    ),
                  ),
                ),
                Text(
                  allTranslations.text('main', 'Password'),
                  style: TextStyle(
                    color: IMMOXLTheme.purple,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    fontFamily: 'PTSans',
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 5, bottom: 5),
                  child: TextField(
                    onChanged: (text) {
                      setState(() {
                        isPasswordValid = text.length >= 6;
                      });
                    },
                    controller: passwordController,
                    obscureText: true,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'PTSans',
                    ),
                    decoration: InputDecoration(
                      hintText: "Password",
                      hintStyle: TextStyle(
                        fontSize: 12,
                        color: IMMOXLTheme.darkgrey,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'PTSans',
                      ),
                      fillColor: IMMOXLTheme.lightgrey,
                      filled: true,
                      prefixIcon: Container(
                        height: 20,
                        width: 20,
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: SvgPicture.asset(
                            'assets/icons/lock.svg',
                            color: Colors.black,
                          ),
                        ),
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          borderSide: BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          )),
                    ),
                  ),
                ),
                Text(
                  allTranslations.text('main', 'Forgot your password?'),
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
                    onPressed: () {
                      _emailLogin(
                          email: emailController.text,
                          password: passwordController.text,
                          context: context);
                    },
                    color: IMMOXLTheme.lightblue,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    child: Padding(
                      padding: EdgeInsets.all(15),
                      child: Text(
                        allTranslations.text('main', 'Sign In'),
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
                      allTranslations.text('main', "OR"),
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
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                          child: Image(
                              image: AssetImage('assets/images/google.png')),
                        ),
                        shape: ButtonTheme.of(context).shape,
                      ),
                      /*  MaterialButton(
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
                        child:
                            Image(image: AssetImage('assets/images/apple.png')),
                      ),
                      shape: ButtonTheme.of(context).shape,
                    ), */ // Login with Apple
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
                          child: Image(
                              image: AssetImage('assets/images/facebook.png')),
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
                            text: allTranslations.text('main', "Dont have an account? "),
                          ),
                          TextSpan(
                            text: allTranslations.text('main', "Sign Up!"),
                            style: TextStyle(
                              color: IMMOXLTheme.purple,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                setState(() {
                                  isSignIn = isSignIn == false ? true : false;
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
              ]))))
    ]);
  }

  Widget signUpMode(context) {
    return Wrap(children: <Widget>[
      SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.fromLTRB(
              20, 0, 20, MediaQuery.of(context).viewInsets.bottom),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                allTranslations.text('main', 'Create Account'),
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
                allTranslations.text('main', 'Name'),
                style: TextStyle(
                  color: IMMOXLTheme.purple,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  fontFamily: 'PTSans',
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 5, bottom: 10),
                child: TextField(
                  controller: nameController,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'PTSans',
                  ),
                  decoration: InputDecoration(
                    hintText: "John Doe",
                    hintStyle: TextStyle(
                      fontSize: 12,
                      color: IMMOXLTheme.darkgrey,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'PTSans',
                    ),
                    fillColor: IMMOXLTheme.lightgrey,
                    filled: true,
                    prefixIcon: Container(
                      height: 20,
                      width: 20,
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: SvgPicture.asset(
                          'assets/icons/account_circle.svg',
                          color: Colors.black,
                        ),
                      ),
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(
                          width: 0,
                          style: BorderStyle.none,
                        )),
                  ),
                ),
              ),
              Text(
                allTranslations.text('main', 'Email'),
                style: TextStyle(
                  color: IMMOXLTheme.purple,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  fontFamily: 'PTSans',
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 5, bottom: 10),
                child: TextField(
                  onChanged: (text) {
                    setState(() {
                      isEmailValid = EmailValidator.validate(text);
                    });
                  },
                  controller: emailController,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'PTSans',
                  ),
                  decoration: InputDecoration(
                    hintText: "johndoe@immoxl.com",
                    hintStyle: TextStyle(
                      fontSize: 12,
                      color: IMMOXLTheme.darkgrey,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'PTSans',
                    ),
                    fillColor: IMMOXLTheme.lightgrey,
                    filled: true,
                    prefixIcon: Container(
                      height: 20,
                      width: 20,
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: SvgPicture.asset(
                          'assets/icons/mail_outline.svg',
                          color: Colors.black,
                        ),
                      ),
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(
                          width: 0,
                          style: BorderStyle.none,
                        )),
                  ),
                ),
              ),
              Text(
                allTranslations.text('main', 'Password'),
                style: TextStyle(
                  color: IMMOXLTheme.purple,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  fontFamily: 'PTSans',
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 5, bottom: 5),
                child: TextField(
                  onChanged: (text) {
                    setState(() {
                      isPasswordValid = text.length >= 6;
                    });
                  },
                  controller: passwordController,
                  obscureText: true,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'PTSans',
                  ),
                  decoration: InputDecoration(
                    hintText: "Password",
                    hintStyle: TextStyle(
                      fontSize: 12,
                      color: IMMOXLTheme.darkgrey,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'PTSans',
                    ),
                    fillColor: IMMOXLTheme.lightgrey,
                    filled: true,
                    prefixIcon: Container(
                      height: 20,
                      width: 20,
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: SvgPicture.asset(
                          'assets/icons/lock.svg',
                          color: Colors.black,
                        ),
                      ),
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(
                          width: 0,
                          style: BorderStyle.none,
                        )),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                width: double.maxFinite,
                child: FlatButton(
                  onPressed: () async {
                    if (!(nameController.text.trim() != "" &&
                        emailController.text.trim() != "" &&
                        passwordController.text.trim() != "")) {
                      Flushbar(
                        duration: Duration(milliseconds: 1500),
                        flushbarPosition: FlushbarPosition.TOP,
                        backgroundColor: Color(0xFFFF5C83),
                        message: "Please fill all the fields",
                      )..show(context);
                    } else if (passwordController.text.length < 6) {
                      Flushbar(
                        duration: Duration(milliseconds: 1500),
                        flushbarPosition: FlushbarPosition.TOP,
                        backgroundColor: Color(0xFFFF5C83),
                        message: "Password's length min 6 characters",
                      )..show(context);
                    } else if (!EmailValidator.validate(emailController.text)) {
                      Flushbar(
                        duration: Duration(milliseconds: 1500),
                        flushbarPosition: FlushbarPosition.TOP,
                        backgroundColor: Color(0xFFFF5C83),
                        message: "Wrong formatted email address",
                      )..show(context);
                    } else {
                      _emailRegister(
                        email: emailController.text,
                        password: passwordController.text,
                        name: nameController.text,
                        context: context,
                      );
                    }
                  },
                  color: IMMOXLTheme.lightblue,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  child: Padding(
                    padding: EdgeInsets.all(15),
                    child: Text(
                      allTranslations.text('main', 'Sign Up'),
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
                    allTranslations.text('main', "OR"),
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
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                        child: Image(
                            image: AssetImage('assets/images/google.png')),
                      ),
                      shape: ButtonTheme.of(context).shape,
                    ),
                    /*  MaterialButton(
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
                        child:
                            Image(image: AssetImage('assets/images/apple.png')),
                      ),
                      shape: ButtonTheme.of(context).shape,
                    ), */ // Login with Apple
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
                        child: Image(
                            image: AssetImage('assets/images/facebook.png')),
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
                          text: allTranslations.text('main', "Already have an account? "),
                        ),
                        TextSpan(
                          text:
                              allTranslations.text('main', "Sign In!"),
                          style: TextStyle(
                            color: IMMOXLTheme.purple,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              setState(() {
                                isSignIn = isSignIn == false ? true : false;
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
          ),
        ),
      ),
    ]);
  }

  void _emailLogin(
      {String email, String password, BuildContext context}) async {
    try {
      await Auth.emailLogin(email, password)
          .then((uid) => Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => Foundation(),
                ),
              ));
    } catch (e) {
      String exception = Auth.getExceptionText(e);
      Flushbar(
        message: exception,
        duration: Duration(milliseconds: 1500),
        flushbarPosition: FlushbarPosition.TOP,
        backgroundColor: Color(0xFFFF5C83),
      )..show(context);
    }
  }

  void _emailRegister(
      {String email,
      String password,
      String name,
      BuildContext context}) async {
    try {
      await Auth.emailRegister(email, password, name)
          .then((uid) => Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => Foundation(),
                ),
              ));
    } catch (e) {
      String exception = Auth.getExceptionText(e);
      Flushbar(
        message: exception,
        duration: Duration(milliseconds: 1500),
        flushbarPosition: FlushbarPosition.TOP,
        backgroundColor: Color(0xFFFF5C83),
      )..show(context);
    }
  }
}
