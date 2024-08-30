import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/animal_controller.dart';
import '../controllers/auth_controller.dart';
import 'animal/animal_card.dart';
import 'animal/animal_detail_test_screen.dart';
import 'login_screen.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find<AuthController>();
    final AnimalController animalController = Get.put(AnimalController());
    final String imageUrl =
        'https://st.depositphotos.com/1594920/2143/i/450/depositphotos_21432503-stock-photo-close-up-of-border-collie.jpg';

    if (authController.user == null) {
      return Center(
        child: ElevatedButton(
            onPressed: () => Get.offAll(() => LoginScreen()),
            child: Text(" Lütfen Giris yap")),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Favoriler'),
        centerTitle: true,
      ),
      body: animalController.animals.isEmpty
          ? Center(child: CircularProgressIndicator())
          : FavouritesAnimalsList(
              animalController: animalController, imageUrl: imageUrl),
    );
  }
}

class FavouritesAnimalsList extends StatelessWidget {
  const FavouritesAnimalsList({
    super.key,
    required this.animalController,
    required this.imageUrl,
  });

  final AnimalController animalController;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 16, right: 16, left: 16),
      child: ListView.builder(
        itemCount: 4,
        itemBuilder: (context, index) {
          final animal = animalController.animals[index];
          return GestureDetector(
            onTap: () {
              Get.to(AnimalDetailTestScreen(animal: animal));
            },
            child: AnimalCard(
              name: animal.name,
              breed: animal.breed,
              age: animal.age.toString(),
              imageUrl: animal.imageUrl.first ?? imageUrl,
              gender: animal.gender,
              isNeutered: animal.isNeutered,
              status: animal.status,
              date: animal.date.toDate(),
            ),
          );
        },
      ),
    );
  }
}
