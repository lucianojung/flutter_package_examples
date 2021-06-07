import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:package_examples/shared/package_weblink_view.dart';
import 'package:package_examples/shared/setting_list.dart';

class EmailValidatorMain extends StatefulWidget {
  @override
  _EmailValidatorMainState createState() => _EmailValidatorMainState();
}

class _EmailValidatorMainState extends State<EmailValidatorMain> {
  bool _isValid = false;
  final myController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Email Validator'),
      ),
      body: Stack(
        children: [
          SettingList(children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter a valid Email Adress'
                ),
                onChanged: (value) => {
                  setState(() {
                    _isValid = EmailValidator.validate(value);
                  }),
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(_isValid ? 'Email is valid.' : 'Email is not valid.'),
            ),
          ]),
          PackageWeblinkView('email_validator 2.0.1', 'https://pub.dev/packages/email_validator', 0),
        ],
      ),
    );
  }
}