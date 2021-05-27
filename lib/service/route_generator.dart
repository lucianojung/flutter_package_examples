import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:package_examples/packages/convex_bottom_bar/convex_bottom_bar_main.dart';
import 'package:package_examples/packages/email_valiator/email_validator_main.dart';
import 'package:package_examples/packages/flutter_signin_button/flutter_signin_button.dart';

import '../main.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => HomeView());
      case '/email_validator':
        return MaterialPageRoute(builder: (_) => EmailValidatorMain());
      case '/flutter_signin_button':
        return MaterialPageRoute(builder: (_) => FlutterSigninButtonMain());
      case '/convex_bottom_bar':
        return MaterialPageRoute(builder: (_) => ConvexBottomBarMain());
      default:
        return _errorRoute(message: 'wrong routing name');
    }
  }

  static Route<dynamic> _errorRoute({required String message}) {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('ERROR: ' + message),
        ),
      );
    });
  }
}
