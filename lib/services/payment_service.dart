import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hayvan_sahiplenme_app2/constans.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controllers/user_controller.dart'; // UserController'ı import edin
import '../widgets/webview3d.dart'; // 3D Secure sayfası import

class PaymentAmountsService {
  Future<void> initiatePayment({
    required BuildContext context,
    required UserController userController,
    required int petID,
    required String price,
    required String type,
    required String cardHolderName,
    required String cardNumber,
    required String expireMonth,
    required String expireYear,
    required String cvc,
    required String tc,
    required String address,
    required String city,
    required String district,
    required String country,
  }) async {
    try {
      //String city = userController.user.value.city.name;
      //String district = userController.user.value.district.name;
      //String country = 'Türkiye';

      var paymentRequest = {
        "petID": petID,
        "price": price,
        "type": type, // feeding veya adoption olabilir
        "cardHolderName": cardHolderName,
        "cardNumber": int.parse(cardNumber),
        "expireMonth": int.parse(expireMonth),
        "expireYear": int.parse(expireYear),
        "cvc": int.parse(cvc),
        "tc": tc,
        "address": {
          "city": city,
          "district": district,
          "country": country,
          "address": address,
        }
      };

      Future<String?> _getToken() async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        return prefs.getString('token');
      }

      String? token = await _getToken();
      if (token == null) {
        throw Exception('No token found');
      }

      var response = await http.post(
        Uri.parse('${baseUrl}/user/start-payment'), // BACKEND URL
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(paymentRequest),
      );

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        var jsonResponseData = jsonResponse['data'][0]['Result'];
        print("$jsonResponse");
        if (jsonResponse['data'][0]['Result']["status"] == 'success') {
          // Eğer 3D Secure için HTML içeriği varsa yönlendirme yap
          if (jsonResponseData.containsKey('threeDSHtmlContent')) {
            Get.to(ThreeDSecurePage(
                htmlContent: utf8.decode(
                    base64.decode(jsonResponseData['threeDSHtmlContent']))));
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Ödeme Başarılı!')),
            );
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Ödeme Başarısız! ${response.statusCode}')),
          );
        }
      } else {
        throw Exception('Ödeme işlemi başlatılamadı! ${response.statusCode}');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Hata: $e')),
      );
    }
  }
}
