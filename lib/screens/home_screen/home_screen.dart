import 'package:IMMOXL/screens/widgets/listing_widget.dart';
import 'package:IMMOXL/theme/styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:IMMOXL/screens/property_screen/property_screen.dart';
import 'package:IMMOXL/all_translations.dart';
// import 'package:firebase_auth/firebase_auth.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  TabController controller;
  int homeTabBar = 1;
  int homeTabBarGetter() => homeTabBar;
  DocumentReference userRef;

  @override
  void initState() {
    super.initState();
    controller = TabController(
      length: 2,
      vsync: this,
    );
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
            resizeToAvoidBottomInset: false,
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
                  return CustomScrollView(
                    slivers: <Widget>[
                      SliverAppBar(
                        elevation: 20,
                        backgroundColor: Colors.transparent,
                        expandedHeight: 194,
                        floating: false,
                        pinned: true,
                        bottom: PreferredSize(
                            preferredSize: const Size.fromHeight(80),
                            child: Column(children: <Widget>[
                              Padding(
                                padding: EdgeInsets.fromLTRB(16, 16, 16, 12),
                                child: TextField(
                                  style: TextStyle(
                                    color: IMMOXLTheme.white,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 14,
                                    fontFamily: 'PTSans',
                                  ),
                                  decoration: InputDecoration(
                                    hintText: allTranslations.text('home',
                                        'Search an office, shop, or industrial halls'),
                                    hintStyle: TextStyle(
                                      color: IMMOXLTheme.white,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 14,
                                      fontFamily: 'PTSans',
                                    ),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(12)),
                                        borderSide: BorderSide(
                                          width: 0,
                                          style: BorderStyle.none,
                                        )),
                                    fillColor:
                                        IMMOXLTheme.white.withOpacity(0.5),
                                    filled: true,
                                    contentPadding:
                                        EdgeInsets.only(top: 16, bottom: 12),
                                    prefixIcon: FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: SizedBox(
                                          height: 20,
                                          width: 20,
                                          child: SvgPicture.asset(
                                            'assets/icons/search.svg',
                                            color: IMMOXLTheme.white,
                                          )),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15.0),
                                child: TabBar(
                                  indicatorPadding: EdgeInsets.all(0.0),
                                  indicator: UnderlineTabIndicator(
                                      borderSide: BorderSide(
                                          width: 4.0,
                                          color: IMMOXLTheme.lightblue),
                                      insets: EdgeInsets.symmetric(
                                          horizontal: 10.0)),
                                  tabs: [
                                    Tab(
                                        text: allTranslations.text(
                                            'home', 'NEW')),
                                    Tab(
                                        text: allTranslations.text(
                                            'home', 'FOLLOWING')),
                                  ],
                                  controller: controller,
                                ),
                              ),
                            ])),
                        flexibleSpace: DecoratedBox(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20),
                            ),
                            color: IMMOXLTheme.lightblue,
                            gradient: LinearGradient(
                                colors: [
                                  IMMOXLTheme.blue,
                                  IMMOXLTheme.purple,
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight),
                          ),
                          child: FlexibleSpaceBar(
                            background: Container(
                              width: MediaQuery.of(context).size.width,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top:
                                            MediaQuery.of(context).padding.top +
                                                25,
                                        left: 20,
                                        right: 20),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                allTranslations.text(
                                                        'home', 'Welcome') +
                                                    ', ' +
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
                                              Text(
                                                allTranslations.text('home',
                                                    'Explore new property today'),
                                                style: TextStyle(
                                                  color: IMMOXLTheme.white,
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 14,
                                                  fontFamily: 'PTSans',
                                                ),
                                                textAlign: TextAlign.start,
                                              ),
                                            ]),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Container(
                                          width: 50.0,
                                          height: 50.0,
                                          decoration: new BoxDecoration(
                                            color: Colors.white,
                                            shape: BoxShape.circle,
                                            image: new DecorationImage(
                                              fit: BoxFit.cover,
                                              image: snapshot.data['avatar'] !=
                                                      null
                                                  ? NetworkImage(
                                                      snapshot.data['avatar'])
                                                  : AssetImage(
                                                      "assets/images/avatar.png"),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SliverFillRemaining(
                          child: TabBarView(
                              controller: controller,
                              children: <Widget>[
                            newTab(context),
                            followingTab(context),
                          ])),
                    ],
                  );
                })));
  }

  Widget newTab(context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
          20, 20, 20, MediaQuery.of(context).padding.bottom),
      child: Column(
        children: <Widget>[
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

  Widget followingTab(context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
          20, 20, 20, MediaQuery.of(context).padding.bottom),
      child: Column(
        children: <Widget>[],
      ),
    );
  }
}
