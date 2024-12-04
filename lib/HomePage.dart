import 'package:flutter/material.dart';
import 'register_page.dart'; // Importer la page d'inscription

class  HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: Center(
        child: Text('Welcome to the Home Page!'),
      ),
    );
  }

}