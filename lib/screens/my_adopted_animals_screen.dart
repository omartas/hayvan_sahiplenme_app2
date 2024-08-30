import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/auth_controller.dart';
import '../models/adopted_animal.dart';
import 'login_screen.dart';

class AdoptedAnimalsPage extends StatelessWidget {
  final AuthController authController = Get.find<AuthController>();
    
  final List<AdoptedAnimal> adoptedAnimals = [
    AdoptedAnimal(
      name: "Bella",
      breed: "Golden Retriever",
      imageUrl: "https://dogakopekuretim.com/wp-content/uploads/2021/06/golden-retriever-1.jpg",
      adoptionStatus: "Teslim Alındı",
    ),
    AdoptedAnimal(
      name: "Max",
      breed: "Alman",
      imageUrl: "https://www.guardiaturca.com/wp-content/uploads/german-shepherd-alman-kurdu-ozellikleri.jpg",
      adoptionStatus: "Bekleniyor",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    if (authController.user == null) {
          return Center(
            child: ElevatedButton(
                onPressed: () => Get.offAll(() => LoginScreen()),
                child: Text(" Lütfen Giris yap")),
          );
        }
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Sahiplendiğim Hayvanlar"),
      ),
      body: ListView.builder(
        itemCount: adoptedAnimals.length,
        itemBuilder: (context, index) {
          final animal = adoptedAnimals[index];
          return Card(
            margin: EdgeInsets.all(8.0),
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(animal.imageUrl),
                radius: 30,
              ),
              title: Text(animal.name),
              subtitle: Text(animal.breed),
              trailing: _buildAdoptionStatus(animal.adoptionStatus),
            ),
          );
        },
      ),
    );
  }

  Widget _buildAdoptionStatus(String status) {
    Color statusColor;

    switch (status) {
      case "Teslim Alındı":
        statusColor = Colors.green;
        break;
      case "Bekleniyor":
        statusColor = Colors.orange;
        break;
      default:
        statusColor = Colors.grey;
    }

    return Chip(
      label: Text(
        status,
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: statusColor,
    );
  }
}
