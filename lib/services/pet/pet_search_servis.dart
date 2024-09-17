import 'dart:convert';
import 'package:get/get.dart';
import 'package:hayvan_sahiplenme_app2/utils/token_manager.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../constans.dart';
import '../../models/animal_model_api.dart';
import '../../screens/search_results_screen.dart';

class PetService {
  
  Future<List<dynamic>> getPetTypes() async {
    final url = Uri.parse('${baseUrl}/get-pet-types');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        return responseData['data']['types'];
      } else {
        throw Exception('Türleri yükleyemedik: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Hata: $e');
    }
  }

  Future<List<dynamic>> getGenusByPetType(int petTypeId) async {
    final url = Uri.parse('${baseUrl}/get-genus/$petTypeId');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        return responseData['data'];
      } else {
        throw Exception('Cinsleri yükleyemedik: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Hata: $e');
    }
  }
}



Future<void> searchPets({
  String? name,
  int? gender,
  int? genus,
  bool? isNeutered,
  String? age,
  
}) async {
  // Token alma fonksiyonu
  Future<String?> _getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }
  String? token = await _getToken();
  if (token == null) {
    print('Token bulunamadı');
    return;
  }
  final Uri url = Uri.parse('${baseUrl}/user/search-pet');
  
  Map<String, dynamic> searchBody = {};
  
  if (name != null && name.isNotEmpty) {
    searchBody['name'] = name;
  }
  if (gender != null && gender != 0) {
    searchBody['gender'] = gender;
  }
  if (genus != null && genus != 0) {
    searchBody['genus'] = genus;
  }
  if (isNeutered != null && isNeutered != 0) {
    searchBody['kisirlik'] = isNeutered ? 1 : 0;
  }
  if (age != null && age.isNotEmpty) {
    searchBody['age'] = age;
  }



  try {
    if(token!=null){
      print(token);
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token', // Kullanıcı token'ı burada olacak
      },
      body: jsonEncode(searchBody),
    );

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      //print('Arama sonuçları: ${jsonData['data']}');
      List<dynamic> searchResults = jsonData['data']; // Arama sonuçlarını alın
      searchResults.map((animalJson) => AnimalModelApi.fromJson(animalJson)).toList();
      // Arama sonuçlarını SearchResultsScreen sayfasına yönlendir
      Get.to(() => SearchResultScreen(searchResults: searchResults));
      // Burada arama sonuçlarını işle
    } else {
      print('Arama başarısız: ${response.statusCode}');
    }
  } 
    }
  catch (error) {
    print('Arama hatası: $error');
  }
}
