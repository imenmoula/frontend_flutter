import 'package:flutter/material.dart';
import 'ApiService.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final ApiService apiService = ApiService();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String? _message;
  bool _isLoading = false;

  // Inscription
  void register() async {
    setState(() {
      _isLoading = true;
    });

    final email = emailController.text;
    final password = passwordController.text;

    // Appeler l'API pour enregistrer l'utilisateur
    final response = await apiService.register(email, password);

    setState(() {
      _isLoading = false;
      _message = response['message'] ?? response['error'];
    });

    // Afficher un message après l'inscription
    if (response['message'] != null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(response['message']),
        backgroundColor: Colors.green,
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(response['error']),
        backgroundColor: Colors.red,
      ));
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
            // Champ de saisie pour l'email
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 16),
            // Champ de saisie pour le mot de passe
            TextField(
              controller: passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            SizedBox(height: 16),
            // Bouton d'inscription
            _isLoading
                ? CircularProgressIndicator()
                : ElevatedButton(
              onPressed: register,
              child: Text('Register'),
            ),
            SizedBox(height: 16),
            // Message d'erreur ou de succès
            if (_message != null)
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text(
                  _message!,
                  style: TextStyle(color: Colors.red),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
