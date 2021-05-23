import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart';

class PackageWeblinkView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: RichText(
        text: TextSpan(
          text: 'https://www.iwiga.de/impressum',
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
            color: Colors.blue,
            decoration: TextDecoration.underline,
          ),
          recognizer: new TapGestureRecognizer()
            ..onTap = () {
              _launchUrl('https://www.iwiga.de/impressum');
            },
        ),
      )
    );
  }

  Future<void> _launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
