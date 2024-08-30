import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hayvan_sahiplenme_app2/validators.dart';
import '../constans.dart';
import '../theme.dart';

class DonateScreen extends StatefulWidget {
  final String shelterName;

  DonateScreen({required this.shelterName});

  @override
  _DonateScreenState createState() => _DonateScreenState();
}

class _DonateScreenState extends State<DonateScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _expiryDateController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();
  final TextEditingController _cardHolderNameController = TextEditingController();

  bool donateAmount = false;
  var _selectedAmount;
  bool showSpecialAmount = false;

  //final _amountController = TextEditingController();
  final _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.shelterName} Bağış Ekranı'),
      ),
      body: Padding(
        padding: normalPadding32,
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              Text(
                'Hayvan barınaklarındaki patili dostlarımıza seçtiğiniz tutar ile mama bağışı yapabilirsiniz.',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text("Başka bir ücret belirle"),
                  Checkbox(
                      value: showSpecialAmount,
                      onChanged: (value) {
                        setState(() {
                          if (value != null) {
                            donateAmount = true;
                          }
                          showSpecialAmount = !showSpecialAmount;
                        });
                      }),
                ],
              ),
              SizedBox(height: 16),
              if (!showSpecialAmount)
                Expanded(
                  child: DropdownButtonFormField(
                    validator:(value) {
                  if (value == null || value.isEmpty) {
                    return 'Lütfen bir mama bağış tutarı seçiniz.';
                  }
                  return null;
                } ,
                    dropdownColor: Colors.white,
                    hint: Text("Bağış Miktarını Seçiniz"),
                    value: _selectedAmount,
                    items: donationAmounts,
                    onChanged: (value) {
                      setState(() {
                        _selectedAmount = value;
                        if (_selectedAmount != null) {
                          donateAmount = true;
                        }
                      });
                    },
                    isExpanded: true,
                  ),
                ),
              if (showSpecialAmount)
                TextFormField(
                  controller: _amountController,
                  decoration: InputDecoration(
                    labelText: 'Mama tutarı giriniz',
                    suffixText: 'TL',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Lütfen bir miktar giriniz';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Lütfen bir miktar giriniz';
                    }
                    return null;
                  },
                ),
              SizedBoxSize8(),

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
                  labelText: "Kart Sahibinin Adı Soyadı",
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
                  labelText: "Kart Numarası",
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
                  labelText: "Son Kullanma Tarihi (AA/YY)",
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
                  labelText: "CVV",
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
              SizedBoxSize8(),

              TextFormField(
                controller: _messageController,
                decoration: InputDecoration(
                  labelText: 'Bir Mesaj Bırak',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              SizedBox(height: 20),
              BlueButton(
                  function: () {
                    _submitDonate();
                  },
                  text: "Mama Bağışı Yap"),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _amountController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  void _submitDonate() {

      if (_formKey.currentState!.validate()) {
      //Get.offAll(NavigationMenu());
      Get.snackbar("Tebrikler",
          "Bağışınız başarıyla alındı. Barınak hayvanlarına yaptığınız bağış için teşekkür ederiz",
          backgroundColor: AppColors1.accentColor);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Kredi Kartı Bilgileri Geçerli!')),
      );
      // Kart bilgilerini işleme alabilirsiniz.
    }
    

    //Get.snackbar("Uyarı", "Bağış yapmak için lütfen bir fiyat belirleyin",backgroundColor: AppColors1.accentColor);
  }

  bool validateCardNumber(String input) {
    if (input.length != 16) return false;
    return _luhnCheck(input); // Luhn algoritması ile kart numarasını doğrula
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
  DropdownMenuItem(child: Text("50 TL"), value: 50),
  DropdownMenuItem(child: Text("100 TL"), value: 100),
  DropdownMenuItem(child: Text("200 TL"), value: 200),
  DropdownMenuItem(child: Text("400 TL"), value: 400),
  DropdownMenuItem(child: Text("800 TL"), value: 800),
  DropdownMenuItem(child: Text("1200 TL"), value: 1200),
  DropdownMenuItem(child: Text("1600 TL"), value: 1600),
  DropdownMenuItem(child: Text("2000 TL"), value: 2000),
];
