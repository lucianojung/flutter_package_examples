import 'package:flutter/material.dart';
import 'package:package_examples/service/route_generator.dart';
import 'package:url_launcher/url_launcher.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: themeData(),
      onGenerateRoute: RouteGenerator.generateRoute,
      initialRoute: '/',
    );
  }

  ThemeData themeData() {
    return ThemeData(
      primaryColor: Color(0xff67bcb3),
      accentColor: Color(0xff92ded6),
      textTheme: TextTheme(
        subtitle1: TextStyle(color: Colors.black87),
      ),
    );
  }
}

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<CustomListTile> listTileList = [
    CustomListTile(
        Icons.email_outlined, 'Email Validator', '2.0.1', '/email_validator'),
    CustomListTile(Icons.facebook, 'Flutter Signin Button', '2.0.0',
        '/flutter_signin_button'),
    CustomListTile(
        Icons.menu, 'Convex BottomAppBar', '3.0.0', '/convex_bottom_bar'),
    CustomListTile(
        Icons.calendar_today, 'Date Format', '2.0.2', '/date_format'),
    // CustomListTile(Icons.launch, 'Url Launcher', '6.0.9', '/url_launcher'),
    // CustomListTile(Icons.font_download_outlined, 'Google Fonts', '2.1.0', '/google_font'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _appBar(),
      body: _body(),
    );
  }

  _appBar() {
    return AppBar(
      backgroundColor: Theme.of(context).primaryColor,
      shadowColor: Theme.of(context).primaryColor,
      title: Text(
        'Package Examples',
      ),
    );
  }

  Widget _body() {
    return Column(
      children: <Widget>[
        for (CustomListTile listTile in listTileList)
          ListTile(
            leading: Icon(listTile.iconData),
            title: Text(listTile.title),
            subtitle: Text('Version: ${listTile.version}'),
            onTap: () {
              setState(() {
                Navigator.of(context).pushNamed(listTile.route);
              });
            },
            trailing: Icon(Icons.arrow_forward),
          ),
        Divider(),
        ListTile(
          leading: Icon(Icons.assistant),
          title: Text('Upcoming'),
          subtitle: Text('Url Launcher, Google Fonts, ...'),
          onTap: () {
            setState(() {
              _launchUrl('https://lucianojung.medium.com/');
            });
          },
        ),
      ],
    );
  }


  Future<void> _launchUrl(String url) async {
    if (await canLaunch(url)) {
        launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

class CustomListTile {
  IconData iconData;
  String title;
  String version;
  String route;

  CustomListTile(this.iconData, this.title, this.version, this.route);
}
