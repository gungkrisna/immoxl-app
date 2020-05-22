import 'package:IMMOXL/theme/styles.dart';
import 'package:IMMOXL/all_translations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

// import 'package:firebase_auth/firebase_auth.dart';

class PublishScreen extends StatefulWidget {
  @override
  _PublishScreenState createState() => _PublishScreenState();
}

class _PublishScreenState extends State<PublishScreen> {
  String userId;
  final int _numPages = 5;
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;
  bool isRent;

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
            : IMMOXLTheme.lightblue.withOpacity(0.2),
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    isRent = false;
    /* FirebaseAuth.instance.currentUser().then((user) {
      userId = user.uid; 
    }); */
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Icon(Icons.arrow_back, color: Colors.black)),
          title: Text(
            'Add Property',
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
        body: Column(children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(32, 16, 32, 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: _buildPageIndicator(),
            ),
          ),
          Expanded(
            child: PageView(
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
                ]),
          ),
          SizedBox(
            width: double.maxFinite,
            child: FlatButton(
              // Within the SecondRoute widget
              onPressed: () {
                Navigator.pop(context);
              },
              color: IMMOXLTheme.lightblue,
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  "NEXT",
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
      ),
    );
  }

  Widget _step1() {
    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 12,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      allTranslations.text(
                          'publish', 'Choose\nListing\nCategory'),
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 32,
                        fontFamily: 'PTSans',
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 32,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Flexible(
                      flex: 3,
                      fit: FlexFit.tight,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            isRent = false;
                          });
                        },
                        child: Container(
                          height: 150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(8),
                            ),
                            color: !isRent
                                ? IMMOXLTheme.purple
                                : IMMOXLTheme.lightgrey,
                          ),
                          child: Center(
                            child: Text(
                              allTranslations.text('property', 'FOR SALE'),
                              style: TextStyle(
                                color: !isRent
                                ? IMMOXLTheme.lightgrey : Colors.grey[400],
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                                fontFamily: 'PTSans',
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Flexible(
                      flex: 3,
                      fit: FlexFit.tight,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            isRent = true;
                          });
                        },
                        child: Container(
                          height: 150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(8),
                            ),
                            color: isRent
                                ? IMMOXLTheme.purple
                                : IMMOXLTheme.lightgrey,
                          ),
                          child: Center(
                            child: Text(
                              allTranslations.text('property', 'FOR RENT'),
                              style: TextStyle(
                                color: isRent
                                ? IMMOXLTheme.lightgrey : Colors.grey[400],
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                                fontFamily: 'PTSans',
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 32,
                ),
              ]),
        ),
      ),
    );
  }

  Widget _step2() {
    return Center(
        child: SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 16,
                ),
                Text(
                  allTranslations.text(
                      'publish', 'What type of property do you want to sell?'),
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 21,
                    fontFamily: 'PTSans',
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Column(
                children: <Widget>[
                  ListTile(
                    contentPadding: EdgeInsets.symmetric(horizontal: 28),
                    leading: CircleAvatar(
                      backgroundColor: IMMOXLTheme.purple,
                      child: ClipOval(
                        child: Icon(Icons.check),
                      ),
                    ),
                    title: Text(
                      "Industrial",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        fontFamily: 'PTSans',
                      ),
                    ),
                    onTap: () {},
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.symmetric(horizontal: 28),
                    leading: CircleAvatar(
                      backgroundColor: IMMOXLTheme.lightgrey,
                      child: ClipOval(
                        child: Icon(
                          Icons.store,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    title: Text(
                      "Shop & Retail",
                      style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.normal,
                        fontSize: 18,
                        fontFamily: 'PTSans',
                      ),
                    ),
                    onTap: () {},
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.symmetric(horizontal: 28),
                    leading: CircleAvatar(
                      backgroundColor: IMMOXLTheme.lightgrey,
                      child: ClipOval(
                        child: Icon(
                          Icons.home,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    title: Text(
                      "Office",
                      style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.normal,
                        fontSize: 18,
                        fontFamily: 'PTSans',
                      ),
                    ),
                    onTap: () {},
                  ),
                ],
              )),
        ])));
  }

  Widget _step3() {
    return SingleChildScrollView(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 16,
                ),
                Text(
                  allTranslations.text(
                      'publish', 'Tell us more about your listing'),
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 21,
                    fontFamily: 'PTSans',
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          Padding(
              padding: EdgeInsets.fromLTRB(0, 16, 0, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    color: Colors.grey[200],
                    width: double.infinity,
                    child: SingleChildScrollView(
                      padding: EdgeInsets.all(10),
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8)),
                                color: Colors.white),
                            child: Icon(Icons.add_a_photo),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    height: 45,
                                    width: 45,
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8)),
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Container(
                                    height: 45,
                                    width: 45,
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8)),
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Container(
                                    height: 45,
                                    width: 45,
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8)),
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Container(
                                    height: 45,
                                    width: 45,
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8)),
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Container(
                                    height: 45,
                                    width: 45,
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8)),
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Container(
                                    height: 45,
                                    width: 45,
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8)),
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Container(
                                    height: 45,
                                    width: 45,
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8)),
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Container(
                                    height: 45,
                                    width: 45,
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8)),
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Container(
                                    height: 45,
                                    width: 45,
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8)),
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Container(
                                    height: 45,
                                    width: 45,
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8)),
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    height: 45,
                                    width: 45,
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8)),
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Container(
                                    height: 45,
                                    width: 45,
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8)),
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Container(
                                    height: 45,
                                    width: 45,
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8)),
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Container(
                                    height: 45,
                                    width: 45,
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8)),
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Container(
                                    height: 45,
                                    width: 45,
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8)),
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Container(
                                    height: 45,
                                    width: 45,
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8)),
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Container(
                                    height: 45,
                                    width: 45,
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8)),
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Container(
                                    height: 45,
                                    width: 45,
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8)),
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Container(
                                    height: 45,
                                    width: 45,
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8)),
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'PTSans',
                    ),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      )),
                      fillColor: Colors.grey[200],
                      filled: true,
                      prefixIcon: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: SizedBox(
                            height: 16,
                            width: 16,
                            child: SvgPicture.asset(
                              'assets/icons/title.svg',
                              color: Colors.black87,
                            )),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Stack(children: [
                    TextFormField(
                      maxLines: 7,
                      keyboardType: TextInputType.multiline,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                        fontFamily: 'PTSans',
                      ),
                      decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.only(left: 47.0, right: 10.0, top: 20.0),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                          width: 0,
                          style: BorderStyle.none,
                        )),
                        fillColor: Colors.grey[200],
                        filled: true,
                      ),
                    ),
                    Positioned(
                      top: 0,
                      left: 0,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12.0, vertical: 10.0),
                        child: Icon(
                          Icons.message,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ]),
                  ListTile(
                    title: Row(children: <Widget>[
                      Text(
                        allTranslations.text('publish', 'Set Location'),
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                          fontSize: 18,
                          fontFamily: 'PTSans',
                        ),
                      ),
                    ]),
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: () {},
                  ),
                  Container(
                    color: Colors.grey[200],
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                "€",
                                style: TextStyle(
                                  fontSize: 24,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'PTSans',
                                ),
                              )),
                        ),
                        Expanded(
                          flex: 7,
                          child: TextField(
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.normal,
                              fontFamily: 'PTSans',
                            ),
                            decoration: InputDecoration(
                              contentPadding:
                                  EdgeInsets.symmetric(vertical: 16),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                width: 0,
                                style: BorderStyle.none,
                              )),
                              fillColor: Colors.grey[200],
                              filled: true,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              )),
        ]));
  }
}
