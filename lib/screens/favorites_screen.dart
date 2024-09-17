import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hayvan_sahiplenme_app2/models/animal_model_api.dart';
import '../controllers/favourite_animal_controller.dart';
import 'animal/animal_card.dart';
import 'animal/animal_detail_api_screen.dart';

class FavoritesTestScreen extends StatelessWidget {
  final FavoritesController favoritesController = Get.put(FavoritesController());

  @override
  Widget build(BuildContext context) {
        var defaultImageUrl =
        "https://mir-s3-cdn-cf.behance.net/project_modules/max_1200/65761296352685.5eac4787a4720.jpg";
    return Scaffold(
      appBar: AppBar(
        title: Text('Favori Hayvanlar'),
        centerTitle: true,
      ),
      body: Obx(() {
        if (favoritesController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        if (favoritesController.favoritePets.isEmpty) {
          return Center(child: Text('Henüz favori eklenmemiş.'));
        }

        return ListView.builder(
          itemCount: favoritesController.favoritePets.length,
          itemBuilder: (context, index) {
            final animal = favoritesController.favoritePets[index]['pet'];
            String imageUrl = animal["pictures"].isNotEmpty
                            ? animal.pictures.first
                            : defaultImageUrl;
            final animalToGo = AnimalModelApi.fromJson(animal);
            return GestureDetector(
                          onTap: () {
                            print(animalToGo.name);
                            Get.to(() => AnimalDetailApiScreen(animal: animalToGo));
                          },
                          child: AnimalCard(
                              name: animalToGo.name,
                              age: animalToGo.age,
                              breed: animalToGo.genus?.name??"",
                              imageUrl: imageUrl,
                              gender: animal["gender"] == 'female' ? 'Dişi' : 'Erkek',
                              isNeutered: true,
                              status:
                                  animal["adopted"] ? "Sahiplendirilmiş" : "Uygun",
                              date: DateTime.now()),
                        );
          },
        );
      }),
    );
  }
}
