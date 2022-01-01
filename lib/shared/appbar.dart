import 'package:flutter/material.dart';

import 'change_theme_button_widget.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  CustomAppBar({required this.title});

  @override
  PreferredSizeWidget build(BuildContext context) {
    return AppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset(
            'assets/icons/favicon-96x96.png',
            fit: BoxFit.contain,
            height: 32,
          ),
          Container(
              padding: const EdgeInsets.all(8.0), child: Text(title))
        ],
      ),
      actions: [
        ChangeThemeButtonWidget(),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(60);
}
