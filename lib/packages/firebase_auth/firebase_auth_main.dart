import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_builder.dart';
import 'package:package_examples/packages/firebase_auth/register_page.dart';
import 'package:package_examples/packages/firebase_auth/signin_page.dart';

/// Provides a UI to select a authentication type page
class FirebaseAuthMain extends StatelessWidget {
  // Navigates to a new page
  void _pushPage(BuildContext context, Widget page) {
    Navigator.of(context) /*!*/ .push(
      MaterialPageRoute<void>(builder: (_) => page),
    );
  }
  // https://blog.logrocket.com/implementing-firebase-authentication-in-a-flutter-app/#create-a-flutter-and-firebase-project
  // https://console.firebase.google.com/project/flutter-packages-c22a0/overview

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Firebase Example App'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(16),
            alignment: Alignment.center,
            child: SignInButtonBuilder(
              icon: Icons.person_add,
              backgroundColor: Colors.indigo,
              text: 'Registration',
              onPressed: () => _pushPage(context, RegisterPage()),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            alignment: Alignment.center,
            child: SignInButtonBuilder(
              icon: Icons.verified_user,
              backgroundColor: Colors.orange,
              text: 'Sign In',
              onPressed: () => _pushPage(context, SignInPage()),
            ),
          ),
        ],
      ),
    );
  }
}