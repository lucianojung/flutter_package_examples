import 'package:flutter/material.dart';
import 'package:package_examples/shared/appbar.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:package_examples/shared/material_dropdown_view.dart';
import 'package:package_examples/shared/setting_list.dart';

class UrlLauncher extends StatefulWidget {
  @override
  _UrlLauncherState createState() => _UrlLauncherState();
}

class _UrlLauncherState extends State<UrlLauncher> {
  String _selectedUrl = 'Website url';

  Map <String, String> _urlMap = {
    'Website url': 'https://pub.dev/packages/url_launcher',
     'Ip adress': 'http://192.168.0.1/',
     'Telefone number': 'tel:0161/12345678',
     'New Mail': 'mailto:John@doe.us',
     'New Mail with Queries': 'mailto:John@doe.us?subject=News&body=New plugin',
     'Sms': 'sms:123456789'
  };

  bool _isWebUrl = true;
  bool _forceWebView = false;
  bool _javaScriptEnabled = false;
  bool _enableDomStorage = false;
  bool _sendHeaderInfos = false;
  bool _forceSafarieVC = false;
  bool _universalLinksOnly = false;
  bool _statusBarBrigthness = false;
  bool _webOnlyWindowName = false;
  Map<String, String> _headers = <String, String>{'my_header_key': 'my_header_value'};

  String _urlLauncherVersion = 'url_launcher 6.0.17';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Url Launcher'),
      body: Center(
        child: Stack(
          children: [
            SettingList(
              height: 160,
              children: <Widget>[
                Padding(
                  padding:
                      const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
                  child: MaterialDropdownView(
                    title: 'Url Launcher',
                    subtitle: 'Select an option to display below',
                    onChangedCallback: (newValue) {
                      _onValueChanged(newValue);
                    },
                    value: _selectedUrl,
                    values: _urlMap.entries.map((e) => e.key).toList(),
                  ),
                ),
                if (_isWebUrl)
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: Divider(),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Options',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'For Android',
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                      ),
                      CheckboxListTile(
                        title: Text("Open in WebView"),
                        value: _forceWebView,
                        onChanged: (newValue) {
                          setState(() {
                            _forceWebView = newValue!;
                          });
                        },
                        controlAffinity: ListTileControlAffinity.leading,
                      ),
                      if(_forceWebView)
                        CheckboxListTile(
                          title: Text("Enable Java Script"),
                          value: _javaScriptEnabled,
                          onChanged: (newValue) {
                            setState(() {
                              _javaScriptEnabled = newValue!;
                            });
                          },
                          controlAffinity: ListTileControlAffinity.leading,
                        ),
                      if(_forceWebView)
                      CheckboxListTile(
                        title: Text("Enable DOM Storage"),
                        value: _enableDomStorage,
                        onChanged: (newValue) {
                          setState(() {
                            _enableDomStorage = newValue!;
                          });
                        },
                        controlAffinity: ListTileControlAffinity.leading,
                      ),
                      if(_forceWebView)
                        CheckboxListTile(
                          title: Text("Add Extra headers"),
                          value: _sendHeaderInfos,
                          onChanged: (newValue) {
                            setState(() {
                              _sendHeaderInfos = newValue!;
                            });
                          },
                          controlAffinity: ListTileControlAffinity.leading,
                        ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'For iOS',
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                      ),
                      CheckboxListTile(
                        title: Text("Open in Safari View Controller"),
                        value: _forceSafarieVC,
                        onChanged: (newValue) {
                          setState(() {
                            _forceSafarieVC = newValue!;
                          });
                        },
                        controlAffinity: ListTileControlAffinity.leading,
                      ),
                      CheckboxListTile(
                        title: Text("Try With Universal Links Only"),
                        value: _universalLinksOnly,
                        onChanged: (newValue) {
                          setState(() {
                            _universalLinksOnly = newValue!;
                          });
                        },
                        controlAffinity: ListTileControlAffinity.leading,
                      ),
                      CheckboxListTile(
                        title: Text("Set the status bar brightness to dark"),
                        value: _statusBarBrigthness,
                        onChanged: (newValue) {
                          setState(() {
                            _statusBarBrigthness = newValue!;
                          });
                        },
                        controlAffinity: ListTileControlAffinity.leading,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'For Web',
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                      ),
                      CheckboxListTile(
                        title: Text("Open in the current Tab"),
                        value: _webOnlyWindowName,
                        onChanged: (newValue) {
                          setState(() {
                            _webOnlyWindowName = newValue!;
                          });
                        },
                        controlAffinity: ListTileControlAffinity.leading,
                      ),
                    ],
                  ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(Icons.arrow_downward, size: 32,),
                customizedWeblinkView(),
              ],
            )
          ],
        ),
      ),
    );
  }

  void _onValueChanged(String newValue) {
    setState(() {
      _selectedUrl = newValue;
      if (newValue == 'Website url' || newValue == 'Ip adress') {
        _isWebUrl = true;
      }  else {
        _isWebUrl = false;
      }
    });
  }

  Widget customizedWeblinkView() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      alignment: Alignment.bottomCenter,
      child: SizedBox(
        width: 400,
        child: GestureDetector(
          onTap: () => _launchUrl(_urlMap[_selectedUrl]!),
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: AbsorbPointer(
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                elevation: 10,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ListTile(
                      trailing: Icon(Icons.launch),
                      title: Text(_selectedUrl == 'Website url' ? _urlLauncherVersion : _selectedUrl),
                      subtitle: RichText(
                        text: TextSpan(
                          text: _urlMap[_selectedUrl],
                          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
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

  void _launchUrl(String url) async {
    if (await canLaunch(url)) {
      if (!_isWebUrl)
        launch(url);
      else
        launch(
            url,
          forceSafariVC: _forceSafarieVC,
          forceWebView: _forceWebView,
          enableJavaScript: _javaScriptEnabled,
          enableDomStorage: _enableDomStorage,
          universalLinksOnly: _universalLinksOnly,
          webOnlyWindowName: _webOnlyWindowName ? '_self' : '_blank',
          statusBarBrightness: _statusBarBrigthness ? Brightness.dark : Brightness.light,
          headers: (_sendHeaderInfos) ? _headers : {}
        );
    } else {
      throw 'Could not launch $url';
    }
  }
}
