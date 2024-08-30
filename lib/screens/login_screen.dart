import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:get/get.dart';
import 'package:hayvan_sahiplenme_app2/constans.dart';
import 'package:hayvan_sahiplenme_app2/screens/forgot_password_screen.dart';
import 'package:hayvan_sahiplenme_app2/screens/register_screen.dart';
import 'package:hayvan_sahiplenme_app2/theme.dart';
import 'package:hayvan_sahiplenme_app2/validators.dart';
import '../controllers/auth_controller.dart';
import '../widgets/navigation_menu.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthController authController = Get.find<AuthController>();
    final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  Widget build(BuildContext context) {
    return SafeArea(

      child: Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Container(
              height: MediaQuery.sizeOf(context).height,
              padding: mediumPadding16,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/pati_background.png'),
                    fit: BoxFit.cover),
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    FadeInUp(
                        duration: Duration(milliseconds: 1600),
                        child: Text(
                          textAlign: TextAlign.center,
                          "ATAKUM BELEDİYESİ SOKAK HAYVANLARI SAHİPLENDİRME SİSTEMİ",
                          style: TextStyle(
                
                              color: AppColors1.cardColor,
                              fontSize: 28,
                              fontWeight: FontWeight.bold),
                        )),
                    SpecialSizedBox(),
                    FadeIn(
                        duration: Duration(milliseconds: 1200),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(MediaQuery.sizeOf(context).width/4),
                            child: Image.asset(
                              "assets/images/atakumbel.png",
                              height: MediaQuery.sizeOf(context).width/2,
                            ))),
                    SpecialSizedBox(),
                    
                    FadeInUp(
                        duration: Duration(milliseconds: 1800),
                        child: Column(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.all(8.0),
                              child: TextFormField(
                                validator: Validators.loginrValidateEmail,
                                controller: emailController,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "E-Mail",
                                    hintStyle:
                                        TextStyle(color: Colors.grey[700])),
                              ),
                            ),
                            SizedBox(height: 0,),
                            Container(
                              padding: EdgeInsets.all(8.0),
                              child: TextFormField(
                                validator: Validators.loginValidatePassword,
                                controller: passwordController,
                                obscureText: true,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Şifre",
                                    hintStyle:
                                        TextStyle(color: Colors.grey[700])),
                              ),
                            )
                          ],
                        )),
                    SpecialSizedBox(),
                    FadeInUp(
                      duration: Duration(milliseconds: 1900),
                      child: GestureDetector(
                        onTap: () {
                          if (_formKey.currentState!.validate()) {authController.login(
                              emailController.text, passwordController.text);}
                          
                        },
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              gradient: LinearGradient(colors: [
                                AppColors1.primaryColor,
                                AppColors1.accentColor,
                              ])),
                          child: Center(
                              child: Text(
                            "Giriş Yap",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          )),
                        ),
                      ),
                    ),
                    SpecialSizedBox(),
                    FadeInUp(
                      duration: Duration(milliseconds: 1900),
                      child: GestureDetector(
                        onTap: () {
                          Get.to(() => RegisterScreen());
                        },
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              gradient: LinearGradient(colors: [
                                AppColors1.primaryColor,
                                AppColors1.accentColor,
                              ])),
                          child: Center(
                              child: Text(
                            "Kayıt Ol",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          )),
                        ),
                      ),
                    ),
                   SpecialSizedBox(),
                    FadeInUp(
                        duration: Duration(milliseconds: 2000),
                        child: GestureDetector(
                          onTap: () {
                            Get.to(()=>ForgotPassword());
                          },
                          child: Text(
                            "Şifremi Unuttum?",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppColors1.cardColor),
                          ),
                        ),
                        ),
                    SpecialSizedBox(),
                    FadeInUp(
                        duration: Duration(milliseconds: 2000),
                        child: GestureDetector(
                          onTap: () {
                            // Misafir olarak devam et
                            Get.offAll(() => NavigationMenu());
                          },
                          child: Text(
                            "Üye Olmadan Devam Et",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppColors1.cardColor),
                          ),
                        )),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}

class SpecialSizedBox extends StatelessWidget {
  const SpecialSizedBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).width/30,
    );
  }
}





















/*
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
*/