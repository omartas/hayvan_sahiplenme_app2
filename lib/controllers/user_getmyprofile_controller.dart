import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/api_service.dart';

class UserGetMyProfileController extends GetxController {
  var userData = {}.obs;
  var isLoading = true.obs;

  final ApiService apiService = ApiService();

  @override
  void onInit() {
    super.onInit();
    fetchUserProfile();
  }

  Future<void> fetchUserProfile() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');
      if (token != null) {
        final data = await apiService.getUserProfile(token);
        if (data != null) {
          userData.value = data;
        } else {
          Get.snackbar('Error', 'Failed to load user data');
        }
      }
    } finally {
      isLoading.value = false;
    }
  }
}
