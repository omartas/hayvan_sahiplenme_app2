import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hayvan_sahiplenme_app2/screens/search_results_screen.dart';
import '../controllers/pet_search_controller.dart';
import '../services/pet/pet_search_servis.dart';

class FilterScreen extends StatelessWidget {
  final PetFilterController _petFilterController =
      Get.put(PetFilterController());

  @override
  Widget build(BuildContext context) {
    final TextEditingController nameController = TextEditingController();
    int? selectedGender; // 0: Tümü, 1: Erkek, 2: Dişi
    int? selectedGenus;
    bool? isNeutered;
    String? selectedAge;

    return Scaffold(
      appBar: AppBar(
        title: Text('Hayvan Filtreleme'),
        centerTitle: true,
        elevation: 0,
        
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Filtrele',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                
              ),
            ),
            SizedBox(height: 16),

            // Hayvan Türü Seçimi
            Obx(() {
              if (_petFilterController.isLoading.value) {
                return Center(child: CircularProgressIndicator());
              } else if (_petFilterController.petTypes.isEmpty) {
                return Center(child: Text('Hayvan türleri yüklenemedi.'));
              } else {
                return DropdownButtonFormField<int>(
                  decoration: InputDecoration(
                    labelText: "Hayvan Türü Seçiniz",
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.grey[100],
                  ),
                  items: _petFilterController.petTypes.map((petType) {
                    return DropdownMenuItem<int>(
                      value: petType['id'],
                      child: Text(petType['name']),
                    );
                  }).toList(),
                  onChanged: (selectedPetTypeId) {
                    if (selectedPetTypeId != null) {
                      _petFilterController
                          .fetchGenusByPetType(selectedPetTypeId);
                    }
                  },
                );
              }
            }),
            SizedBox8(),

            // Cins Seçimi
            Obx(() {
              if (_petFilterController.isLoading.value) {
                return Center(child: CircularProgressIndicator());
              } else if (_petFilterController.genusList.isEmpty) {
                return Center(child: Text('Lütfen hayvan türü seçiniz.'));
              } else {
                return DropdownButtonFormField<int>(
                  decoration: InputDecoration(
                    labelText: "Cins Seçiniz",
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.grey[100],
                  ),
                  items: _petFilterController.genusList.map((genus) {
                    return DropdownMenuItem<int>(
                      value: genus['id'],
                      child: Text(genus['name']),
                    );
                  }).toList(),
                  onChanged: (selectedGenusId) {
                    selectedGenus = selectedGenusId;
                  },
                );
              }
            }),
            SizedBox8(),

            // Cinsiyet Seçimi
            DropdownButtonFormField<int>(
              decoration: InputDecoration(
                labelText: 'Cinsiyet',
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.grey[100],
              ),
              value: selectedGender,
              items: [
                DropdownMenuItem(value: 0, child: Text('Tümü')),
                DropdownMenuItem(value: 1, child: Text('Erkek')),
                DropdownMenuItem(value: 2, child: Text('Dişi')),
              ],
              onChanged: (value) {
                if (value != null) {
                  selectedGender = value;
                }
              },
            ),
            SizedBox8(),

            // Yaş Girişi
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Yaş',
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.grey[100],
              ),
              onChanged: (value) {
                selectedAge = value;
              },
              initialValue: _petFilterController.age.value,
            ),
            SizedBox8(),

            // Kısır Checkbox
            Obx(() {
              return CheckboxListTile(
                title: Text('Kısır'),
                value: _petFilterController.isNeutered.value,
                onChanged: (value) {
                  
                    isNeutered = value;
                  
                },
                controlAffinity: ListTileControlAffinity.leading,
                activeColor: Colors.teal,
              );
            }),
            SizedBox8(),

            // Arama Butonu
            Center(
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  textStyle: TextStyle(fontSize: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                icon: Icon(Icons.search),
                label: Text('Ara'),
                onPressed: () {
                  searchPets(
                    name: nameController.text,
                    gender: selectedGender,
                    genus: selectedGenus,
                    isNeutered: isNeutered,
                    age: selectedAge,
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

class SizedBox8 extends StatelessWidget {
  const SizedBox8({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: 16); // Yüksekliği arttırarak daha fazla boşluk ekledim
  }
}
