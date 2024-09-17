// lib/payment_service.dart
import 'dart:convert';
import 'package:hayvan_sahiplenme_app2/constans.dart';
import 'package:http/http.dart' as http;

class PaymentAmountService {
  // Ödemeleri çekecek fonksiyon
  Future<List<int>> fetchPaymentAmounts() async {
    final response = await http.get(Uri.parse('${baseUrl}/payment-amounts'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      // Verilerin null olup olmadığını kontrol et
      if (data == null || data['data'] == null) {
        return []; // Eğer veri yoksa boş bir liste döndür
      }

      final List<dynamic> paymentData = data['data'];

      // Verilerin tipini kontrol et ve listeye dönüştür
      try {
        return paymentData.map((item) => item['amount'] as int).toList();
      } catch (e) {
        print('Error parsing amounts: $e');
        return []; // Parse hatası olursa boş liste döndür
      }
    } else {
      throw Exception('Failed to load payment amounts');
    }
  }
}
