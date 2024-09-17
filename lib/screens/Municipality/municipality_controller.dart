import 'package:get/get.dart';
import 'municipality_model.dart';
import 'municipality_service.dart';

class MunicipalityController extends GetxController {
  final MunicipalityService _municipalityService = MunicipalityService();
  var municipality = Municipality(
    id: 0,
    cityID: 0,
    districtID: 0,
    name: '',
    email: '',
    phoneNumber: '',
    logo: null,
    isApproved: false,
    subMerchantKey: '',
    iyzicoExternalID: '',
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
    shelters: [],
    city: City(id: 0, name: ''),
    district: District(id: 0, name: '', cityID: 0),
  ).obs;
  var isLoading = true.obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchMunicipality();
  }

  Future<void> fetchMunicipality() async {
    try {
      isLoading.value = true;
      Municipality? municipalityData = await _municipalityService.getMunicipality();
      if (municipalityData != null) {
        municipality.value = municipalityData;
      } else {
        errorMessage.value = 'Belediye bilgisi alınamadı.';
      }
    } catch (e) {
      errorMessage.value = 'Bir hata oluştu: $e';
    } finally {
      isLoading.value = false;
    }
  }
}
