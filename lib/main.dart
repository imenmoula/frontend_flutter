import 'package:flutter/material.dart';
import 'package:timetable_app/login_page.dart';
import 'package:timetable_app/register_page.dart';
import 'HomePage.dart';
import 'AddRoomPage.dart';
import 'RoomListPage.dart'; // Import your AddRoomPage here

// Assurez-vous que ce fichier existe

void main() => runApp(MyApp());

final routes = {
  '/login': (BuildContext context) => LoginPage(),
  '/home': (BuildContext context) => HomePage(),
  '/register': (BuildContext context) => RegisterPage(),
  '/rooms': (context) => RoomListPage(), // New route
  '/': (BuildContext context) => LoginPage(),
};
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Timetable App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: TextTheme(
          titleLarge: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: Colors.blue[800],
          ),
          bodyMedium: TextStyle(
            fontSize: 18,
            color: Colors.black87,
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue),
          ),
          labelStyle: TextStyle(color: Colors.blue[600]),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 25),
            textStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        appBarTheme: AppBarTheme(
          color: Colors.blue[600],
          elevation: 0,
          titleTextStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: Colors.white,
          ),
        ),
      ),
      routes: routes,
    );
  }
}
