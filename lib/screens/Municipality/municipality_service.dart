import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../constans.dart';
import 'municipality_model.dart';

class MunicipalityService {
  

  Future<Municipality?> getMunicipality() async {
    Future<String?> _getToken() async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        return prefs.getString('token');
      }

      String? token = await _getToken();
      if (token == null) {
        throw Exception('No token found');
      }
    final response = await http.get(
      Uri.parse('$baseUrl/user/get-municipality'),
      headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return Municipality.fromJson(json['data']['municipality']);
    } else {
      print('Failed to load municipality: ${response.statusCode}');
      return null;
    }
  }
}
