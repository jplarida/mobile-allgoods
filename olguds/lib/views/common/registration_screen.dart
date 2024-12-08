import 'package:flutter/material.dart';
import 'package:multi_tenant_app/services/db_service.dart';
import 'main_screen.dart';

class RegistrationScreen extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _pinController = TextEditingController();

  Future<void> _registerUser(BuildContext context) async {
    final username = _usernameController.text;
    final pin = _pinController.text;

    if (username.isEmpty || pin.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill in all fields.')),
      );
      return;
    }

    await DbService().addUser(username, pin, 'client');
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => MainScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Register')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: _pinController,
              decoration: InputDecoration(labelText: 'PIN'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _registerUser(context),
              child: Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}
