import 'dart:convert';
import 'package:hayvan_sahiplenme_app2/constans.dart';
import 'package:http/http.dart' as http;

class FeedingService {
  Future<Map<String, dynamic>?> getMyFeedings(String token) async {
    final url = Uri.parse('${baseUrl}/user/get-my-feedings');

    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body)['data'];
    } else {
      return null;
    }
  }
}
