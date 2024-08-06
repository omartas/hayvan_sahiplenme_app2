  import 'package:flutter/material.dart';
  import 'package:get/get.dart';
  import '../controllers/animal_controller.dart';
import 'animal_detail_screen.dart';

  class AnimalsScreen extends StatelessWidget {
    String imageUrl ="https://via.placeholder.com/150";
    static final String shelterId = "shelter1"; // Barınak ID'sini almak için

    @override
    Widget build(BuildContext context) {
      // AnimalController'ı al
      final AnimalController animalController = Get.put(AnimalController());

      // Barınak ID'sine göre hayvanları çek
      animalController.fetchAnimalsByShelterId(shelterId);

      return Scaffold(
        appBar: AppBar(title: Text('Animals')),
        body: Obx(() {
          // Hayvanları al ve listele
          if (animalController.animals.isEmpty) {
            return Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
            itemCount: animalController.animals.length,
            itemBuilder: (context, index) {
              final animal = animalController.animals[index];
              return Card(

                child: ListTile(
                  leading: Image.network(imageUrl),
                  title: Text(animal.breed),
                  subtitle: Text('Type: ${animal.type}, Age: ${animal.age}'),
                  trailing: Text(animal.status),
                  onTap: () {
                  // Hayvan detay sayfasına yönlendirme
                  Get.to(() => AnimalDetailScreen(animal: animal));
                },
                ),
              );
            },
          );
        }),
      );
    }
  }
