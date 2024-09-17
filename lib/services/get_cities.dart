import 'dart:convert';
import 'package:http/http.dart' as http;

import '../constans.dart';
import '../models/city_model.dart';

class CityService {

  static Future<List<City>> getCities() async {
    final response = await http.get(Uri.parse('$baseUrl/get-cities'));

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => City.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load cities');
    }
  }
}
