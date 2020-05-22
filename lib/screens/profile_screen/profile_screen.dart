import 'package:IMMOXL/main.dart';
import 'package:IMMOXL/screens/profile_screen/notification_screen.dart';
import 'package:IMMOXL/screens/profile_screen/settings_screen.dart';
import 'package:IMMOXL/screens/property_screen/property_screen.dart';
import 'package:IMMOXL/screens/widgets/listing_widget.dart';
import 'package:IMMOXL/services/services.dart';
import 'package:IMMOXL/theme/styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../all_translations.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

DocumentReference userRef;

class _ProfileScreenState extends State<ProfileScreen> {
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
              duration: Duration(seconds: 2),
            )),
      );
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              leading: GestureDetector(
                  onTap: () => Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return NotificationScreen();
                      })),
                  child: Icon(Icons.notifications, color: Colors.white)),
              actions: <Widget>[
                GestureDetector(
                    onTap: () => _settingModalBottomSheet(context),
                    child: Icon(Icons.more_vert, color: Colors.white)),
                SizedBox(width: 16)
              ],
              title: Text(
                'My Profile',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  fontFamily: 'PTSans',
                ),
              ),
              centerTitle: true,
              backgroundColor: IMMOXLTheme.purple,
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
                      padding: EdgeInsets.only(
                          bottom: 58 + MediaQuery.of(context).padding.bottom),
                      child: Stack(children: <Widget>[
                        SingleChildScrollView(
                            padding: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * 0.2 +
                                    30),
                            scrollDirection: Axis.vertical,
                            child: myListing(context)),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.2 + 5,
                          decoration: BoxDecoration(color: IMMOXLTheme.purple),
                          child: Padding(
                            padding: EdgeInsets.all(20),
                            child: Column(children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    width: 70.0,
                                    height: 70.0,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white,
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: snapshot.data['avatar'] != null
                                            ? NetworkImage(
                                                snapshot.data['avatar'])
                                            : AssetImage(
                                                "assets/images/avatar.png"),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 16),
                                  Container(
                                    height: 70.0,
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Row(children: <Widget>[
                                            Text(
                                              snapshot.data['name']
                                                  .split(' ')[0],
                                              style: TextStyle(
                                                color: IMMOXLTheme.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20,
                                                fontFamily: 'PTSans',
                                              ),
                                              textAlign: TextAlign.start,
                                            ),
                                            SizedBox(width: 5),
                                            Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(5)),
                                                  color: IMMOXLTheme.white,
                                                ),
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 2, horizontal: 6),
                                                child: Text(
                                                  'PROFESSIONAL',
                                                  style: TextStyle(
                                                    color: IMMOXLTheme.purple,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 12,
                                                    fontFamily: 'PTSans',
                                                  ),
                                                )),
                                          ]),
                                          Text(
                                            snapshot.data['state'] != null
                                                ? "${snapshot.data['state']}"
                                                : '',
                                            style: TextStyle(
                                              color: IMMOXLTheme.white,
                                              fontWeight: FontWeight.normal,
                                              fontSize: 14,
                                              fontFamily: 'PTSans',
                                            ),
                                            textAlign: TextAlign.start,
                                          ),
                                        ]),
                                  ),
                                ],
                              ),
                            ]),
                          ),
                        ),
                        Positioned(
                          top: MediaQuery.of(context).size.height * 0.2 - 25,
                          left: 30,
                          right: 30,
                          child: Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: Colors.grey[50],
                                borderRadius: BorderRadius.all(
                                  Radius.circular(16),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                      color: IMMOXLTheme.darkgrey,
                                      blurRadius: 5,
                                      spreadRadius: 0,
                                      offset: Offset(3.0, 3.0))
                                ]),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      '25',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'PTSans',
                                      ),
                                    ),
                                    Text(
                                      'Listings',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.black,
                                        fontWeight: FontWeight.normal,
                                        fontFamily: 'PTSans',
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      '140',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'PTSans',
                                      ),
                                    ),
                                    Text(
                                      'Followers',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.black,
                                        fontWeight: FontWeight.normal,
                                        fontFamily: 'PTSans',
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      '70',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'PTSans',
                                      ),
                                    ),
                                    Text(
                                      'Following',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.black,
                                        fontWeight: FontWeight.normal,
                                        fontFamily: 'PTSans',
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ]));
                })));
  }

  Widget myListing(context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "1 Object Listed",
            style: TextStyle(
              color: Colors.grey[700],
              fontWeight: FontWeight.bold,
              fontSize: 14,
              fontFamily: 'PTSans',
            ),
            textAlign: TextAlign.left,
          ),
          SizedBox(
            height: 10,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return PropertyScreen(
                  propertyId: '873278',
                );
              }));
            },
            child: ListingWidget(
              propertyId: '873278',
              agentProfileAvatar:
                  "https://upload.wikimedia.org/wikipedia/commons/5/56/Donald_Trump_official_portrait.jpg",
              agentProfileName: 'Carl Johnson',
              propertyPicture:
                  'https://www.whitehouse.gov/wp-content/uploads/2017/12/P20170614JB-0303-2-1024x683.jpg',
              propertyLocation: 'Amsterdam, Netherlands',
              propertyPrice: '€250.000',
              propertyStatus: allTranslations.text('property', 'FOR RENT'),
              isFavorite: false,
            ),
          ),
        ],
      ),
    );
  }

  _logout() async {
    await Auth.signOut().then((uid) => Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => MyApp(),
          ),
        ));
  }

  void _settingModalBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            child: Wrap(
              children: <Widget>[
                ListTile(
                    title: Text(
                      'Settings',
                    ),
                    onTap: () => Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return SettingsScreen();
                        }))),
                ListTile(
                    title: Text(
                      'Share',
                    ),
                    onTap: () => Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return SettingsScreen();
                        }))),
                ListTile(
                  title: Text(
                    'Feedback',
                  ),
                  onTap: () => {},
                ),
                ListTile(
                  title: Text(
                    'Sign out',
                    style: TextStyle(color: Colors.red),
                  ),
                  onTap: () => _logout(),
                ),
              ],
            ),
          );
        });
  }
}
