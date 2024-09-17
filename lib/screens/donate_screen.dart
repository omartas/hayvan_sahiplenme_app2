
import 'package:hayvan_sahiplenme_app2/controllers/user_controller.dart';
import 'package:hayvan_sahiplenme_app2/services/payment_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hayvan_sahiplenme_app2/validators.dart';
import '../constans.dart';
import '../models/animal_model_api.dart';
import '../utils/payment_amounts_service.dart';

class DonateScreen extends StatefulWidget {
  final String shelterName;
  final AnimalModelApi animal;

  DonateScreen({required this.shelterName, required this.animal});

  @override
  _DonateScreenState createState() => _DonateScreenState();
}

class _DonateScreenState extends State<DonateScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _expiryDateMonthController =
      TextEditingController();
  final TextEditingController _expiryDateYearController =
      TextEditingController();
  final TextEditingController _cvvController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _idNoController = TextEditingController();
  final TextEditingController _cardHolderNameController =
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

  bool donateAmount = false;
  var _selectedAmount;
  bool showSpecialAmount = false;

  //final _amountController = TextEditingController();
  final PaymentAmountsService paymentService = PaymentAmountsService();
  final _messageController = TextEditingController();
  final UserController userController = Get.find<UserController>();
  @override
  Widget build(BuildContext context) {
    int petID = widget.animal.id;
    String price = _amountController.value.text;
    String type = 'feeding'; // feeding veya adoption
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
    // Örnek veriler
    /*
    int petID =1;
    String price = "100";
    String type = 'feeding'; // feeding veya adoption
    String cardHolderName = 'John doe';
    String cardNumber = '5890040000000016';
    String expireMonth = '12';
    String expireYear = '2025';
    String cvc = '500';
    String tc = '12345678911'; // T.C. Kimlik Numarası
    String city = 'Samsun';
    String district = 'atakum';
    String country = 'Türkiye';
    String address = 'körfez mah 50108 sokak bina 9 no 15';
    */
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
              SizedBox(height: 12),
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
              SizedBox(height: 12),
              if (!showSpecialAmount)
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
                "Ödeme Bilgilerini Giriniz.",
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
                maxLines: 2,
                validator: Validators.validateAddress,
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
                  text: "Mama Bağışı Yap", enabled: true,),
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


    /*
      // Kullanıcıdan alınacak bilgiler
    int petID = 1;
    String price = "100";
    String type = 'feeding'; // feeding veya adoption
    String cardHolderName = 'John doe';
    String cardNumber = '5890040000000016';
    String expireMonth = '12';
    String expireYear = '2025';
    String cvc = '500';
    String tc = '12345678911'; // T.C. Kimlik Numarası
    String city = 'Samsun';
    String district = 'atakum';
    String country = 'Türkiye';
    String address = 'körfez mah 50108 sokak bina 9 no 15';
    */
