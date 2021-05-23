import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:package_examples/packages/email_valiator/email_validator_main.dart';

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
