import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hayvan_sahiplenme_app2/constans.dart';
import 'package:hayvan_sahiplenme_app2/widgets/navigation_menu.dart';

import '../../controllers/animal_controller.dart';
import '../../models/animal_model.dart';

class AdoptionFormPage extends StatefulWidget {
  final AnimalModel animal;

  const AdoptionFormPage({super.key, required this.animal});

  @override
  _AdoptionFormPageState createState() => _AdoptionFormPageState();
}

class _AdoptionFormPageState extends State<AdoptionFormPage> {
  final TextEditingController _cvvController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _expiryDateController = TextEditingController();
  final TextEditingController _cardHolderNameController =
      TextEditingController();
  var _selectedAmount;

  DateTime? selectedDate;
  bool removeAdFromListing = false;
  bool showPaymentSection = false;
  int mamaUcreti = 100;

  @override
  Widget build(BuildContext context) {
    var _appBarTitle = "Hayvan Sahiplenme Formu";
    var _adoptPriceInfo =
        "Hayvan dostumuzu Sahiplenmek için minimum 100 TL mama ücreti ödemeniz gerekmektedir. Bu bedel diğer hayvan dostlarımızın beslenmesi için kullanılacaktır.";
    var _cardHolderLabelText = "Kart Sahibinin Adı Soyadı";
    var _cardNumberLabelText = "Kart Numarası";
    var _cardDateLabelText = "Son Kullanma Tarihi (AA/YY)";
    var _cvvLabelText = "CVV";
    return Scaffold(
      resizeToAvoidBottomInset: false,// klavye açıldığında bottom overflow hatasını önler.
      appBar: AppBar(
        title: Text(_appBarTitle),
      ),
      body: Padding(
        padding: normalPadding32,
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              Text(_adoptPriceInfo),
              SizedBox(height: 16.0),
              DropdownButtonFormField(
                validator: (value) {
                  if (value == null || value.toString().isEmpty) {
                    return 'Lütfen bir mama bağış tutarı seçiniz.';
                  }
                  return null;
                },
                dropdownColor: Colors.white,
                hint: Text("Bağış Miktarını Seçiniz"),
                value: _selectedAmount,
                items: donationAmounts,
                onChanged: (value) {
                  setState(() {
                    _selectedAmount = value;
                  });
                },
                isExpanded: true,
              ),
              SizedBox(height: 16.0),
              Text(
                "Ödeme Bilgilerini Giriniz",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBoxSize8(),
              // Kart Sahibinin Adı
              TextFormField(
                controller: _cardHolderNameController,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  labelText: _cardHolderLabelText,
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Lütfen kart sahibinin adını girin';
                  }
                  return null;
                },
              ),
              SizedBoxSize8(),

              TextFormField(
                controller: _cardNumberController,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(16), // Maksimum 16 rakam
                ],
                decoration: InputDecoration(
                  labelText: _cardNumberLabelText,
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Lütfen kart numarasını girin';
                  }
                  if (!validateCardNumber(value)) {
                    return 'Geçersiz kart numarası';
                  }
                  return null;
                },
              ),
              SizedBoxSize8(),

              TextFormField(
                controller: _expiryDateController,
                keyboardType: TextInputType.datetime,
                decoration: InputDecoration(
                  labelText: _cardDateLabelText,
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Lütfen son kullanma tarihini girin';
                  }
                  if (!validateExpiryDate(value)) {
                    return 'Geçersiz son kullanma tarihi';
                  }
                  return null;
                },
              ),
              SizedBoxSize8(),

              // CVV
              TextFormField(
                controller: _cvvController,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(4), // Maksimum 4 rakam
                ],
                decoration: InputDecoration(
                  labelText: _cvvLabelText,
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Lütfen CVV numarasını girin';
                  }
                  if (value.length < 3 || value.length > 4) {
                    return 'Geçersiz CVV numarası';
                  }
                  return null;
                },
              ),
              Spacer(),
              ElevatedButton(
                onPressed: () {
                  _submitForm();
                },
                child: Text("Onayla ve Sahiplen"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool _luhnCheck(String cardNumber) {
    int sum = 0;
    bool alternate = false;
    for (int i = cardNumber.length - 1; i >= 0; i--) {
      int n = int.parse(cardNumber[i]);
      if (alternate) {
        n *= 2;
        if (n > 9) n -= 9;
      }
      sum += n;
      alternate = !alternate;
    }
    return (sum % 10 == 0);
  }

  bool validateCardNumber(String input) {
    if (input.length != 16) return false;
    return _luhnCheck(input); // Luhn algoritması ile kart numarasını doğrula
  }

  bool validateExpiryDate(String input) {
    if (input.length != 5) return false;
    if (input[2] != '/') return false;

    final currentYear = DateTime.now().year % 100;
    final currentMonth = DateTime.now().month;

    final expiryMonth = int.tryParse(input.substring(0, 2));
    final expiryYear = int.tryParse(input.substring(3));

    if (expiryMonth == null || expiryYear == null) return false;

    if (expiryMonth < 1 || expiryMonth > 12) return false;

    if (expiryYear < currentYear ||
        (expiryYear == currentYear && expiryMonth < currentMonth)) {
      return false;
    }

    return true;
  }

  void _submitForm() {
      if (_formKey.currentState!.validate()) {
        // Buraya sahiplenme işlemini ekleyebiliriz
        AnimalController().adoptAnimal(widget.animal.id);
        _showCustomDialog(context, "555 333 55 55");
        // Formu işleme ve sunucuya gönderme işlemleri
        if (removeAdFromListing && showPaymentSection) {
          // Ödeme bilgilerini doğrula ve işle
          _processPayment();
        }
      }
    
  }

  void _processPayment() {
    // Ödeme işleme mantığı burada olacak
  }
}

void _showCustomDialog(BuildContext context, String phoneNumber) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.check_circle, color: Colors.green, size: 60),
              SizedBox(height: 16),
              Text(
                "Ödeme Başarılı",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Text(
                "Ekiplerimiz sahiplenme işlemleri için en kısa sürede girmiş olduğunuz $phoneNumber cep telefonu üzerinden sizinle iletişime geçecektir.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  //Get.back(); // Dialog'u kapat
                  Get.offAll(NavigationMenu());
                },
                child: Text("Tamam"),
              ),
            ],
          ),
        ),
      );
    },
  );
}

class SizedBoxSize8 extends StatelessWidget {
  const SizedBoxSize8({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: 8.0);
  }
}

List<DropdownMenuItem> donationAmounts = [
  DropdownMenuItem(child: Text("100 TL"), value: 100),
  DropdownMenuItem(child: Text("200 TL"), value: 200),
  DropdownMenuItem(child: Text("400 TL"), value: 400),
  DropdownMenuItem(child: Text("800 TL"), value: 800),
  DropdownMenuItem(child: Text("1200 TL"), value: 1200),
  DropdownMenuItem(child: Text("1600 TL"), value: 1600),
  DropdownMenuItem(child: Text("2000 TL"), value: 2000),
];
