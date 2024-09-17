import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/animal_model_api.dart';
import '../../constans.dart';

class AdoptionPostsService {
  Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<List<AnimalModelApi>> fetchAdoptionPosts() async {
    String? token = await getToken();
    if (token == null) {
      throw Exception('No token found');
    }

    final response = await http.get(
      Uri.parse('$baseUrl/user/get-pets-on-shelter/1'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      if (jsonData['success'] == 1) {
        var animalsData = jsonData['data']['pets']["data"] as List;
        return animalsData.map((animalJson) => AnimalModelApi.fromJson(animalJson)).toList();
      } else {
        throw Exception('Failed to load posts');
      }
    } else {
      throw Exception('Failed to connect to the server');
    }
  }
}
