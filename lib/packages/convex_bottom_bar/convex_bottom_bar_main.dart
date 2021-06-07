import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:package_examples/shared/material_dropdown_view.dart';
import 'package:package_examples/shared/package_weblink_view.dart';
import 'package:package_examples/shared/setting_list.dart';

class ConvexBottomBarMain extends StatefulWidget {
  @override
  _ConvexBottomBarMainState createState() => _ConvexBottomBarMainState();
}

class _ConvexBottomBarMainState extends State<ConvexBottomBarMain> {
  TabStyle _tabstyle = TabStyle.textIn;
  bool _fiveItems = false;
  bool _rainbowGradient = false;
  bool _badges = false;
  List<TabItem> _fiveTabItems = [
    TabItem(title: 'list', icon: Icons.list),
    TabItem(title: 'work', icon: Icons.work),
    TabItem(title: 'calendar', icon: Icons.calendar_today),
    TabItem(title: 'link', icon: Icons.link),
    TabItem(title: 'assessment', icon: Icons.assessment),
  ];
  List<TabItem> _threeTabItems = [
    TabItem(title: 'list', icon: Icons.list),
    TabItem(title: 'calendar', icon: Icons.calendar_today),
    TabItem(title: 'assessment', icon: Icons.assessment),
  ];
  Map<int, dynamic> emptyBadgeList = {};
  Map<int, dynamic> listOfBadges = {};
  String _tabbedTab = 'calendar';
  double _height = 50;
  double _top = -50;
  double _curveSize = 125;

  @override
  void initState() {
    listOfBadges = {
      0: iconBadge(1),
      1: iconBadge(12),
      2: iconBadge(7),
    };
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Convex Bottom AppBar'),
      ),
      body: Stack(
        children: <Widget>[
          settingList(),
          PackageWeblinkView('convex_bottom_bar 3.0.0',
              'https://pub.dev/packages/convex_bottom_bar', bottom: -_top),
        ],
      ),
      bottomNavigationBar: _convexAppBar(),
    );
  }

  ConvexAppBar _convexAppBar() {
    return ConvexAppBar.badge(
      _badges ? listOfBadges : emptyBadgeList,
      style: _tabstyle,
      height: _height,
      top: _top,
      curveSize: _curveSize,
      items: _fiveItems ? _fiveTabItems : _threeTabItems,
      initialActiveIndex: _fiveItems ? 2 : 1,
      onTap: (int i) {
        setState(() {
          _tabbedTab =
              (_fiveItems ? _fiveTabItems[i].title! : _threeTabItems[i].title!);
          _showButtonPressDialog(context, _tabbedTab);
        });
      },
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: _rainbowGradient
            ? [
                Color(0xFF9400D3),
                Color(0xFF4B0082),
                Color(0xFF0000FF),
                Color(0xFF00FF00),
                Color(0xFFFFFF00),
                Color(0xFFFF7F00),
                Color(0xFFFF0000)
              ]
            : [Color(0xFF0763e5), Color(0xFF0993f3)],
        tileMode: TileMode.repeated,
      ),
    );
  }

  Widget iconBadge(int count) {
    return Container(
      padding: EdgeInsets.all(2),
      decoration: new BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(6),
      ),
      constraints: BoxConstraints(
        minWidth: 14,
        minHeight: 14,
      ),
      child: Text(
        '$count',
        style: TextStyle(
          color: Colors.white,
          fontSize: 8,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget settingList() {
    return SettingList(height: 96.0 -_top, children: [
      Padding(
        padding: const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
        child: MaterialDropdownView(
          title: 'TabStyle',
          subtitle: 'Select a tabstyle to display below',
          onChangedCallback: (newValue) {
            _onValueChanged(newValue);
          },
          value: _tabstyle.name,
          values: TabStyle.values.map((e) => e.name).toList(),
          negate: false,
        ),
      ),
      SizedBox(
        height: 16.0,
      ),
      Container(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        alignment: Alignment.centerLeft,
        child: Text(
          'Height',
        ),
      ),
      Slider(
          value: _height,
          min: _tabstyle == TabStyle.titled ? 20 : 50,
          max: _tabstyle == TabStyle.titled ? 70 : 100,
          divisions: 10,
          label: '$_height',
          onChanged: (newRange) {
            setState(() {
              _height = newRange;
            });
          }),
      Container(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        alignment: Alignment.centerLeft,
        child: Text(
          'Top',
        ),
      ),
      Slider(
          value: _top,
          min: max(-_curveSize + 1, -95),
          max: -15,
          divisions: 16,
          label: '$_top',
          onChanged: (newRange) {
            setState(() {
              _top = newRange;
            });
          }),
      Container(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        alignment: Alignment.centerLeft,
        child: Text(
          'Curve Size',
        ),
      ),
      Slider(
          value: _curveSize,
          min: 50,
          max: 250,
          divisions: 20,
          label: '$_curveSize',
          onChanged: (newRange) {
            setState(() {
              _curveSize = newRange;
              _top = max(-_curveSize + 1, _top);
            });
          }),
      CheckboxListTile(
        title: Text("Show 5 Items"),
        value: _fiveItems,
        onChanged: (newValue) {
          setState(() {
            _fiveItems = newValue!;
            _tabbedTab = (_fiveItems
                ? _fiveTabItems[2].title!
                : _threeTabItems[1].title!);
          });
        },
        controlAffinity: ListTileControlAffinity.leading,
      ),
      CheckboxListTile(
        title: Text("Rainbow Gradient"),
        value: _rainbowGradient,
        onChanged: (newValue) {
          setState(() {
            _rainbowGradient = newValue!;
          });
        },
        controlAffinity: ListTileControlAffinity.leading,
      ),
      CheckboxListTile(
        title: Text("show TabItem Badges"),
        value: _badges,
        onChanged: (newValue) {
          setState(() {
            _badges = newValue!;
          });
        },
        controlAffinity: ListTileControlAffinity.leading,
      ),
    ]);
  }

  void _showButtonPressDialog(BuildContext context, String tabItem) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('$tabItem Tab Clicked!'),
      backgroundColor: Colors.black26,
      duration: Duration(milliseconds: 400),
    ));
  }

  void _onValueChanged(String newValue) {
    setState(() {
      _tabstyle = _getTabStylefromString(newValue);
      if (_height < 50 || _height > 70) _height = 50;
    });
  }

  TabStyle _getTabStylefromString(String name) {
    switch (name) {
      case 'fixed':
        return TabStyle.fixed;
      case 'custom':
        return TabStyle.custom;
      case 'fixedCircle':
        return TabStyle.fixedCircle;
      case 'flip':
        return TabStyle.flip;
      case 'react':
        return TabStyle.react;
      case 'reactCircle':
        return TabStyle.reactCircle;
      case 'textIn':
        return TabStyle.textIn;
      case 'titled':
        return TabStyle.titled;
      case 'Google':
      default:
        return TabStyle.fixed;
    }
  }
}

extension TabStyleExtension on TabStyle {
  String get name {
    switch (this) {
      case TabStyle.fixed:
        return 'fixed';
      case TabStyle.custom:
        return 'custom';
      case TabStyle.fixedCircle:
        return 'fixedCircle';
      case TabStyle.flip:
        return 'flip';
      case TabStyle.react:
        return 'react';
      case TabStyle.reactCircle:
        return 'reactCircle';
      case TabStyle.textIn:
        return 'textIn';
      case TabStyle.titled:
        return 'titled';
      default:
        return '';
    }
  }
}
