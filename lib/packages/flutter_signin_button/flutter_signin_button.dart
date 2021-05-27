import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:package_examples/shared/material_dropdown_view.dart';
import 'package:package_examples/shared/package_weblink_view.dart';

class FlutterSigninButtonMain extends StatefulWidget {
  @override
  _FlutterSigninButtonMainState createState() =>
      _FlutterSigninButtonMainState();
}

class _FlutterSigninButtonMainState extends State<FlutterSigninButtonMain> {
  Buttons _button = Buttons.Email;
  bool _mini = false;
  bool _customMini = false;
  TextEditingController _controller = TextEditingController(text: 'Facebook');

  IconData? _iconDataGroup = Icons.facebook;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Signin Button'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding:
                    const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
                child: MaterialDropdownView(
                  title: 'Signin Button',
                  subtitle: 'Select a button to display below',
                  onChangedCallback: (newValue) {
                    _onValueChanged(newValue);
                  },
                  value: _button.name,
                  values: Buttons.values.map((e) => e.name).toList(),
                  negate: false,
                ),
              ),
              if (!(_button == Buttons.Google ||
                  _button == Buttons.GoogleDark ||
                  _button == Buttons.FacebookNew))
                CheckboxListTile(
                  title: Text("Mini button"),
                  value: _mini,
                  onChanged: (newValue) {
                    setState(() {
                      _mini = newValue!;
                    });
                  },
                  controlAffinity: ListTileControlAffinity.leading,
                ),
              SignInButton(
                _button,
                text: 'Sign in with ${_button.name}',
                onPressed: () {
                  _showButtonPressDialog(context, _button.name);
                },
                mini: _mini,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Divider(),
              ),
              Container(
                padding: EdgeInsets.all(16.0),
                alignment: Alignment.centerLeft,
                child: Text(
                  'Signin Button Builder',
                  style: Theme.of(context).textTheme.headline5,
                ),
              ),
              RadioListTile<IconData>(
                  title: Align(
                      alignment: Alignment.centerLeft,
                      child: Icon(Icons.facebook)),
                  subtitle: Text('Facebook Icon'),
                  value: Icons.facebook,
                  groupValue: _iconDataGroup,
                  onChanged: (newValue) => _onRadioChanged(newValue!)),
              RadioListTile<IconData>(
                  title: Align(
                      alignment: Alignment.centerLeft,
                      child: Icon(Icons.message)),
                  subtitle: Text('Message Icon'),
                  value: Icons.message,
                  groupValue: _iconDataGroup,
                  onChanged: (newValue) => _onRadioChanged(newValue!)),
              RadioListTile<IconData>(
                  title: Align(
                      alignment: Alignment.centerLeft,
                      child: Icon(Icons.audiotrack)),
                  subtitle: Text('Audiotrack Icon'),
                  value: Icons.audiotrack,
                  groupValue: _iconDataGroup,
                  onChanged: (newValue) => _onRadioChanged(newValue!)),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter a Button Name to display'),
                  onChanged: (value) => {
                    setState(() { }),
                  },
                ),
              ),
              CheckboxListTile(
                title: Text("Mini button"),
                value: _customMini,
                onChanged: (newValue) {
                  setState(() {
                    _customMini = newValue!;
                  });
                },
                controlAffinity: ListTileControlAffinity.leading,
              ),
              SignInButtonBuilder(
                icon: _iconDataGroup,
                text: 'Sign in with ${_controller.text}',
                onPressed: () {
                  _showButtonPressDialog(context, _controller.text);
                },
                mini: _customMini,
                backgroundColor: Colors.blueAccent,
              ),
              SizedBox(height: 16),
              PackageWeblinkView('flutter_signin_button 2.0.0',
                  'https://pub.dev/packages/flutter_signin_button'),
            ],
          ),
        ),
      ),
    );
  }

  void _showButtonPressDialog(BuildContext context, String provider) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('$provider Button Pressed!'),
      backgroundColor: Colors.black26,
      duration: Duration(milliseconds: 400),
    ));
  }

  void _onValueChanged(String newValue) {
    setState(() {
      _button = _getButtonfromString(newValue);
    });
  }

  void _onRadioChanged(IconData newValue) {
    setState(() {
      _iconDataGroup = newValue;
    });
  }

  Buttons _getButtonfromString(String name) {
    switch (name) {
      case 'GitHub':
        return Buttons.GitHub;
      case 'Reddit':
        return Buttons.Reddit;
      case 'Xbox':
        return Buttons.Xbox;
      case 'Apple':
        return Buttons.Apple;
      case 'AppleDark':
        return Buttons.AppleDark;
      case 'Email':
        return Buttons.Email;
      case 'Facebook':
        return Buttons.Facebook;
      case 'FacebookNew':
        return Buttons.FacebookNew;
      case 'Google':
        return Buttons.Google;
      case 'GoogleDark':
        return Buttons.GoogleDark;
      case 'Hotmail':
        return Buttons.Hotmail;
      case 'LinkedIn':
        return Buttons.LinkedIn;
      case 'Microsoft':
        return Buttons.Microsoft;
      case 'Pinterest':
        return Buttons.Pinterest;
      case 'Quora':
        return Buttons.Quora;
      case 'Tumblr':
        return Buttons.Tumblr;
      case 'Twitter':
        return Buttons.Twitter;
      case 'Yahoo':
        return Buttons.Yahoo;
      default:
        return Buttons.Google;
    }
  }
}

extension ButtonsExtension on Buttons {
  String get name {
    switch (this) {
      case Buttons.GitHub:
        return 'GitHub';
      case Buttons.Reddit:
        return 'Reddit';
      case Buttons.Xbox:
        return 'Xbox';
      case Buttons.Apple:
        return 'Apple';
      case Buttons.AppleDark:
        return 'AppleDark';
      case Buttons.Email:
        return 'Email';
      case Buttons.Facebook:
        return 'Facebook';
      case Buttons.FacebookNew:
        return 'FacebookNew';
      case Buttons.Google:
        return 'Google';
      case Buttons.GoogleDark:
        return 'GoogleDark';
      case Buttons.Hotmail:
        return 'Hotmail';
      case Buttons.LinkedIn:
        return 'LinkedIn';
      case Buttons.Microsoft:
        return 'Microsoft';
      case Buttons.Pinterest:
        return 'Pinterest';
      case Buttons.Quora:
        return 'Quora';
      case Buttons.Tumblr:
        return 'Tumblr';
      case Buttons.Twitter:
        return 'Twitter';
      case Buttons.Yahoo:
        return 'Yahoo';
      default:
        return '';
    }
  }
}
