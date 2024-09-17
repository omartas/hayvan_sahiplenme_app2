import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/pet/feeding_service.dart';

class FeedingController extends GetxController {
  final FeedingService _feedingService = FeedingService();

  var startedFeedings = <dynamic>[];
  var finishedFeedings = <dynamic>[];

  Future<List<dynamic>> fetchFeedings() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token') ?? '';

      if (token.isEmpty) {
        throw Exception('Token bulunamadı.');
      }

      final feedingData = await _feedingService.getMyFeedings(token);
      if (feedingData != null) {
        startedFeedings = feedingData['started']!;
        finishedFeedings = feedingData['finished']!;
        return startedFeedings+finishedFeedings;
      } else {
        throw Exception('Mama bağış verileri alınamadı.');
      }
    } catch (e) {
      throw Exception('Mama bağış verileri alınırken bir hata oluştu: $e');
    }
  }
}



/*import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/pet/feeding_service.dart';

class FeedingController extends GetxController {
  final FeedingService _feedingService = FeedingService();
  
  var startedFeedings = <dynamic>[].obs;
  var finishedFeedings = <dynamic>[].obs;

  var isLoading = true.obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchFeedings();
  }

  Future<void> fetchFeedings() async {
    try {
      isLoading.value = true;
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token') ?? '';

      if (token == null) {
        errorMessage.value = 'Token bulunamadı.';
        return;
      }

      final feedingData = await _feedingService.getMyFeedings(token);
      if (feedingData != null) {
        startedFeedings.value = feedingData['started']!;
        finishedFeedings.value = feedingData['finished']!;
      } else {
        errorMessage.value = 'Mama bağış verileri alınamadı.';
      }
    } catch (e) {
      errorMessage.value = 'Mama bağış verileri alınırken bir hata oluştu: $e';
    } finally {
      isLoading.value = false;
    }
  }
}
*/