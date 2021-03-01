import 'package:flutter/material.dart';

enum TabItem { search, ladder}

class TabItemData {
  const TabItemData({@required this.title, @required this.icon});

  final String title;
  final IconData icon;

  static const Map<TabItem, TabItemData> allTabs = {
    TabItem.search: TabItemData(title: 'Search', icon: Icons.search),
    TabItem.ladder: TabItemData(title: 'Challanger ladder', icon: Icons.view_headline),
  };
}