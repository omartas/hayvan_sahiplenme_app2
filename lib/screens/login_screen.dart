import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hayvan_sahiplenme_app2/widgets/navigation_menu.dart';
import '../../controllers/auth_controller.dart';
import 'register_screen.dart';

class LoginScreen extends StatelessWidget {
  final AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                authController.login(emailController.text, passwordController.text);
              },
              child: Text('Login'),
            ),
            TextButton(
              onPressed: () {
                Get.to(() => RegisterScreen());
              },
              child: Text('Register'),
            ),
            TextButton(
              onPressed: () {
                // Misafir olarak devam et
                Get.offAll(() => NavigationMenu());
              },
              child: Text('Continue as Guest'),
            ),
          ],
        ),
      ),
    );
  }
}
