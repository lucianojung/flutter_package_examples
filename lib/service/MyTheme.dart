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
  static Color _secondaryColor = Color(0xff92ded6);
  static TextStyle _blackTextStyle = TextStyle(color: Colors.black);
  static TextStyle _black54TextStyle = TextStyle(color: Colors.black54);
  static TextStyle _black87TextStyle = TextStyle(color: Colors.black87);

  static final lightTheme = ThemeData.light().copyWith(
      primaryColor: _mainColor,
      accentColor: _secondaryColor,
      textTheme: TextTheme(
        headline1: _blackTextStyle,
        headline2: _blackTextStyle,
        headline3: _blackTextStyle,
        headline4: _blackTextStyle,
        headline5: _blackTextStyle,
        headline6: _blackTextStyle,
        bodyText1: _black54TextStyle,
        bodyText2: _black54TextStyle,
        subtitle1: _black87TextStyle,
        subtitle2: _black87TextStyle,
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