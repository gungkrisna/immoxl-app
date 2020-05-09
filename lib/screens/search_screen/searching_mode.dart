import 'package:IMMOXL/theme/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

// import 'package:firebase_auth/firebase_auth.dart';

class SearchingMode extends StatefulWidget {
  @override
  _SearchingModeState createState() => _SearchingModeState();
}

class _SearchingModeState extends State<SearchingMode> {
  String userId;
  int _pricetype = 0;
  int _propertiestype = 0;

  @override
  void initState() {
    super.initState();
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
            'Search',
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
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
                16, MediaQuery.of(context).padding.top, 16, 0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextField(
                    autofocus: true,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                      fontSize: 14,
                      fontFamily: 'PTSans',
                    ),
                    decoration: InputDecoration(
                      hintText: 'Netherlands',
                      hintStyle: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                        fontSize: 14,
                        fontFamily: 'PTSans',
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                          borderSide: BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          )),
                      fillColor: Colors.grey[200],
                      filled: true,
                      contentPadding: EdgeInsets.only(top: 16, bottom: 12),
                      prefixIcon: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: SvgPicture.asset(
                          'assets/icons/search.svg',
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 16, 0, 4),
                    child: Text(
                      'Price type',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        fontFamily: 'PTSans',
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  Wrap(
                      alignment: WrapAlignment.center,
                      spacing: 12.0,
                      children: <Widget>[
                        ChoiceChip(
                          pressElevation: 0.0,
                          selectedColor: IMMOXLTheme.purple,
                          backgroundColor: Colors.grey[300],
                          label: Text(
                            "FOR SALE",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              fontFamily: 'PTSans',
                            ),
                          ),
                          selected: _pricetype == 0,
                          onSelected: (bool selected) {
                            setState(() {
                              _pricetype = selected ? 0 : null;
                            });
                          },
                        ),
                        ChoiceChip(
                          pressElevation: 0.0,
                          selectedColor: IMMOXLTheme.purple,
                          backgroundColor: Colors.grey[300],
                          label: Text(
                            "FOR RENT",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              fontFamily: 'PTSans',
                            ),
                          ),
                          selected: _pricetype == 1,
                          onSelected: (bool selected) {
                            setState(() {
                              _pricetype = selected ? 1 : null;
                            });
                          },
                        ),
                      ]),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 16, 0, 4),
                    child: Text(
                      'Properties type',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        fontFamily: 'PTSans',
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 12.0,
                    children: <Widget>[
                      ChoiceChip(
                        pressElevation: 0.0,
                        selectedColor: IMMOXLTheme.purple,
                        backgroundColor: Colors.grey[300],
                        label: Text(
                          "INDUSTRIAL",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            fontFamily: 'PTSans',
                          ),
                        ),
                        selected: _propertiestype == 0,
                        onSelected: (bool selected) {
                          setState(() {
                            _propertiestype = selected ? 0 : null;
                          });
                        },
                      ),
                      ChoiceChip(
                        pressElevation: 0.0,
                        selectedColor: IMMOXLTheme.purple,
                        backgroundColor: Colors.grey[300],
                        label: Text(
                          "SHOP & RETAIL",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            fontFamily: 'PTSans',
                          ),
                        ),
                        selected: _propertiestype == 1,
                        onSelected: (bool selected) {
                          setState(() {
                            _propertiestype = selected ? 1 : null;
                          });
                        },
                      ),
                      ChoiceChip(
                        pressElevation: 0.0,
                        selectedColor: IMMOXLTheme.purple,
                        backgroundColor: Colors.grey[300],
                        label: Text(
                          "OFFICE",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            fontFamily: 'PTSans',
                          ),
                        ),
                        selected: _propertiestype == 2,
                        onSelected: (bool selected) {
                          setState(() {
                            _propertiestype = selected ? 2 : null;
                          });
                        },
                      )
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 16, 0, 0),
                    child: Container(
                      height: 200,
                      color: IMMOXLTheme.lightgrey,
                      child: Center(child: Text("AdMob Banner")),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 16, 0, 16),
                    child: SizedBox(
                      width: double.maxFinite,
                      child: FlatButton(
                        // Within the SecondRoute widget
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        color: IMMOXLTheme.lightblue,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        child: Padding(
                          padding: EdgeInsets.all(15),
                          child: Text(
                            "SEARCH",
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
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}
