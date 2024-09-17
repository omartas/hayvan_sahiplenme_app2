import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../constans.dart';

class AdoptionService {
  Future<Map<String, List<dynamic>>?> getMyAdoptions(String token) async {
    try {
      final url = Uri.parse('${baseUrl}user/get-my-adoptions');
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };

      final response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['success'] == 1) {
          return {
            'started': data['data']['started'],
            'rejected': data['data']['rejected'],
            'approved': data['data']['approved'],
          };
        } else {
          print('Failed to fetch adoptions: ${data['message']}');
          return null;
        }
      } else {
        print('Failed to fetch adoptions: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error fetching adoptions: $e');
      return null;
    }
  }
}
