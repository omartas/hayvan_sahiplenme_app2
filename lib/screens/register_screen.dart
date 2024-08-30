import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hayvan_sahiplenme_app2/constans.dart';
import 'package:hayvan_sahiplenme_app2/theme.dart';
import 'package:hayvan_sahiplenme_app2/validators.dart';
import '../../controllers/auth_controller.dart';
import '../data/cities.dart';

class RegisterScreen extends StatefulWidget {
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final AuthController authController = Get.find<AuthController>();
  String? _selectedCity;
  String? _selectedDistrict;
  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();
    TextEditingController _confirmpasswordController = TextEditingController();
    TextEditingController nameController = TextEditingController();
    TextEditingController phoneController = TextEditingController();
    final _formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(title: Text('Kayıt Ekranı')),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.sizeOf(context).height,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/pati_background.png'),
                  fit: BoxFit.cover)),
          child: Padding(
            padding: mediumPadding16,
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  FadeInUp(
                      duration: Duration(milliseconds: 1200),
                      child: Container(
                        height: 125,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image:
                                    AssetImage('assets/images/petadopt.png'))),
                      )),
                  TextFormField(
                      controller: nameController,
                      decoration: InputDecoration(
                        labelText: 'İsim',
                        prefixIcon: Icon(Icons.abc_rounded),
                      ),
                      validator: Validators.validateName),
                  SizedBox12(),
                  TextFormField(
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly, // Sadece sayılar
                      LengthLimitingTextInputFormatter(10),
                    ],
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.phone),
                      labelText: 'Telefon',
                    ),
                    validator: Validators.registerValidatePhone,
                  ),
                  SizedBox12(),
                  TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      prefixIcon: Icon(Icons.email_outlined),
                    ),
                    validator: Validators.registerValidateEmail,
                  ),
                  SizedBox12(),
                  TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                        labelText: 'Şifre', prefixIcon: Icon(Icons.password)),
                    obscureText: true,
                    validator: Validators.registerValidatePassword,
                  ),
                  SizedBox12(),
                  TextFormField(
                      controller: _confirmpasswordController,
                      decoration: InputDecoration(
                          labelText: 'Şifre (tekrar)',
                          prefixIcon: Icon(Icons.password)),
                      obscureText: true,
                      validator: (value) =>
                          Validators.registerValidateConfirmPassword(
                              value, _confirmpasswordController.text)),
                  SizedBox12(),
                  DropdownButtonFormField<String>(
                    validator: Validators.registerValidateCity,
                    hint: Text("İl Seçin"),
                    value: _selectedCity,
                    icon: Icon(Icons.location_pin),
                    isExpanded: true,
                    items: citiesAndDistricts.keys.map((String city) {
                      return DropdownMenuItem<String>(
                        value: city,
                        child: Text(city),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedCity = newValue;
                        _selectedDistrict = null;
                      });
                    },
                  ),
                  SizedBox12(),
                  if (_selectedCity != null)
                    DropdownButtonFormField<String>(
                      validator: Validators.registerValidateDistict,
                      hint: Text("İlçe Seçin"),
                      icon: Icon(Icons.location_pin),
                      value: _selectedDistrict,
                      isExpanded: true,
                      items: citiesAndDistricts[_selectedCity!]!
                          .map((String district) {
                        return DropdownMenuItem<String>(
                          value: district,
                          child: Text(district),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedDistrict = newValue;
                        });
                      },
                    ),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Şifreler geçerli, işlemleri burada gerçekleştirebilirsiniz
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Şifreler geçerli!')),
                        );
                        authController.register(emailController.text,
                            _passwordController.text, nameController.text);
                      }
                    },
                    child: Text('Kaydol'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SizedBox12 extends StatelessWidget {
  const SizedBox12({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 12,
    );
  }
}
