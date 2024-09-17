import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hayvan_sahiplenme_app2/constans.dart';
import 'package:hayvan_sahiplenme_app2/models/animal_model_api.dart';
import 'package:hayvan_sahiplenme_app2/widgets/navigation_menu.dart';
import '../controllers/user_controller.dart';
import '../services/payment_service.dart';
import '../utils/payment_amounts_service.dart';
import '../validators.dart';

class AdoptionFormPage extends StatefulWidget {
  final AnimalModelApi animal;

  const AdoptionFormPage({super.key, required this.animal});

  @override
  _AdoptionFormPageState createState() => _AdoptionFormPageState();
}

class _AdoptionFormPageState extends State<AdoptionFormPage> {
  final TextEditingController _cvvController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _cardHolderNameController =
      TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _idNoController = TextEditingController();
  final TextEditingController _expiryDateMonthController =
      TextEditingController();
  final TextEditingController _expiryDateYearController =
      TextEditingController();
  List<int> amounts = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchAmounts(); // Servisten veriyi çek
  }

  // Servisi kullanarak veriyi çek
  Future<void> fetchAmounts() async {
    PaymentAmountService service = PaymentAmountService(); // Servisi oluştur
    try {
      final fetchedAmounts = await service.fetchPaymentAmounts();

      // Liste null veya boş değilse UI'yi güncelle
      setState(() {
        amounts = fetchedAmounts;
        isLoading = false;
      });
    } catch (e) {
      print('Error fetching payment amounts: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  var _selectedAmount;

  DateTime? selectedDate;
  bool removeAdFromListing = false;
  bool showPaymentSection = false;

  final PaymentAmountsService paymentService = PaymentAmountsService();
  final UserController userController = Get.find<UserController>();
  @override
  Widget build(BuildContext context) {
    var _appBarTitle = "Hayvan Sahiplenme Formu";
    var _adoptPriceInfo =
        "Hayvan dostumuzu Sahiplenmek için minimum 100 TL mama ücreti ödemeniz gerekmektedir. Bu bedel diğer hayvan dostlarımızın beslenmesi için kullanılacaktır.";
    var _cardHolderLabelText = "Kart Sahibinin Adı Soyadı";
    var _cardNumberLabelText = "Kart Numarası";
    var _cardDateLabelText = "Son Kullanma Tarihi (AA/YY)";
    var _cvvLabelText = "CVV";

    int petID = widget.animal.id;
    String price = _amountController.value.text;
    String type = 'adoption'; // feeding veya adoption
    String cardHolderName = _cardHolderNameController.text;
    String cardNumber = _cardNumberController.text;
    String expireMonth = _expiryDateMonthController.text;
    String expireYear = "20" + _expiryDateYearController.text;
    String cvc = _cvvController.text;
    String tc = _idNoController.text; // T.C. Kimlik Numarası
    String city = userController.user.value.city.name;
    String district = userController.user.value.district.name;
    String country = 'Türkiye';
    String address = _addressController.text;
    return Scaffold(
      resizeToAvoidBottomInset:
          false, // klavye açıldığında bottom overflow hatasını önler.
      appBar: AppBar(
        title: Text(_appBarTitle),
      ),
      body: Padding(
        padding: normalPadding32,
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Text(_adoptPriceInfo),
              SizedBox(height: 16.0),
              DropdownButtonFormField<int>(
                validator: (value) {
                  if (value == null || value.toString().isEmpty) {
                    return 'Lütfen bir mama bağış tutarı seçiniz.'; // Doğrulama mesajı
                  }
                  return null;
                },
                dropdownColor: Colors.white,
                hint: Text("Bağış Miktarını Seçiniz"), // Açılış mesajı
                value: _selectedAmount, // Seçili olan değer
                items: amounts.map<DropdownMenuItem<int>>((int value) {
                  return DropdownMenuItem<int>(
                    value: value,
                    child: Text(
                        '$value TL'), // Değerin yanında birim gösterebiliriz
                  );
                }).toList(),
                onChanged: (int? value) {
                  setState(() {
                    _selectedAmount = value; // Seçili değeri güncelle
                    _amountController.text = value != null
                        ? value.toString()
                        : ''; // TextField'a yazdır
                  });
                },
                isExpanded: true, // Dropdown genişler
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
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _expiryDateMonthController,
                      keyboardType: TextInputType.datetime,
                      decoration: InputDecoration(
                        labelText: "Ay (AA)",
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Lütfen son kullanma tarihini girin';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: _expiryDateYearController,
                      keyboardType: TextInputType.datetime,
                      decoration: InputDecoration(
                        labelText: "Yıl (YY)",
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Lütfen son kullanma tarihini girin';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
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
              Text(
                "Fatura kesimi için gereklidir.",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBoxSize8(),
              TextFormField(
                decoration: InputDecoration(
                  labelText: "T.C Kimik No / Vergi No",
                  border: OutlineInputBorder(),
                ),
                controller: _idNoController,
                keyboardType: TextInputType.number,
                validator: Validators.validateTcOrVergiNo,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(11), // Maksimum 114 rakam
                ],
              ),
              SizedBoxSize8(),
              TextFormField(
                validator: Validators.validateAddress,
                maxLines: 2,
                decoration: InputDecoration(
                  labelText: "Adres",
                  border: OutlineInputBorder(),
                ),
                controller: _addressController,
              ),
              SizedBox(height: 20),
              BlueButton(
                function: () {
                  _formKey.currentState!.save();
                  if (_formKey.currentState!.validate()) {
                    paymentService.initiatePayment(
                      context: context,
                      userController: userController,
                      petID: petID,
                      price: price,
                      type: type,
                      cardHolderName: cardHolderName,
                      cardNumber: cardNumber,
                      expireMonth: expireMonth,
                      expireYear: expireYear,
                      cvc: cvc,
                      tc: tc,
                      address: address,
                      city: city,
                      district: district,
                      country: country,
                    );
                  }
                },
                text: "Sahiplenmeyi Başlat",
                enabled: true,
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
/*
List<DropdownMenuItem> donationAmounts = [
  DropdownMenuItem(child: Text("100 TL"), value: 100),
  DropdownMenuItem(child: Text("200 TL"), value: 200),
  DropdownMenuItem(child: Text("400 TL"), value: 400),
  DropdownMenuItem(child: Text("800 TL"), value: 800),
  DropdownMenuItem(child: Text("1200 TL"), value: 1200),
  DropdownMenuItem(child: Text("1600 TL"), value: 1600),
  DropdownMenuItem(child: Text("2000 TL"), value: 2000),
];
*/
