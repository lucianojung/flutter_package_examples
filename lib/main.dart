import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:package_examples/service/MyTheme.dart';
import 'package:package_examples/service/route_generator.dart';
import 'package:package_examples/shared/appbar.dart';
import 'package:package_examples/shared/material_dropdown_view.dart';
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
          debugShowCheckedModeBanner: false,
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
  String orderValue = SortingOrder.Newest.name;

  List<CustomListTile> listTileList = <CustomListTile>[
    CustomListTile(
        Icons.email_outlined, 'Email Validator', '2.0.1', '/email_validator', 0),
    CustomListTile(Icons.facebook, 'Flutter Signin Button', '2.0.0',
        '/flutter_signin_button', 1),
    CustomListTile(Icons.view_agenda_outlined, 'Convex BottomAppBar', '3.0.0',
        '/convex_bottom_bar', 2),
    CustomListTile(
        Icons.calendar_today, 'Date Format', '2.0.4', '/date_format', 3),
    CustomListTile(Icons.launch, 'Url Launcher', '6.0.17', '/url_launcher', 4),
    CustomListTile(
        Icons.font_download_outlined, 'Google Fonts', '2.2.0', '/google_fonts', 5),
    CustomListTile(Icons.lock_outline, 'Crypto', '3.0.1', '/crypto', 6),
  ];

  @override
  void initState() {
    _onOrderValueChanged(SortingOrder.Newest.name);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Package Examples'),
      body: _body(),
    );
  }

  Widget _body() {
    return SafeArea(
      child: Container(
        // width: 1280,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 8.0),
                child: MaterialDropdownView(
                  value: orderValue,
                  values: SortingOrder.Alphabetically.names(),
                  onChangedCallback: (newValue) => _onOrderValueChanged(newValue),
                ),
              ),
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
                subtitle: Text('...'),
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

  void _onOrderValueChanged(String newValue) {
    if(newValue == SortingOrder.Newest.name) {
      listTileList.sort((a, b) => b.order.compareTo(a.order));
    } else if (newValue == SortingOrder.Oldest.name) {
      listTileList.sort((a, b) => a.order.compareTo(b.order));
    } else if (newValue == SortingOrder.Alphabetically.name) {
      listTileList.sort((a, b) => a.title.compareTo(b.title));
    } else if (newValue == SortingOrder.HighestVersion.name) {
      listTileList.sort((a, b) => b.version.compareTo(a.version));
    }
    setState(() {
      orderValue = newValue;
    });
  }
}

class CustomListTile {
  IconData iconData;
  String title;
  String version;
  String route;
  int order;

  CustomListTile(this.iconData, this.title, this.version, this.route, this.order);
}

enum SortingOrder { Alphabetically, Newest, Oldest, HighestVersion }

extension SortingOrderExtension on SortingOrder {
  String get name {
    switch (this) {
      case SortingOrder.Alphabetically:
        return 'Alphabetically';
      case SortingOrder.Newest:
        return 'Newest package first';
      case SortingOrder.Oldest:
        return 'Oldest package first';
      case SortingOrder.HighestVersion:
        return 'Highest version first';
    }
  }

  List<String> names() {
    List<String> values = [];
    SortingOrder.values.forEach((element) {
      values.add(element.name);
    });
    return values;
  }
}