import 'package:flutter/material.dart';

class TabIconData {
  TabIconData({
    this.icon,
    this.index = 0,
    this.isSelected = false,
    this.animationController,
  });

  bool isSelected;
  int index;
  String icon;

  AnimationController animationController;

  static List<TabIconData> tabIconsList = <TabIconData>[
    TabIconData(
      icon: 'assets/icons/home.svg',
      index: 0,
      isSelected: true,
      animationController: null,
    ),
    TabIconData(
      icon: 'assets/icons/search.svg',
      index: 1,
      isSelected: false,
      animationController: null,
    ),
    TabIconData(
      icon: 'assets/icons/favorite_border.svg',
      index: 2,
      isSelected: false,
      animationController: null,
    ),
    TabIconData(
      icon: 'assets/icons/account_circle.svg',
      index: 3,
      isSelected: false,
      animationController: null,
    ),
  ];
}
