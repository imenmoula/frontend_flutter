import 'package:flutter/material.dart';
import 'login_page.dart';  // Importer la page de login

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // Définir la page initiale de l'application comme étant la page de login
      home: LoginPage(),
    );
  }
}
