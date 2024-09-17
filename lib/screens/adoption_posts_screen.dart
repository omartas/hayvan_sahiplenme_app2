import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hayvan_sahiplenme_app2/screens/animal/animal_card.dart';
import '../constans.dart';
import '../controllers/adoption_posts_shelter_controller.dart';
import '../models/animal_model_api.dart';
import '../services/pet/adoption_posts_shelter_service.dart';
import 'Municipality/municipality_controller.dart';
import 'animal/animal_detail_api_screen.dart';
import 'pet_search_screen.dart';

class AdoptionPostsPage extends StatelessWidget {
  final AdoptionPostsService _adoptionPostsService = AdoptionPostsService();

  @override
  Widget build(BuildContext context) {

    final MunicipalityController municipalityController =
        Get.put(MunicipalityController());
    final AdoptionPostsController controller =
        Get.put(AdoptionPostsController());
    var myDistrict = municipalityController.municipality.value.district.name;

    controller.loadAdoptionPosts();

    return Scaffold(
        appBar: AppBar(
          title:Row(
          children: [
            //SizedBox(width: 25),
            Container(
                height: 50,
                width: 50,
                child: CircleAvatar(
                            radius: 30,
                            backgroundImage: municipalityController
                                        .municipality.value.logo !=
                                    null
                                ? NetworkImage(
                                    municipalityController.municipality.value.logo!)
                                : AssetImage(defaultAppBarImage)
                                    as ImageProvider,
                          ),
                    ),
            SizedBox(width: 55),
            Text('$myDistrict Belediyesi'),
          ],
        ),
          centerTitle: true,
        ),
        body: Column(
          children: [
            SizedBox(
              height: 8,
            ),
            SearchBar(
              trailing: <Widget>[
                Tooltip(
                  message: 'Filtrele',
                  child: IconButton(
                    onPressed: () {Get.to(() => FilterScreen());}, // FilterScreen'i yeni bir sayfa olarak açıyoruz 
                    icon: const Icon(Icons.filter_list_alt),
                  ),
                )
              ],
              leading: IconButton(onPressed: () {}, icon: Icon(Icons.search)),
              hintText: "arama yapınız.",
            ),
            SizedBox(
              height: 8,
            ),
            FutureBuilder<List<AnimalModelApi>>(
              future: _adoptionPostsService.fetchAdoptionPosts(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(
                      child: Text('Bir hata oluştu: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('Hiç hayvan bulunamadı.'));
                } else {
                  final animals = snapshot.data!;
                  return Expanded(
                    child: ListView.builder(
                      itemCount: animals.length,
                      itemBuilder: (context, index) {
                        final animal = animals[index];
                        String imageUrl = animal.pictures.isNotEmpty
                            ? animal.pictures.first
                            : defaultImageUrl;
                        return GestureDetector(
                          onTap: () {
                            Get.to(() => AnimalDetailApiScreen(animal: animal));
                          },
                          child: AnimalCard(
                              name: animal.name,
                              age: animal.age.toString(),
                              breed: animal.genus!.name,
                              imageUrl: imageUrl,
                              gender: animal.gender == 'female' ? 'Dişi' : 'Erkek',
                              isNeutered: true,
                              status:
                                  animal.adopted ? "Sahiplendirilmiş" : "Uygun",
                              date: DateTime.now()),
                        );
                      },
                    ),
                  );
                }
              },
            ),
          ],
        ));
  }
}
