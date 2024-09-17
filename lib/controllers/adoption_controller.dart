import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/pet/adoption_service.dart';

class AdoptionController extends GetxController {
  final AdoptionService _adoptionService = AdoptionService();
  
  var startedAdoptions = <dynamic>[].obs;
  var rejectedAdoptions = <dynamic>[].obs;
  var approvedAdoptions = <dynamic>[].obs;

  var isLoading = true.obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchAdoptions();
  }

  Future<void> fetchAdoptions() async {
    try {
      isLoading.value = true;
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token') ?? '';

      final adoptionData = await _adoptionService.getMyAdoptions(token);
      if (adoptionData != null) {
        startedAdoptions.value = adoptionData['started']!;
        rejectedAdoptions.value = adoptionData['rejected']!;
        approvedAdoptions.value = adoptionData['approved']!;
      } else {
        errorMessage.value = 'Sahiplendirme verileri alınamadı.';
      }
    } catch (e) {
      errorMessage.value = 'Sahiplendirme verileri alınırken bir hata oluştu: $e';
    } finally {
      isLoading.value = false;
    }
  }
}
