import 'package:IMMOXL/screens/property_screen/property_screen.dart';
import 'package:IMMOXL/screens/search_screen/searching_mode.dart';
import 'package:IMMOXL/screens/widgets/listing_widget.dart';
import 'package:IMMOXL/theme/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:IMMOXL/translations.dart';

// import 'package:firebase_auth/firebase_auth.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
    with SingleTickerProviderStateMixin {
  String userId;
  bool isSaveSearch = false;

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
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              snap: true,
              elevation: 20,
              backgroundColor: Colors.transparent,
              expandedHeight: 124,
              floating: true,
              pinned: true,
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(53),
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 15, right: 20, bottom: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          FilterChip(
                            label: Text(
                              Translations.of(context)
                                  .text('property', 'FOR SALE'),
                              style: TextStyle(
                                color: IMMOXLTheme.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                fontFamily: 'PTSans',
                              ),
                            ),
                            backgroundColor: IMMOXLTheme.purple,
                            onSelected: (bool value) {
                              print("selected");
                            },
                          ),
                          SizedBox(
                            width: 12,
                          ),
                          FilterChip(
                            label: Text(
                              Translations.of(context)
                                  .text('property', 'Office')
                                  .toUpperCase(),
                              style: TextStyle(
                                color: IMMOXLTheme.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                fontFamily: 'PTSans',
                              ),
                            ),
                            backgroundColor: IMMOXLTheme.purple,
                            onSelected: (bool value) {
                              print("selected");
                            },
                          ),
                        ],
                      ),
                      Text(
                        Translations.of(context)
                                  .text('property', 'FILTER')
                                  .toUpperCase(),
                        style: TextStyle(
                          color: IMMOXLTheme.lightblue,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          fontFamily: 'PTSans',
                        ),
                      )
                    ],
                  ),
                ),
              ),
              flexibleSpace: DecoratedBox(
                decoration: BoxDecoration(
                  color: IMMOXLTheme.lightgrey,
                ),
                child: FlexibleSpaceBar(
                  background: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(
                              top: MediaQuery.of(context).padding.top + 25,
                              left: 20,
                              right: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              SvgPicture.asset(
                                'assets/icons/sort.svg',
                                color: Colors.black,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return SearchingMode();
                                  }));
                                },
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.65,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(12),
                                    ),
                                    color: Colors.grey[300],
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Column(
                                      children: <Widget>[
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Text(
                                              'Netherlands',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.normal,
                                                fontSize: 14,
                                                fontFamily: 'PTSans',
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 10),
                              GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      isSaveSearch =
                                          isSaveSearch ? false : true;
                                    });
                                  },
                                  child: Icon(
                                    isSaveSearch
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    color: isSaveSearch
                                        ? Colors.red
                                        : Colors.black,
                                  )),
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
              child: filteredResult(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget filteredResult(context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
          20, 20, 20, MediaQuery.of(context).padding.bottom),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "1 OFFICE FOR SALE",
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
              propertyStatus: Translations.of(context).text('property',
                                'FOR RENT'),
              isFavorite: false,
            ),
          ),
        ],
      ),
    );
  }
}
