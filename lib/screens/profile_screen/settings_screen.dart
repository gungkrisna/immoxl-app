import 'package:IMMOXL/screens/profile_screen/edit_profile_screen.dart';
import 'package:IMMOXL/services/services.dart';
import 'package:IMMOXL/theme/styles.dart';
import 'package:IMMOXL/all_translations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  TextEditingController companyNameController = TextEditingController();
  DocumentReference userRef;
  @override
  void initState() {
    super.initState();
    _getUserDoc();
  }

  Future<void> _getUserDoc() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final Firestore _firestore = Firestore.instance;

    FirebaseUser user = await _auth.currentUser();
    setState(() {
      userRef = _firestore.collection('users').document(user.uid);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (userRef == null)
      return Center(
        child: Container(
            width: 50,
            height: 50,
            margin: EdgeInsets.only(top: 40, bottom: 30),
            child: SpinKitPulse(
              color: IMMOXLTheme.purple,
            )),
      );
    return MaterialApp(
        home: Scaffold(
            resizeToAvoidBottomInset: true,
            appBar: AppBar(
              leading: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Icon(Icons.arrow_back, color: Colors.black)),
              title: Text(
                allTranslations.text('profile', 'Settings'),
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  fontFamily: 'PTSans',
                ),
              ),
              centerTitle: true,
              backgroundColor: IMMOXLTheme.lightgrey,
            ),
            body: StreamBuilder(
                stream: userRef.snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData || snapshot.data == null)
                    return Center(
                      child: Container(
                          width: 50,
                          height: 50,
                          margin: EdgeInsets.only(top: 40, bottom: 30),
                          child: SpinKitPulse(
                            color: IMMOXLTheme.purple,
                          )),
                    );
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: SingleChildScrollView(
                        child: Column(children: <Widget>[
                      Column(children: <Widget>[
                        ListTile(
                            trailing: Icon(Icons.arrow_forward_ios),
                            title: Row(children: <Widget>[
                              SvgPicture.asset(
                                'assets/icons/account_circle.svg',
                                color: Colors.black,
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Text(
                                allTranslations.text('profile', 'Edit Profile'),
                              ),
                            ]),
                            onTap: () => Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return EditProfile();
                                }))),
                        Divider(
                          height: 1,
                        ),
                        ListTile(
                          title: Row(children: <Widget>[
                            SvgPicture.asset(
                              'assets/icons/business_center.svg',
                              color: Colors.black,
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Text(
                              snapshot.data['isAgent'] == false
                                  ? allTranslations.text(
                                          "profile", "Switch to") +
                                      " " +
                                      allTranslations.text(
                                          "profile", "Real Estate Agent") +
                                      " " +
                                      allTranslations.text("profile", "account")
                                  : allTranslations.text(
                                          "profile", "Switch to") +
                                      " " +
                                      allTranslations.text(
                                          "profile", "Private Owner") +
                                      " " +
                                      allTranslations.text(
                                          "profile", "account"),
                            ),
                          ]),
                          onTap: () => snapshot.data['isAgent'] == false
                              ? _switchToAgent(
                                  context, snapshot.data['company'])
                              : _updateUserType(
                                  isAgent: false,
                                  company: snapshot.data['company'],
                                  context: context),
                        ),
                        Divider(
                          height: 1,
                        ),
                      ]),
                    ])),
                  );
                })));
  }

  void _switchToAgent(context, String company) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext context) {
          return Wrap(children: <Widget>[
            Container(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Column(children: <Widget>[
                Container(
                  padding: EdgeInsets.all(15),
                  color: Colors.white,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(top: 5, bottom: 10),
                          child: TextFormField(
                            controller: companyNameController =
                                TextEditingController(text: company),
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'PTSans',
                            ),
                            decoration: InputDecoration(
                              hintText: allTranslations.text(
                                  'profile', 'Company Name'),
                              hintStyle: TextStyle(
                                fontSize: 12,
                                color: IMMOXLTheme.darkgrey,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'PTSans',
                              ),
                              fillColor: IMMOXLTheme.lightgrey,
                              filled: true,
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8)),
                                  borderSide: BorderSide(
                                    width: 0,
                                    style: BorderStyle.none,
                                  )),
                            ),
                          ),
                        ),
                      ]),
                ),
                SizedBox(
                  width: double.maxFinite,
                  child: FlatButton(
                    disabledColor: IMMOXLTheme.lightblue,
                    disabledTextColor: IMMOXLTheme.white,
                    onPressed: () {
                      _updateUserType(
                          isAgent: true,
                          company: companyNameController.text,
                          context: context);
                      Navigator.pop(context);
                    },
                    color: IMMOXLTheme.lightblue,
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Text(
                        allTranslations.text('profile', 'Save').toUpperCase(),
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'PTSans',
                        ),
                      ),
                    ),
                  ),
                ),
              ]),
            )
          ]);
        });
  }

  void _updateUserType(
      {bool isAgent, String company, BuildContext context}) async {
    try {
      await Auth.updateUserType(isAgent, company).then((uid) => Flushbar(
            message: 'Profile updated',
            duration: Duration(milliseconds: 1500),
            flushbarPosition: FlushbarPosition.TOP,
            backgroundColor: Color(0xFF25D366),
          )..show(context));
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
