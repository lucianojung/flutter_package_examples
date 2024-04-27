import 'package:flutter/material.dart';
import 'package:widget_decompiler/widget_decompiler.dart';

import '../../shared/package_weblink_view.dart';

class WidgetDecompilerMain extends StatefulWidget {
  @override
  _WidgetDecompilerState createState() => _WidgetDecompilerState();
}

class _WidgetDecompilerState extends State<WidgetDecompilerMain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: WidgetDecompiler(
          backgroundColor: Colors.blueAccent,
          widgetName: 'PackageWeblinkView',
          width: 1000,
          child: PackageWeblinkView('widget_decompiler 0.9.1',
              'https://pub.dev/packages/widget_decompiler'),
        ),
      ),
    );
  }
}
