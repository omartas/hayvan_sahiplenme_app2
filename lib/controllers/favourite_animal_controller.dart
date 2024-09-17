import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../constans.dart';

class FavoritesController extends GetxController {
  // Favori hayvanlar listesi
  var favoritePets = <dynamic>[].obs;
  var isLoading = false.obs;
    // Her hayvan için favori olup olmadığını kontrol eden değişken
  var isFavorite = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchFavorites();
  }

  // Token alma fonksiyonu
  Future<String?> _getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  // Favori hayvanları getir
  Future<void> fetchFavorites() async {
    isLoading(true);

    try {
      String? token = await _getToken();
      if (token == null) {
        throw Exception('No token found');
      }

      final response = await http.get(
        Uri.parse('$baseUrl/user/get-favorites'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        favoritePets.value = jsonResponse['data'];
      } else {
        throw Exception('Favorileri getirme başarısız oldu');
      }
    } catch (e) {
      Get.snackbar('Error', 'Favorileri yüklerken hata oluştu: $e');
    } finally {
      isLoading(false);
    }
  }
bool checkIfFavorite(int petId) {
    return favoritePets.any((fav) => fav['petID'] == petId);
  }
  // Favorilere ekle
  Future<void> addToFavorites(int petId) async {
    try {
      String? token = await _getToken();
      if (token == null) {
        throw Exception('No token found');
      }

      final response = await http.post(
        Uri.parse('$baseUrl/user/add-to-favorites/$petId'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        fetchFavorites(); // Favori listesi güncellenir
      }
    } catch (e) {
      Get.snackbar('Error', 'Favorilere ekleme sırasında hata oluştu: $e');
    }
  }

  // Favoriden çıkar
  Future<void> removeFromFavorites(int favoriteId) async {
    try {
      String? token = await _getToken();
      if (token == null) {
        throw Exception('No token found');
      }

      final response = await http.delete(
        Uri.parse('$baseUrl/user/delete-from-favorites/$favoriteId'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        fetchFavorites(); // Favori listesi güncellenir
      }
    } catch (e) {
      Get.snackbar('Error', 'Favorilerden çıkarma sırasında hata oluştu: $e');
    }
  }
}
