import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:timetable_app/register_page.dart';
import 'dart:convert';
import 'HomePage.dart';
import 'dart:convert';
 // Import the RegisterPage

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> login() async {
    try {

      final url = Uri.parse('http://10.0.2.2:3060/login');  // Replace with your API URL

      // Define the data to send in the body
      final body = json.encode({
        'email': _usernameController.text,  // Changed 'username' to 'email' to match backend
        'password': _passwordController.text,
      });


      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',  // Make sure to set the correct headers
        },
        body: body,
      );


      // Log the entire response body in the console for debugging
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      final data = json.decode(response.body);

      // Check if the login was successful
      if (data['error'] == null) {
        // On success, navigate to the HomePage
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      } else {
        // Show error message if the response contains an error
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Login Failed'),
            content: Text(data['error'] ?? 'Unknown error'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      // If there's an error during the request, log the error
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: login,
              child: Text('Login'),
            ),
            SizedBox(height: 20),
            // Add a link to the registration page
            TextButton(
              onPressed: () {
                // Navigate to the RegisterPage
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegisterPage()),
                );
              },
              child: Text('Don\'t have an account? Register here'),
            ),
          ],
        ),
      ),
    );
  }
}
