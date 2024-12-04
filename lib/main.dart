import 'package:flutter/material.dart';
import 'package:timetable_app/HomePage.dart';
import 'package:timetable_app/login_page.dart';
import 'package:timetable_app/register_page.dart';

void main() => runApp(MyApp());

final routes = {
  '/login': (BuildContext context) => LoginPage(),
  '/home': (BuildContext context) => HomePage(),
  '/register': (BuildContext context) => RegisterPage(),
  '/': (BuildContext context) => LoginPage(),
};

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login Register App',
      theme: ThemeData(
        // Modification de la couleur principale en bleu
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: TextTheme(
          titleLarge: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: Colors.blue[800], // Couleur des titres en bleu
          ),
          bodyMedium: TextStyle(
            fontSize: 18,
            color: Colors.black87, // Couleur du texte principal
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue), // Couleur bleu pour le focus
          ),
          labelStyle: TextStyle(color: Colors.blue[600]), // Couleur du label en bleu
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue, // Couleur des boutons en bleu
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
          color: Colors.blue[600], // Couleur du AppBar en bleu
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
