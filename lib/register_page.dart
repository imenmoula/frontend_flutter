import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  get http => null;

  Future<void> register() async {
    try {
      final response = await http.post(
        Uri.parse('http://10.0.2.2:3060/register'),  // Use your backend register URL
        body: {
          'email': _emailController.text,
          'password': _passwordController.text,
        },
      );

      // Log the full response for debugging
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      // Check if the response body contains valid JSON
      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data['message'] != null) {
          // Handle registration success (e.g., show a success message)
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(data['message'])),
          );
        } else {
          // Show error message if the response contains an error
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Registration Failed'),
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
      } else {
        // If the status code is not 200, print the error
        print('Failed to register, status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: register,
              child: Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}
