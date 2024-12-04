import 'package:flutter/material.dart';
import 'package:timetable_app/HomePage.dart';
import 'package:timetable_app/login_page.dart';
import 'package:timetable_app/register_page.dart';

void main() => runApp(new MyApp());

final routes = {
  '/login': (BuildContext context) => new LoginPage(),
  '/home': (BuildContext context) => new HomePage(),
  '/register': (BuildContext context) => new RegisterPage(),
  '/': (BuildContext context) => new LoginPage(),
};

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Login Register App',
      theme: new ThemeData(primarySwatch: Colors.teal),
      routes: routes,
    );
  }
}