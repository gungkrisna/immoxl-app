import 'package:IMMOXL/screens/property_screen/property_screen.dart';
import 'package:IMMOXL/screens/widgets/listing_widget.dart';
import 'package:IMMOXL/theme/styles.dart';
import 'package:flutter/material.dart';
import 'package:IMMOXL/all_translations.dart';

// import 'package:firebase_auth/firebase_auth.dart';

class SavedScrean extends StatefulWidget {
  @override
  _SavedScreanState createState() => _SavedScreanState();
}

class _SavedScreanState extends State<SavedScrean>
    with SingleTickerProviderStateMixin {
  TabController controller;
  @override
  void initState() {
    super.initState();

    controller = TabController(
      length: 2,
      vsync: this,
    );
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
              expandedHeight: 100,
              floating: true,
              pinned: true,
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(53),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: TabBar(
                    labelColor: Colors.black,
                    unselectedLabelColor: IMMOXLTheme.darkgrey,
                    indicatorPadding: EdgeInsets.all(0.0),
                    indicator: UnderlineTabIndicator(
                        borderSide: BorderSide(
                            width: 4.0, color: IMMOXLTheme.lightblue),
                        insets: EdgeInsets.symmetric(horizontal: 10.0)),
                    tabs: [
                      Tab(text: allTranslations.text('saved', 'PROPERTY')),
                      Tab(text: allTranslations.text('saved', 'SEARCH')),
                    ],
                    controller: controller,
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
                      child: Center(
                        child: Text(
                          allTranslations.text('saved', 'Saved'),
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            fontFamily: 'PTSans',
                          ),
                        ),
                      )),
                ),
              ),
            ),
            SliverFillRemaining(
                child: TabBarView(controller: controller, children: <Widget>[
              savedPropertyTab(context),
              savedSearchTab(context),
            ])),
          ],
        ),
      ),
    );
  }

  Widget savedPropertyTab(context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
          20, 20, 20, MediaQuery.of(context).padding.bottom),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "1 RESULT FOUND",
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

  Widget savedSearchTab(context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
          20, 20, 20, MediaQuery.of(context).padding.bottom),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "1 RESULT FOUND",
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
}
