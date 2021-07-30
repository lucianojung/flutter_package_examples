import 'package:flutter/material.dart';
import 'package:package_examples/service/route_generator.dart';

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
        ListTile(
          leading: Icon(Icons.email),
          title: Text('Email Validator'),
          subtitle: Text('Version: 2.0.1'),
          onTap: () {
            setState(() {
              Navigator.of(context).pushNamed('/email_validator');
            });
          },
          trailing: Icon(Icons.arrow_forward),
        ),
        ListTile(
          leading: Icon(Icons.facebook),
          title: Text('Flutter Signin Button'),
          subtitle: Text('Version: 2.0.0'),
          onTap: () {
            setState(() {
              Navigator.of(context).pushNamed('/flutter_signin_button');
            });
          },
          trailing: Icon(Icons.arrow_forward),
        ),
        ListTile(
          leading: Icon(Icons.menu),
          title: Text('Convex BottomAppBar'),
          subtitle: Text('Version: 3.0.0'),
          onTap: () {
            setState(() {
              Navigator.of(context).pushNamed('/convex_bottom_bar');
            });
          },
          trailing: Icon(Icons.arrow_forward),
        ),
        ListTile(
          leading: Icon(Icons.calendar_today),
          title: Text('Date Format'),
          subtitle: Text('Version: 2.0.2'),
          onTap: () {
            setState(() {
              Navigator.of(context).pushNamed('/date_format');
            });
          },
          trailing: Icon(Icons.arrow_forward),
        ),
        ListTile(
          leading: Icon(Icons.launch),
          title: Text('Url Launcher'),
          subtitle: Text('Version: 6.0.9'),
          onTap: () {
            setState(() {
              Navigator.of(context).pushNamed('/url_launcher');
            });
          },
          trailing: Icon(Icons.arrow_forward),
        ),
      ],
    );
  }

}


