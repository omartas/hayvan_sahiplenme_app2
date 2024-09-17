import 'package:http/http.dart' as http;
import 'dart:convert';

import '../constans.dart';

class ApiService {
  //final String baseUrl = 'http://192.168.1.33:5000/api/'; // API URL constans tan geliyor.

  Future<Map<String, dynamic>?> request(
    String endpoint,
    String method,
    Map<String, dynamic>? body, {
    bool requiresAuth = false,
    String? token,
  }) async {
    try {
      final url = Uri.parse('$baseUrl$endpoint');
      final headers = {
        'Content-Type': 'application/json',
      };

      if (requiresAuth && token != null) {
        headers['Authorization'] = 'Bearer $token';
      }

      http.Response response;

      // İstek türünü belirle
      switch (method) {
        case 'POST':
          response = await http.post(
            url,
            headers: headers,
            body: jsonEncode(body),
          );
          break;
        case 'PUT':
          response = await http.put(
            url,
            headers: headers,
            body: jsonEncode(body),
          );
          break;
        case 'DELETE':
          response = await http.delete(
            url,
            headers: headers,
          );
          break;
        case 'GET':
        default:
          response = await http.get(url, headers: headers);
      }

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return jsonDecode(response.body);
      } else {
        print('Failed to fetch data: Status Code ${response.statusCode}');
        print('Response Body: ${response.body}');
        return null;
      }
    } catch (e) {
      print('Error in API call: $e');
      return null;
    }
  }

  Future<Map<String, dynamic>?> login(String email, String password) async {
    return request(
      'user/login',
      'POST',
      {
        'email': email,
        'password': password,
      },
    );
  }

  Future<Map<String, dynamic>?> register(String name, String surname, String email, String password, String phoneNumber, String city, String district) async {
    return request(
      'user/register',
      'POST',
      {
        'name': name,
        'surname': surname,
        'email': email,
        'password': password,
        'phoneNumber': phoneNumber,
        'city': city,
        'district': district,
      },
    );
  }

  Future<Map<String, dynamic>?> getUserProfile(String token) async {
    final response = await request(
      'user/get-my-profile',
      'GET',
      null,
      token: token,
    );

    if (response != null && response['success'] == 1) {
      return response['data']['user'];
    } else {
      print('Failed to load user profile');
      return null;
    }
  }
  // Diğer API işlemleri için benzer yöntemler ekleyebilirsiniz.
}
