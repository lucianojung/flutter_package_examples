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
    textTheme: TextTheme(
      displayLarge: _blackTextStyle,
      displayMedium: _blackTextStyle,
      displaySmall: _blackTextStyle,
      headlineMedium: _blackTextStyle,
      headlineSmall: _blackTextStyle,
      titleLarge: _blackTextStyle,
      bodyLarge: _black54TextStyle,
      bodyMedium: _black54TextStyle,
      titleMedium: _black87TextStyle,
      titleSmall: _black87TextStyle,
    ),
    appBarTheme: _appBarTheme,
    colorScheme: ColorScheme.fromSwatch().copyWith(secondary: _secondaryColor),
  );

  static final darkTheme = ThemeData.dark().copyWith(
    primaryColor: _mainColor,
    appBarTheme: _appBarTheme,
    colorScheme: ColorScheme.fromSwatch().copyWith(secondary: _secondaryColor),
  );

  static final _appBarTheme = AppBarTheme(
      foregroundColor: Colors.white,
      shadowColor: _mainColor,
      color: _mainColor,
      iconTheme: IconThemeData(color: Colors.white),
      toolbarTextStyle:
          TextTheme(titleLarge: TextStyle(fontSize: 24.0, color: Colors.white))
              .bodyMedium,
      titleTextStyle:
          TextTheme(titleLarge: TextStyle(fontSize: 24.0, color: Colors.white))
              .titleLarge);
}
