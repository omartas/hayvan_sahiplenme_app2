import 'package:http/http.dart' as http;
import 'dart:convert';
import '../constans.dart';
import '../models/user_model.dart';

class UserApiService {
  
Future<User?> getMyProfile(String token) async {
    final url = '$baseUrl/user/get-my-profile';

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final userData = data['data']['user'];
        return User.fromJson(userData);
      } else {
        throw Exception('Failed to load user profile');
      }
    } catch (e) {
      print('Error fetching user profile: $e');
      return null;
    }
  }
}
