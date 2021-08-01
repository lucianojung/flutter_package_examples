import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.light;
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
        subtitle1: TextStyle(color: Colors.black87),
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