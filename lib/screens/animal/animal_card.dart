import 'package:flutter/material.dart';
import 'package:hayvan_sahiplenme_app2/constans.dart';

class AnimalCard extends StatelessWidget {
  final String name;
  final String age;
  final String breed;
  final String imageUrl;
  final String gender;
  final bool isNeutered;
  final String status;
  final DateTime date;

  const AnimalCard({
    Key? key,
    required this.name,
    required this.age,
    required this.breed,
    required this.imageUrl,
    required this.gender,
    required this.isNeutered,
    required this.status,
    required this.date,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Hayvan Fotoğrafı
            ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: Image.network(
                imageUrl,
                height: 150,
                width: 150,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 16.0),
            // Hayvan Bilgileri
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: pinkColor,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  AnimalFeaturesText(feature: 'Yaş', aimalfeature: age),
                  AnimalFeaturesText(
                    feature: "Cins",
                    aimalfeature: breed,
                  ),
                  AnimalFeaturesText(
                    feature: "Cinsiyet",
                    aimalfeature: gender,
                  ),
                  AnimalFeaturesText(
                    feature: "Durum",
                    aimalfeature: status,
                  ),
                  Align(child: Text("İlana git ->",),alignment: Alignment.bottomRight,),
                ],
              ),
            ),
            SizedBox(width: 8.0),
            // Butonlar
          ],
        ),
      ),
    );
  }
}

class AnimalFeaturesText extends StatelessWidget {
  const AnimalFeaturesText({
    super.key,
    required this.feature,
    required this.aimalfeature,
  });

  final String feature;
  final String aimalfeature;

  @override
  Widget build(BuildContext context) {
    return Text(
      '$feature : $aimalfeature ',
      style: TextStyle(fontSize: 16.0, color: Colors.grey[700]),
    );
  }
}
