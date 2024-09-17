import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:hayvan_sahiplenme_app2/constans.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class PaymentPage extends StatefulWidget {
  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _expiryMonthController = TextEditingController();
  final TextEditingController _expiryYearController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();
  String? htmlContent;

  Future<void> startPayment() async {
    final url = Uri.parse('${baseUrl}/user/start-payment');
    try {
      final response = await http.post(url, body: {
      // Kart bilgilerini burada toplarsınız
      'cardNumber': _cardNumberController.text,
      'expireMonth': _expiryMonthController.text,
      'expireYear': _expiryYearController.text,
      'cvc': _cvvController.text,
      // Diğer gerekli parametreler
    });

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      setState(() {
        // 3D Secure HTML içeriğini alıyoruz
        htmlContent = responseData['data'][0]['Result']['threeDSHtmlContent'];
      });
    } else {
      // Hata durumunu ele alın
      print('Ödeme başlatma başarısız');
    }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Ödeme Sayfası')),
      body: htmlContent == null
          ? Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextFormField(
                    controller: _cardNumberController,
                    decoration: InputDecoration(labelText: 'Kart Numarası'),
                  ),
                  TextFormField(
                    controller: _expiryMonthController,
                    decoration: InputDecoration(labelText: 'Son Kullanma Ayı (MM)'),
                  ),
                  TextFormField(
                    controller: _expiryYearController,
                    decoration: InputDecoration(labelText: 'Son Kullanma Yılı (YY)'),
                  ),
                  SizedBox(height: 8),
                  TextFormField(
                    controller: _cvvController,
                    decoration: InputDecoration(labelText: 'CVV'),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: startPayment,
                    child: Text('Ödemeyi Başlat'),
                  )
                ],
              ),
            )
          : InAppWebView(
              initialData: InAppWebViewInitialData(data: htmlContent!),
            ),
    );
  }
}
