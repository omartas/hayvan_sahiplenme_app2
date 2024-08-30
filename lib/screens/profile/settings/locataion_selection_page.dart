import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hayvan_sahiplenme_app2/constans.dart';
import 'package:hayvan_sahiplenme_app2/screens/animals_screen.dart';
import 'package:hayvan_sahiplenme_app2/widgets/navigation_menu.dart';
import '../../../data/cities.dart';  // Şehirler ve ilçeleri içeriyor
import '../../../data/districts.dart';  // İlçeler ve barınakları içeriyor

class LocationSelectionPage extends StatefulWidget {
  @override
  _LocationSelectionPageState createState() => _LocationSelectionPageState();
}

class _LocationSelectionPageState extends State<LocationSelectionPage> {
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
            DropdownButton<String>(
              hint: Text("İl Seçin"),
              value: _selectedCity,
              isExpanded: true,
              items: citiesAndDistricts.keys.map((String city) {
                return DropdownMenuItem<String>(
                  value: city,
                  child: Text(city),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedCity = newValue;
                  _selectedDistrict = null;
            
                });
              },
            ),
            if (_selectedCity != null)
              DropdownButton<String>(
                hint: Text("İlçe Seçin"),
                value: _selectedDistrict,
                isExpanded: true,
                items: citiesAndDistricts[_selectedCity!]!.map((String district) {
                  return DropdownMenuItem<String>(
                    value: district,
                    child: Text(district),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedDistrict = newValue;
                   
                  });
                },
              ),
            
            if (_selectedDistrict != null)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Seçilen Belediye: $_selectedDistrict',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              if (_selectedDistrict != null)
              ElevatedButton(onPressed: (){Get.offAll(()=>NavigationMenu());}, child: Text("Onayla"))
          ],
        ),
      ),
    );
  }
}
  