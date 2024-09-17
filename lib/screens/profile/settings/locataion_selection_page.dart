import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hayvan_sahiplenme_app2/constans.dart';
import '../../../controllers/city_controller.dart';
import '../../../models/city_model.dart'; // Şehirler ve ilçeleri içeriyor

class LocationSelectionPage extends StatefulWidget {
  @override
  _LocationSelectionPageState createState() => _LocationSelectionPageState();
}

class _LocationSelectionPageState extends State<LocationSelectionPage> {
  final CityController cityController = Get.put(CityController());
  String? _selectedCity;
  String? _selectedDistrict;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Barınak Seçimi'),
      ),
      body: Padding(
        padding: normalPadding32,
        child: Column(
          children: [
            // Şehir seçim dropdown
            DropdownButtonFormField<String>(
              hint: Text("İl Seçin"),
              value: _selectedCity,
              icon: Icon(Icons.location_pin),
              isExpanded: true,
              items: cityController.cities
                  .map((City city) => DropdownMenuItem<String>(
                        value: city.name,
                        child: Text(city.name),
                      ))
                  .toSet()
                  .toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedCity = newValue;
                  _selectedDistrict = null; // İlçe seçimlerini sıfırla
                });
              },
            ),
            SizedBox(height: 12),
            // İlçe seçim dropdown
            if (_selectedCity != null)
              DropdownButtonFormField<String>(
                hint: Text("İlçe Seçin"),
                value: _selectedDistrict,
                icon: Icon(Icons.location_city),
                isExpanded: true,
                items: cityController.cities
                    .where((city) => city.name == _selectedCity)
                    .expand((city) => city.districts)
                    .map((District district) => DropdownMenuItem<String>(
                          value: district.name,
                          child: Text(district.name),
                        ))
                    .toSet()
                    .toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedDistrict = newValue;
                  });
                },
              ),
            SizedBox(height: 12),
            // Seçilen ilçe ve onay butonu
            if (_selectedDistrict != null)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Seçilen Belediye: $_selectedDistrict',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            if (_selectedDistrict != null)
              ElevatedButton(
                onPressed: () {
                  // Get.offAll(() => NavigationMenu());
                  // Konum değiştirme olacaksa burada işlem yapılacak.
                },
                child: Text("Onayla"),
              ),
          ],
        ),
      ),
    );
  }
}
