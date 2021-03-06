import 'package:flutter/material.dart';

class SettingList extends StatelessWidget {
  final List<Widget> children;
  final double height;

  SettingList({required this.children, this.height = 96}) {
    children.add(
      SizedBox(height: this.height),);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: children,
      ),
    );
  }
}
