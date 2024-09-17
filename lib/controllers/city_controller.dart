import 'package:get/get.dart';

import '../models/city_model.dart';
import '../services/get_cities.dart';

class CityController extends GetxController {
  var cities = <City>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    fetchCities();
    super.onInit();
  }

  void fetchCities() async {
    try {
      isLoading(true);
      var fetchedCities = await CityService.getCities();
      if (fetchedCities != null) {
        cities.assignAll(fetchedCities);
      }
    } finally {
      isLoading(false);
    }
  }
}
