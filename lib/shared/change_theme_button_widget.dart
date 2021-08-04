import 'package:flutter/material.dart';
import 'package:package_examples/service/MyTheme.dart';
import 'package:provider/provider.dart';

class ChangeThemeButtonWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return IconButton(onPressed: () {
      final provider = Provider.of<ThemeProvider>(context, listen: false);
      provider.toggleTheme(!provider.isDarkMode);
    }, icon: Icon(Icons.brightness_medium),);
  }
}
