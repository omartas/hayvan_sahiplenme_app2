import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hayvan_sahiplenme_app2/models/animal_model_api.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../constans.dart';
import '../../controllers/favourite_animal_controller.dart';
import '../adoption_screen.dart';
import '../donate_screen.dart'; // Mama verme ekranı import

class AnimalDetailApiScreen extends StatefulWidget {
  final AnimalModelApi animal;

  AnimalDetailApiScreen({required this.animal});

  @override
  State<AnimalDetailApiScreen> createState() => _AnimalDetailApiScreenState();
}

class _AnimalDetailApiScreenState extends State<AnimalDetailApiScreen> {
  final controller = PageController(keepPage: true);

  final FavoritesController favoritesController = Get.find();

  @override
  Widget build(BuildContext context) {
    var petId = widget.animal.id;
    favoritesController.isFavorite.value =
        favoritesController.checkIfFavorite(petId);
    bool isFavorite =
        favoritesController.favoritePets.any((fav) => fav['petID'] == petId);

    // Resim listesi API'den gelen 'pictures' alanını kullanacak
    final List<String> imageUrls = widget.animal.pictures.isNotEmpty
        ? widget.animal.pictures
        : [
            "https://mir-s3-cdn-cf.behance.net/project_modules/max_1200/65761296352685.5eac4787a4720.jpg"
          ]; // Resim yoksa varsayılan bir resim göster

    // Tarihi formatlayalım (API'den gelen tarih formatı string)
    var datePost = widget.animal.createdAt.substring(0, 10);

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(32.0),
        child: Column(
          children: [
            // Image Slider
            ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(32)),
              child: SizedBox.fromSize(
                size: Size.fromRadius(MediaQuery.sizeOf(context).width / 5 * 2),
                child: PageView.builder(
                  controller: controller,
                  itemCount: imageUrls.length,
                  itemBuilder: (context, index) {
                    return Image.network(
                      imageUrls[index],
                      fit: BoxFit.cover,
                    );
                  },
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            SmoothPageIndicator(
              controller: controller,
              count: imageUrls.length,
              effect: const SwapEffect(
                dotHeight: 8,
                dotWidth: 8,
                type: SwapType.normal,
              ),
            ),
            Expanded(
              child: Container(
                child: ListView(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.animal.name,
                          style: Theme.of(context).textTheme.displayMedium,
                        ),
                        Column(
                          children: [
                            Obx(() => IconButton(
                                  icon: Icon(
                                    favoritesController.isFavorite.value
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    color: Colors.pink,
                                  ),
                                  onPressed: () async {
                                    if (favoritesController.isFavorite.value) {
                                      // Favorilerden çıkar
                                      await favoritesController
                                          .removeFromFavorites(petId);
                                    } else {
                                      // Favorilere ekle
                                      await favoritesController
                                          .addToFavorites(petId);
                                    }

                                    // Favori durumu değiştir
                                    favoritesController.isFavorite.toggle();

                                    // Favori listesi ve UI'ı güncelle
                                    await favoritesController.fetchFavorites();
                                  },
                                )),
                            Text("Favorilere Ekle"),
                          ],
                        ),
                      ],
                    ),
                    PetText(
                        petFeatureText: "İlan Tarihi", petFeature: datePost),
                    PetText(
                        petFeatureText: "Pet ID",
                        petFeature: widget.animal.id.toString()),
                    PetText(
                        petFeatureText: "Cinsi",
                        petFeature: widget.animal.genus?.name??""),
                    PetText(
                        petFeatureText: "Tür",
                        petFeature: widget.animal.type?.name??""),
                    PetText(
                        petFeatureText: "Yaş",
                        petFeature: widget.animal.age.toString()),
                    PetText(
                      petFeatureText: "Cinsiyet",
                      petFeature:
                          widget.animal.gender == 'female' ? 'Dişi' : 'Erkek',
                    ),
                    PetText(
                        petFeatureText: "Kısır",
                        petFeature:
                            widget.animal.isNeutered ? "Evet" : "Hayır"),
                    PetText(
                        petFeatureText: "Sahiplendirilmiş mi",
                        petFeature: widget.animal.adopted ? "Evet" : "Hayır"),
                    PetText(
                        petFeature: widget.animal.adoption.toString(),
                        petFeatureText: "Adoption")
                  ],
                ),
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: BlueButton(
                        text: "Mama Ver",
                        function: widget.animal.feed
                            ? () {
                                Get.to(DonateScreen(
                                  shelterName: "Atakum Belediyesi",
                                  animal: widget.animal,
                                ));
                              }
                            : () {
                                Get.snackbar("Uyarı",
                                    "Bu hayvanımız şuan da beslemeye kapalıdır.");
                              },
                        enabled: widget.animal.feed),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: BlueButton(
                      text: "Sahiplen",
                      function: widget.animal.adoption
                          ? () {
                              Get.to(() =>
                                  AdoptionFormPage(animal: widget.animal));
                            }
                          : () {
                              Get.snackbar("Uyarı",
                                  "Bu hayvanımız şuan da sahiplendirmeye kapalıdır.");
                            },
                      enabled: widget.animal.adoption,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class PetText extends StatelessWidget {
  const PetText({
    super.key,
    required this.petFeature,
    required this.petFeatureText,
  });

  final String petFeature;
  final String petFeatureText;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.black),
          ),
        ),
        child: Text(
          '$petFeatureText: $petFeature',
          style: Theme.of(context).textTheme.bodyLarge,
        ));
  }
}
