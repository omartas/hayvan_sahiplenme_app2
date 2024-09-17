import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hayvan_sahiplenme_app2/screens/animal/animal_card.dart';
import 'animal_controller.dart';
import 'animal_detail_test_screen.dart';


class AnimalsScreen extends StatefulWidget {
  static final String shelterId = "shelter1"; 
  @override
  State<AnimalsScreen> createState() => _AnimalsScreenState();
}

class _AnimalsScreenState extends State<AnimalsScreen> {

 // Barınak ID'sini almak için
  String appBarTitle = "Atakum Belediyesi";

  @override
  Widget build(BuildContext context) {
    // AnimalController'ı al
    final AnimalController animalController = Get.put(AnimalController());

    // Barınak ID'sine göre hayvanları çek
    animalController.fetchAnimalsByShelterId(AnimalsScreen.shelterId);

    return Scaffold(
      appBar: AppBar(
        //leadingWidth: 100,
//**************************** */
        titleSpacing: 0,
        //leading: ClipRRect(borderRadius: BorderRadius.circular(50),child: Image.asset("assets/images/atakumbel.png",)),

        title: Row(
          children: [
            SizedBox(width: 25),
            Container(
                height: 50,
                width: 50,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: Image.asset(
                      "assets/images/atakumbel.png",
                    ))),
            SizedBox(width: 55),
            Text(appBarTitle),
          ],
        ),
        centerTitle: false,
      ),
      body:  AnimalsScreenWidget(animalController: animalController),
    );
  }

  String bulldogImg =
      "https://upload.wikimedia.org/wikipedia/commons/thumb/b/bf/Bulldog_inglese.jpg/640px-Bulldog_inglese.jpg";

  String kangalImg = "https://burvet.com/wp-content/uploads/2019/03/Kangal.jpg";

  String sokakImg =
      "https://cdn.img.anlatilaninotesi.com.tr/img/07e8/05/01/1083373717_512:0:2560:2048_1920x0_80_0_0_dd0e0478fb24709bb1983b87c94ae4bc.jpg";

  String goldenImg =
      "https://dogakopekuretim.com/wp-content/uploads/2021/06/golden-retriever-1.jpg";

  String almanImg =
      "https://www.guardiaturca.com/wp-content/uploads/german-shepherd-alman-kurdu-ozellikleri.jpg";

  String labradorImg =
      "https://www.petipet.net/uploads/2020/07/images-10-1-4.jpg";

  String pitbullImg =
      "https://trthaberstatic.cdn.wp.trt.com.tr/resimler/2020000/pitbull-kopek-aa-2020895.jpg";

  String goldenImg2 =
      "https://www.elityavru.com/images/irk-bilgileri/kopek-irki/golden-retriever.webp";
}

class AnimalsScreenWidget extends StatelessWidget {
  const AnimalsScreenWidget({
    super.key,
    required this.animalController,

  });

  final AnimalController animalController;


  @override
  Widget build(BuildContext context) {
    return Obx(() {
      // Hayvanları al ve listele
      if (animalController.animals.isEmpty) {
        return Center(child: CircularProgressIndicator());
      }
      return Padding(
        padding: EdgeInsets.only(top: 16,right: 8,left: 8),
        child: Column(
          children: [
            SearchBar(
              trailing: <Widget>[
                Tooltip(
                  message: 'Filtrele',
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.filter_list_alt),
                  ),
                )
              ],
              leading: IconButton(onPressed: () {}, icon: Icon(Icons.search)),
              hintText: "arama yapınız.",
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: animalController.animals.length,
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
                      imageUrl: animal.imageUrl.first ,
                      gender: animal.gender,
                      isNeutered: animal.isNeutered,
                      status: animal.status,
                      date: animal.date.toDate(),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      );
    });
  }
}
