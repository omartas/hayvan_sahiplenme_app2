import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hayvan_sahiplenme_app2/constans.dart';
import 'package:hayvan_sahiplenme_app2/screens/donate_screen.dart';
import '../../models/animal_model.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'adoption_form_page.dart';
class AnimalDetailTestScreen extends StatefulWidget {
  final AnimalModel animal;


  AnimalDetailTestScreen({required this.animal});

  @override
  State<AnimalDetailTestScreen> createState() => _AnimalDetailTestScreenState();
}

class _AnimalDetailTestScreenState extends State<AnimalDetailTestScreen> {
  final controller = PageController( keepPage: true);
  final List<String> imageUrls = [
    'https://st.depositphotos.com/1594920/2143/i/450/depositphotos_21432503-stock-photo-close-up-of-border-collie.jpg',
    'https://st.depositphotos.com/1594920/2143/i/450/depositphotos_21432503-stock-photo-close-up-of-border-collie.jpg',
    'https://st.depositphotos.com/1594920/2143/i/450/depositphotos_21432503-stock-photo-close-up-of-border-collie.jpg',

    //'https://via.placeholder.com/150',
  ];

  bool favoriOn = false;
  @override
  Widget build(BuildContext context) {
    var datePost = widget.animal.date
                            .toDate()
                            .toString()
                            .replaceRange(10, null, "");
    return Scaffold(
      body: Padding(
        padding: normalPadding32,
        child: Column(
          children: [
            // Image Slider
            ClipRRect(
              
              borderRadius: BorderRadius.all(Radius.circular(32)),
              child: SizedBox.fromSize(
                size: Size.fromRadius(
                    MediaQuery.sizeOf(context).width / 5 * 2),
                child: PageView.builder(
                  controller: controller,
                  itemCount: widget.animal.imageUrl.length,
                  itemBuilder: (context, index) {
                    return Image.network(
                      widget.animal.imageUrl[index],
                      fit: BoxFit.cover,
                    );
                  },
                ),
              ),
            ),
            SizedBox(height: 5,),
            SmoothPageIndicator(
                controller: controller,
                count: widget.animal.imageUrl.length,
                effect: const SwapEffect(
                  dotHeight: 8,
                  dotWidth: 8,
                  type: SwapType.normal,
                ),
              ),

            // Thumbnail Slider

            // Bottom curved container
            Expanded(
              child: Container(
                //color: backgroundColor,
                
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
                            IconButton(icon: favoriOn? Icon(Icons.favorite,
                                  color: pinkColor): Icon(Icons.favorite_border,color: pinkColor),
                              onPressed: () {
                                setState(() {
                                  favoriOn= !favoriOn;
                                });
                              },
                            ),
                            Text("Favorilere Ekle"),
                          ],
                        ),
                      ],
                    ),
                    PetText(petFeatureText: "İlan Tarihi", petFeature: datePost),
                    PetText(petFeatureText: "Pet ID", petFeature: widget.animal.id),
                    PetText(petFeatureText: "Cinsi", petFeature: widget.animal.breed),
                    PetText(petFeatureText: "Tür", petFeature: widget.animal.type),
                    PetText(petFeatureText: "Yaş", petFeature: widget.animal.age.toString()),
                    PetText(petFeatureText: "Cinsiyet", petFeature: widget.animal.gender),
                    PetText(petFeatureText: "Kısır", petFeature: widget.animal.isNeutered.toString()),
                    PetText(petFeatureText: "Status", petFeature: widget.animal.status),
                  
                    // Ekstra içerik buraya eklenebilir
                  ],
                ),
              ),
            ),
            Container(
              //color: backgroundColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: BlueButton(
                      text: "Mama Ver",
                      function: () {Get.to(DonateScreen(shelterName: "Atakum Belediyesi"));},
                    ),
                  ),
                  SizedBox(width: 15,),
                  Expanded(
                    child: BlueButton(
                      text: "Sahiplen",
                      function: () {
                        Get.to(() => AdoptionFormPage(animal: widget.animal,));
                      },
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
    return Container(  decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.black),
                ),
              ),child: Text('$petFeatureText: $petFeature',style: Theme.of(context).textTheme.bodyLarge,));
  }
}


