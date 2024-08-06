import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/auth_controller.dart';
import '../controllers/user_controller.dart';
import 'login_screen.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final UserController userController = Get.put(UserController());
    final AuthController authController = Get.find<AuthController>();

    return Scaffold(
      appBar: AppBar(title: Text('Profile')),
      body: Obx(() {
        if (userController.user.value.uid.isEmpty) {
          return Column(children: [
            Center(child: ElevatedButton(onPressed: ()=>Get.offAll(()=>LoginScreen()), child: Text("Giris yap"))),
           ]);
        }
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Name: ${userController.user.value.name}', style: TextStyle(fontSize: 18)),
              SizedBox(height: 8),
              Text('Email: ${userController.user.value.email}', style: TextStyle(fontSize: 18)),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  // Kullanıcı çıkışı
                  authController.logout();
                  Get.offAll(() => LoginScreen()); // Kullanıcıyı giriş ekranına yönlendir
                },
                child: Text('Logout'),
              ),
            ],
          ),
        );
      }),
    );
  }
}
