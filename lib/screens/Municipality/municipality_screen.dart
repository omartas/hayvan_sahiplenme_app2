import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hayvan_sahiplenme_app2/constans.dart';
import 'municipality_controller.dart';

class MunicipalityScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final MunicipalityController municipalityController =
        Get.put(MunicipalityController());

    return Scaffold(
      appBar: AppBar(
        title: Obx(() {
          return municipalityController.isLoading.value
              ? Text("Belediye Bilgisi")
              : Text(municipalityController.municipality.value.name);
        }),
        centerTitle: true,
      ),
      body: Obx(() {
        if (municipalityController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else if (municipalityController.errorMessage.isNotEmpty) {
          return Center(child: Text(municipalityController.errorMessage.value));
        } else {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Belediye Bilgisi
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          leading: CircleAvatar(
                            radius: 30,
                            backgroundImage: municipalityController
                                        .municipality.value.logo !=
                                    null
                                ? NetworkImage(
                                    municipalityController.municipality.value.logo!)
                                : AssetImage(defaultAppBarImage)
                                    as ImageProvider,
                          ),
                          title: Text(
                            municipalityController.municipality.value.name,
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                              '${municipalityController.municipality.value.city.name}, ${municipalityController.municipality.value.district.name}'),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'İletişim Bilgileri',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            Icon(Icons.email, color: Colors.blueAccent),
                            SizedBox(width: 8),
                            Text(municipalityController.municipality.value.email),
                          ],
                        ),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(Icons.phone, color: Colors.green),
                            SizedBox(width: 8),
                            Text(municipalityController
                                .municipality.value.phoneNumber),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),

                /// Barınak Bilgisi
                Text(
                  'Barınaklar',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Expanded(
                  child: ListView.builder(
                    itemCount: municipalityController
                        .municipality.value.shelters.length,
                    itemBuilder: (context, index) {
                      final shelter = municipalityController
                          .municipality.value.shelters[index];

                      return Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        margin: EdgeInsets.symmetric(vertical: 8),
                        child: ListTile(
                          leading: Icon(
                            Icons.home,
                            size: 40,
                            color: Colors.orange,
                          ),
                          title: Text(shelter.name),
                          subtitle: Text(shelter.address),
                          trailing: Icon(Icons.arrow_forward_ios, size: 16),
                          onTap: () {
                            // Barınağa tıklanınca detay sayfasına gitmek için
                            // Detay sayfası daha sonra eklenebilir.
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        }
      }),
    );
  }
}
