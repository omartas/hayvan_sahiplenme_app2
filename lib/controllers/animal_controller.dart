import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:hayvan_sahiplenme_app2/screens/animals_screen.dart';
import '../models/animal_model.dart';

class AnimalController extends GetxController {
    void fetchAnimals() async {
    var snapshot = await _firestore.collection('animals').get();
    var data = snapshot.docs.map((doc) => AnimalModel.fromMap(doc.data())).toList();
    animals.value = data;
  }
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var animals = <AnimalModel>[].obs;

  // Belirli bir barınaktaki tüm hayvanları listeleyen fonksiyon
  void fetchAnimalsByShelterId(String shelterId) async {
    if (shelterId.isEmpty) {
      print("Shelter ID cannot be empty");
      return;
    }
    try {
      // Belirli bir barınaktaki hayvanların verilerini al
      var animalSnapshot = await _firestore
          .collection('shelters')
          .doc(shelterId)
          .collection('animals')
          .get();

      if (animalSnapshot.docs.isEmpty) {
        print("No animals found for shelter with ID: $shelterId");
        return;
      }

      // Verileri model listesine dönüştür
      var data = animalSnapshot.docs.map((doc) {
        final map = doc.data();
        print("Document data for ID ${doc.id}: $map"); // Veriyi yazdır
        if (map == null) {
          print("Document data is null for document ID: ${doc.id}");
          return null;
        }
        try {
          // ID ekleniyor
          map['id'] = doc.id;
          return AnimalModel.fromMap(map);
        } catch (e) {
          print("Error parsing document data for document ID: ${doc.id} - $e");
          return null;
        }
      }).whereType<AnimalModel>().toList();

      if (data.isNotEmpty) {
        print("Fetched ${data.length} animals for shelter with ID: $shelterId");
        animals.value = data;
      } else {
        print("No valid animals data for shelter with ID: $shelterId");
      }
    } catch (e) {
      print("Error fetching animals: $e");
    }
  }
  void adoptAnimal(String animalId) async {
    try {
            await _firestore
          .collection('shelters')
          .doc(AnimalsScreen.shelterId)
          .collection('animals')
          .doc(animalId)
          .update({'status': 'Adopted'});
      fetchAnimalsByShelterId(AnimalsScreen.shelterId); // Hayvanların listesini güncelle
      //Get.snackbar('Adoption', 'You have successfully adopted the animal.');
      Get.back();
    } catch (e) {
      print("Error adopting animal: $e");
    }
  }
}
