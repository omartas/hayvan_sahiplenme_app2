import 'package:get/get.dart';
import '../services/pet/pet_search_servis.dart';

class PetFilterController extends GetxController {
  var name = ''.obs;
  var selectedGender = 0.obs; // 0: Tümü, 1: Erkek, 2: Dişi
  var isNeutered = false.obs; // Kısır mı
  var age = ''.obs; // Yaş
  var petTypes = <dynamic>[].obs;
  var genusList = <dynamic>[].obs;
  var isLoading = false.obs;

  final PetService _petService = PetService();

  @override
  void onInit() {
    super.onInit();
    fetchPetTypes();
  }

  Future<void> fetchPetTypes() async {
    isLoading.value = true;
    try {
      final types = await _petService.getPetTypes();
      petTypes.assignAll(types);
    } catch (e) {
      print(e);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchGenusByPetType(int petTypeId) async {
    isLoading.value = true;
    try {
      final genus = await _petService.getGenusByPetType(petTypeId);
      genusList.assignAll(genus);
    } catch (e) {
      print(e);
    } finally {
      isLoading.value = false;
    }
  }
}