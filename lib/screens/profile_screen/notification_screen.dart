import 'package:IMMOXL/theme/styles.dart';
import 'package:IMMOXL/all_translations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class NotificationScreen extends StatefulWidget {
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
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
                allTranslations.text('profile', 'Notifications'),
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
                    child: Center(
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                        Text(
                          allTranslations.text('profile', 'No notification'),
                          style: TextStyle(
                            color: IMMOXLTheme.darkgrey,
                            fontWeight: FontWeight.normal,
                            fontSize: 20,
                            fontFamily: 'PTSans',
                          ),
                          textAlign: TextAlign.center,
                        ),
                    ])),
                    ),
                  );
                })));
  }
}
