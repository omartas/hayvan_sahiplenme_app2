import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hayvan_sahiplenme_app2/controllers/animal_controller.dart';
import '../models/animal_model.dart';

class AnimalDetailScreen extends StatelessWidget {
  final AnimalModel animal;
  final String imageUrl ='https://st.depositphotos.com/1594920/2143/i/450/depositphotos_21432503-stock-photo-close-up-of-border-collie.jpg';

  AnimalDetailScreen({required this.animal});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(animal.breed),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Placeholder image from the internet
            Image.network(
              imageUrl,
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              Text("Tarih: ${animal.date.toDate()}",),
              IconButton(onPressed: (){}, icon: Icon(Icons.favorite))
            ],),
            //SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
              ElevatedButton(onPressed: (){}, child: Text("Mama Ver")),
              ElevatedButton(onPressed: (){showAdoptDialog(context, animal);}, child: Text("Sahiplen")),
            ],),
            SizedBox(height: 16),

            Text('Type: ${animal.type}', style: TextStyle(fontSize: 18)),
            Text('Age: ${animal.age}', style: TextStyle(fontSize: 18)),
            Text('Gender: ${animal.gender}', style: TextStyle(fontSize: 18)),
            Text('Neutered: ${animal.isNeutered}', style: TextStyle(fontSize: 18)),
            Text('Status: ${animal.status}', style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}



void showAdoptDialog(BuildContext context, AnimalModel animal) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Adopt ${animal.breed}?'),
          content: Text('Are you sure you want to adopt this animal?'),
          actions: [
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Buraya sahiplenme işlemini ekleyebilirsiniz
                AnimalController().adoptAnimal(animal.id);
                Get.back();
                Get.snackbar('Adoption', 'You have successfully adopted ${animal.breed}');
              },
              child: Text('Adopt'),
            ),
          ],
        );
      },
    );
  }