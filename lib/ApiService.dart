import 'package:http/http.dart' as http;
import 'dart:convert';  // For JSON parsing

class ApiService {
  // Replace with your backend URL
  static const String baseUrl = "http://10.0.2.2:3060";

  // Register user function
  static Future<bool> registerUser(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/register'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 201) {
      // Successfully registered
      return true;
    } else {
      // Handle errors
      print("Error: ${response.body}");
      return false;
    }
  }

}
