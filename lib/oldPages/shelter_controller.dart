import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'shelter_model.dart';

class ShelterController extends GetxController {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var shelters = <ShelterModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchShelters();
  }

  void fetchShelters() async {
    var snapshot = await _firestore.collection('shelters').get();
    var data = snapshot.docs.map((doc) => ShelterModel.fromMap(doc.data())).toList();
    shelters.value = data;
  }
}
