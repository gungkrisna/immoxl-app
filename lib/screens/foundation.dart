import 'package:IMMOXL/components/bottombar_component.dart';
import 'package:flutter/material.dart';
import 'home_screen/home_screen.dart';
import 'search_screen/search_screen.dart';
import 'package:IMMOXL/models/tabIcon_model.dart';
import 'profile_screen/profile_screen.dart';
import 'saved_screen/saved_screen.dart';

class Foundation extends StatefulWidget {
  @override
  _FoundationState createState() => _FoundationState();
}

class _FoundationState extends State<Foundation> with TickerProviderStateMixin {
  AnimationController animationController;

  List<TabIconData> tabIconsList = TabIconData.tabIconsList;

  Widget tabBody = Container(
    color: Colors.white,
  );

  @override
  void initState() {
    tabIconsList.forEach((TabIconData tab) {
      tab.isSelected = false;
    });
    tabIconsList[0].isSelected = true;
    tabBody = HomeScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: FutureBuilder<bool>(
          future: getData(),
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            if (!snapshot.hasData) {
              return const SizedBox();
            } else {
              return Stack(
                children: <Widget>[
                  tabBody,
                  bottomBar(),
                ],
              );
            }
          },
        ),
      ),
    );
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    return true;
  }

  Widget bottomBar() {
    return Column(
      children: <Widget>[
        const Expanded(
          child: SizedBox(),
        ),
        BottomBarComponent(
          tabIconsList: tabIconsList,
          addClick: () {},
          changeIndex: (int index) {
            if (index == 0) {
              if (!mounted) {
                return;
              }
              setState(() {
                tabBody = HomeScreen();
              });
            } else if (index == 1) {
              if (!mounted) {
                return;
              }
              setState(() {
                tabBody = SearchScreen();
              });
            } else if (index == 2) {
              if (!mounted) {
                return;
              }
              setState(() {
                tabBody = SavedScrean();
              });
            } else if (index == 3) {
              if (!mounted) {
                return;
              }
              setState(() {
                tabBody = ProfileScreen();
              });
            }
          },
        ),
      ],
    );
  }
}
