import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/feeding_controller.dart';

class FeedingsPage extends StatelessWidget {
  final FeedingController feedingController = Get.put(FeedingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mama Bağışlarım'),
        centerTitle: true,
        
      ),
      body: FutureBuilder<List<dynamic>>(
        future: feedingController.fetchFeedings(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Bir hata oluştu: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Hiç bağış bulunamadı.'));
          } else {
            final feedings = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView.builder(
                itemCount: feedings.length,
                itemBuilder: (context, index) {
                  final feeding = feedings[index];
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /// Pet İkonu veya resmi
                          CircleAvatar(
                            radius: 30,
                            child: Icon(
                              Icons.pets,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                          SizedBox(width: 16),

                          /// Bağış Detayları
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Bağış ID: ${feeding['id']}',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  'Pet ID: ${feeding["petID"]}',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey[700],
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  "Tarih: ${feeding["createdAt"].toString().replaceRange(10, null, "")}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.blueGrey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 16),

                          /// Tarih ve İlerleme Simgesi
                          Icon(
                            Icons.check_circle,
                            
                            size: 32,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}


















/*
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/feeding_controller.dart';

class FeedingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final FeedingController feedingController = Get.put(FeedingController());

    return Scaffold(
      appBar: AppBar(title: Text('Mama Bağışlarım'),centerTitle: true,),
      body: Obx(() {
        if (feedingController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else if (feedingController.errorMessage.isNotEmpty) {
          return Center(child: Text(feedingController.errorMessage.value));
        } else {
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: feedingController.startedFeedings.length,
                  itemBuilder: (context, index) {
                    final feeding = feedingController.startedFeedings[index];
                    return Card(
                      margin: EdgeInsets.all(12.0),
                      child: ListTile(
                        leading: Icon(Icons.pets, size: 40), // Bağış ikonu
                        title: Text('Mama Bağışı ID: ${feeding['id']}'),
                        subtitle: Text('Pet ID: ${feeding["petID"]}'),
                        trailing: Text("Tarih: ${feeding["createdAt"].toString().replaceRange(10, null, "")}"),
                      ),
                    );
                  },
                ),
              ),
              
            ],
          );
        }
      }),
    );
  }
}

*/