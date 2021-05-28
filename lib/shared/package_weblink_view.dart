import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart';

class PackageWeblinkView extends StatelessWidget {
  String _text;
  String _url;

  PackageWeblinkView(this._text, this._url);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: 400,
        padding: const EdgeInsets.all(16.0),
        child: GestureDetector(
          onTap: () => _launchUrl(_url),
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: AbsorbPointer(
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                color: Colors.white,
                elevation: 10,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ListTile(
                      leading: Icon(Icons.link),
                      title: Text(_text),
                      subtitle: RichText(
                        text: TextSpan(
                          text: _url,
                          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                color: Colors.blue,
                                decoration: TextDecoration.underline,
                              ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
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
