import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:package_examples/shared/material_dropdown_view.dart';
import 'package:package_examples/shared/setting_list.dart';

class UrlLauncher extends StatefulWidget {
  @override
  _UrlLauncherState createState() => _UrlLauncherState();
}

class _UrlLauncherState extends State<UrlLauncher> {
  String _selectedUrl = '';

  String _webUrl = 'https://pub.dev/packages/url_launcher';
  String _ipUrl = 'https://172.217.0.0';
  String _phoneUrl = 'tel:0161/12345678';
  String _mailToUrl = 'mailto:John@doe.us';
  List<String> _urlList = [];

  bool boolean = false;

  String _urlLauncherVersion = 'url_launcher 6.0.6';

  @override
  void initState() {
    _urlList.addAll([_webUrl, _ipUrl, _phoneUrl, _mailToUrl]);
    _selectedUrl = _webUrl;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Url Launcher'),
      ),
      body: Center(
        child: Stack(
          children: [
            SettingList(
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
                    value: _selectedUrl,
                    values: _urlList,
                    negate: false,
                  ),
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
                if (true)
                  CheckboxListTile(
                    title: Text("Mini button"),
                    value: boolean,
                    onChanged: (newValue) {
                      setState(() {
                        boolean = newValue!;
                      });
                    },
                    controlAffinity: ListTileControlAffinity.leading,
                  )
              ],
            ),
            customizedWeblinkView()
          ],
        ),
      ),
    );
  }

  void _onValueChanged(String newValue) {
    setState(() {
      _selectedUrl = newValue;
    });
  }

  Widget customizedWeblinkView() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      alignment: Alignment.bottomCenter,
      child: SizedBox(
        width: 400,
        child: GestureDetector(
          onTap: () => _launchUrl(_selectedUrl),
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
                      title: Text(_urlLauncherVersion),
                      subtitle: RichText(
                        text: TextSpan(
                          text: _selectedUrl,
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
