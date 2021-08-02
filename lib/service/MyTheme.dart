import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.system;
  bool get isDarkMode => themeMode == ThemeMode.dark;

  void toggleTheme(bool isDarkMode) {
    themeMode = isDarkMode ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}

class MyTheme {
  static Color _mainColor = Color(0xff67bcb3);

  static final lightTheme = ThemeData.light().copyWith(
      primaryColor: _mainColor,
      accentColor: Color(0xff92ded6),
      textTheme: TextTheme(
        headline1: TextStyle(color: Colors.black),
        headline2: TextStyle(color: Colors.black),
        headline3: TextStyle(color: Colors.black),
        headline4: TextStyle(color: Colors.black),
        headline5: TextStyle(color: Colors.black),
        headline6: TextStyle(color: Colors.black),
        subtitle1: TextStyle(color: Colors.black87),
        subtitle2: TextStyle(color: Colors.black87),
        bodyText1: TextStyle(color: Colors.black54),
        bodyText2: TextStyle(color: Colors.black54),
      ),
      appBarTheme: _appBarTheme,
    );

  static final darkTheme = ThemeData.dark().copyWith(
      primaryColor: _mainColor,
      accentColor: Color(0xff92ded6),
      appBarTheme: _appBarTheme,
    );

  static final _appBarTheme = AppBarTheme(
        foregroundColor: Colors.white,
        shadowColor: _mainColor,
        color: _mainColor,
        textTheme: TextTheme(
            headline6: TextStyle(fontSize: 24.0, color: Colors.white)
        ),
        iconTheme: IconThemeData(
            color: Colors.white
        )
    );
}