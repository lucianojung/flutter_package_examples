import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart';

class PackageWeblinkView extends StatelessWidget {
  final String _text;
  final String _url;
  final double bottom;

  PackageWeblinkView(this._text, this._url, {this.bottom = 0});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: bottom),
      padding: const EdgeInsets.all(16.0),
      alignment: Alignment.bottomCenter,
      child: SizedBox(
        width: 400,
        child: GestureDetector(
          onTap: () => _launchUrl(Uri.parse(_url)),
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: AbsorbPointer(
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                elevation: 10,
                child: ListTile(
                  trailing: Icon(Icons.launch),
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
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _launchUrl(Uri _url) async {
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }
}
