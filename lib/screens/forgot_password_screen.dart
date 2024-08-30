import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hayvan_sahiplenme_app2/screens/login_screen.dart';
import 'package:hayvan_sahiplenme_app2/validators.dart';

import '../constans.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  // Form Key
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // TextForm Controller
  TextEditingController emailController = TextEditingController();

  // Form Validation
  bool _validateAndSave() {
    final form = _formKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  void _validateAndSubmit() {
    if (_validateAndSave()) {
      Get.dialog(AlertDialog(
        icon: Icon(Icons.check_circle, color: Colors.green, size: 50),
        title: Text("Başarılı"),
        content: Text(
            "Girdiğniz E-maile bir şifre yenileme linki gönderdik."),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('Şifre Yenile'),
          centerTitle: true,
        ),
        body: Container(
          padding: mediumPadding16,
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                  validator: Validators.forgotPasswordValidateEmail,
                  onSaved: (value) => emailController.text = value!,
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: _validateAndSubmit,
                  child: const Text('Gönder'),
                ),
                const SizedBox(height: 16.0),
                Center(
                  child: GestureDetector(
                    onTap: _navigateToSignIn,
                    child: RichText(
                      text: const TextSpan(
                        text: 'Hesabın var mı? ',
                        style: TextStyle(color: Colors.black),
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Giriş Yap',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Goto SignUp Page
  void _navigateToSignIn() {
    Get.to(() => LoginScreen());
  }
}
