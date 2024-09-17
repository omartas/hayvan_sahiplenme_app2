import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';
import '../services/user_service.dart'; // API servislerini yöneten sınıf
class UserController extends GetxController {
  final UserApiService _userApiService = UserApiService();

  var user = User(
    id: 0,
    name: '',
    surname: '',
    email: '',
    phoneNumber: '',
    accessToken: '',
    refreshToken: '',
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
    city: City(id: 0, name: '', createdAt: DateTime.now(), updatedAt: DateTime.now()),
    district: District(id: 0, name: '', cityID: 0, createdAt: DateTime.now(), updatedAt: DateTime.now()),
  ).obs;

  var isLoading = true.obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchUser();
  }

  Future<void> fetchUser() async {
    try {
      isLoading.value = true;
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token') ?? '';

      if (token.isNotEmpty) {
        final fetchedUser = await _userApiService.getMyProfile(token);
        if (fetchedUser != null) {
          user.value = fetchedUser;
        } else {
          errorMessage.value = 'Kullanıcı verileri getirilemedi.';
        }
      } else {
        errorMessage.value = 'Token bulunamadı.';
      }
    } catch (e) {
      errorMessage.value = 'Kullanıcı verileri alınırken bir hata oluştu: $e';
    } finally {
      isLoading.value = false;
    }
  }
}






/*import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';
import '../services/user_service.dart'; // Token'ı yönetmek için

class UserController extends GetxController {
  final UserApiService _userApiService = UserApiService();
  var user = User(
    id: 0,
    name: '',
    email: '',
    phoneNumber: '',
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ).obs;

  @override
  void onInit() {
    super.onInit();
    fetchUser();
  }

  Future<void> fetchUser() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('authToken') ?? '';
      final currentUserId = prefs.getInt('userId') ?? 0; // User ID'yi SharedPreferences'dan alın

      if (currentUserId != 0) {
        final fetchedUser = await _userApiService.getUser(currentUserId, token);
        user.value = fetchedUser;
      }
    } catch (e) {
      print("Error fetching user: $e");
    }
  }
}
*/