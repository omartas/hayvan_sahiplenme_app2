// lib/pages/login_page.dart

import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../utils/token_manager.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _message = '';

  Future<void> _login() async {
  final apiService = ApiService();
  try {
    final response = await apiService.login(
      _emailController.text,
      _passwordController.text,
    );

    if (response != null && response.containsKey('data')) {
      final data = response['data'];

      if (data.containsKey('token')) {
        final String accessToken = data['token']['accessToken'];
        await TokenManager.saveToken(accessToken);

        setState(() {
          _message = 'Login successful!';
        });
      } else {
        setState(() {
          _message = 'Failed to login: No access token found in response';
        });
        print('Token data: $data');
      }
    } else {
      setState(() {
        _message = 'Failed to login: No data found in response';
      });
      print('Response data: $response');
    }
  } catch (e) {
    setState(() {
      _message = 'Failed to login: ${e.toString()}';
    });
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
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
              keyboardType: TextInputType.emailAddress,
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _login,
              child: Text('Login'),
            ),
            SizedBox(height: 20),
            Text(_message),
          
          ],
        ),
      ),
    );
  }
}
