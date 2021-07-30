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
  String _ipUrl = 'http://192.168.0.1/';
  String _phoneUrl = 'tel:0161/12345678';
  String _mailToUrl = 'mailto:John@doe.us';
  List<String> _urlList = [];

  bool _isWebUrl = true;
  bool _javaScriptEnabled = false;
  bool _forceWebViewOrSafariVC = false;
  bool _enableDomStorage = false;
  bool _tryWithUniversalLinksOnly = false;
  bool _sendHeaderInfos = false;
  Map<String, String> _headers = <String, String>{'my_header_key': 'my_header_value'};

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
                    title: 'Url Launcher',
                    subtitle: 'Select an option to display below',
                    onChangedCallback: (newValue) {
                      _onValueChanged(newValue);
                    },
                    value: _selectedUrl,
                    values: _urlList,
                    negate: false,
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
                        padding: EdgeInsets.all(16.0),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Options',
                          style: Theme.of(context).textTheme.headline5,
                        ),
                      ),
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
                      //_forceWebViewOrSafariVC
                      // _enableDomStorage
                      // _tryWithUniversalLinksOnly
                      // _sendHeaderInfos
                      CheckboxListTile(
                        title: Text("Force WebView Or SafariVC"),
                        value: _forceWebViewOrSafariVC,
                        onChanged: (newValue) {
                          setState(() {
                            _forceWebViewOrSafariVC = newValue!;
                          });
                        },
                        controlAffinity: ListTileControlAffinity.leading,
                      ),
                      CheckboxListTile(
                        title: Text("Enable Dom Storage"),
                        value: _enableDomStorage,
                        onChanged: (newValue) {
                          setState(() {
                            _enableDomStorage = newValue!;
                          });
                        },
                        controlAffinity: ListTileControlAffinity.leading,
                      ),
                      CheckboxListTile(
                        title: Text("Try With Universal Links Only"),
                        value: _tryWithUniversalLinksOnly,
                        onChanged: (newValue) {
                          setState(() {
                            _tryWithUniversalLinksOnly = newValue!;
                          });
                        },
                        controlAffinity: ListTileControlAffinity.leading,
                      ),
                      CheckboxListTile(
                        title: Text("Send with Header Infos"),
                        value: _sendHeaderInfos,
                        onChanged: (newValue) {
                          setState(() {
                            _sendHeaderInfos = newValue!;
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
      if (newValue == _webUrl || newValue == _ipUrl) {
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
      if (!_isWebUrl)
        launch(url);
      else
        launch(
            url,
          forceSafariVC: _forceWebViewOrSafariVC,
          forceWebView: _forceWebViewOrSafariVC,
          enableJavaScript: _javaScriptEnabled,
          enableDomStorage: _enableDomStorage,
          universalLinksOnly: _tryWithUniversalLinksOnly,
          headers: (_sendHeaderInfos) ? _headers : {}
        );
    } else {
      throw 'Could not launch $url';
    }
  }
}
