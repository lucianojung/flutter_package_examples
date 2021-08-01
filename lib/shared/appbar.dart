import 'package:flutter/material.dart';

import 'change_theme_button_widget.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget{
  final String title;

  CustomAppBar({required this.title});

  @override
  PreferredSizeWidget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
      ),
      actions: [
        ChangeThemeButtonWidget(),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(60);
}