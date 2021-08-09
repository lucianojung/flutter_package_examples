import 'package:flutter/material.dart';
import 'package:package_examples/service/MyTheme.dart';
import 'package:package_examples/service/route_generator.dart';
import 'package:package_examples/shared/appbar.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      builder: (context, _) {
        final themeProvider = Provider.of<ThemeProvider>(context);

        return MaterialApp(
          themeMode: themeProvider.themeMode,
          theme: MyTheme.lightTheme,
          darkTheme: MyTheme.darkTheme,
          onGenerateRoute: RouteGenerator.generateRoute,
          initialRoute: '/',
        );
      });
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
        Icons.view_agenda_outlined, 'Convex BottomAppBar', '3.0.0', '/convex_bottom_bar'),
    CustomListTile(
        Icons.calendar_today, 'Date Format', '2.0.2', '/date_format'),
    CustomListTile(Icons.launch, 'Url Launcher', '6.0.9', '/url_launcher'),
    // CustomListTile(Icons.font_download_outlined, 'Google Fonts', '2.1.0', '/google_fonts'),
    // CustomListTile(Icons.lock_outline, 'Crypto', '3.0.1', '/crypto'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Package Examples'),
      body: _body(),
    );
  }

  Widget _body() {
    return SafeArea(
      child: Center(
        child: Container(
          // width: 1280,
          child: Column(
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Divider(),
              ),
              ListTile(
                leading: Icon(Icons.assistant),
                trailing: Icon(Icons.launch),
                title: Text('Upcoming'),
                subtitle: Text('Url Launcher, Google Fonts, ...'),
                onTap: () {
                  setState(() {
                    _launchUrl('https://lucianojung.medium.com/');
                  });
                },
              ),
            ],
          ),
        ),
      ),
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
