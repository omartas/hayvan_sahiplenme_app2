import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/adoption_controller.dart';

class MyAdoptionsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AdoptionController adoptionController = Get.put(AdoptionController());

    return Scaffold(
      appBar: AppBar(
        title: Text('Sahiplenilen Hayvanlar'),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: adoptionController.fetchAdoptions(), // API'yi çağıran fonksiyon
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Hata: ${snapshot.error}'));
          }  else {
            return ListView(
              children: [
                // Başlanan Sahiplenmeler
                Card(
                  child: ExpansionTile(
                    title: Text(
                        'Başlanan Sahiplenmeler (${adoptionController.startedAdoptions.length})'),
                    children:
                        adoptionController.startedAdoptions.map((adoption) {
                      return Card(
                        child: ListTile(
                          leading: CircleAvatar(),
                          title: Text('Hayvan ID : ${adoption['id']}'),
                          subtitle: Text('Durum: Başlandı'),
                          trailing: _buildAdoptionStatus("${adoption["status"]}"),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                
                // Onaylanan Sahiplenmeler
                Card(
                  child: ExpansionTile(
                    title: Text(
                        'Onaylanan Sahiplenmeler (${adoptionController.approvedAdoptions.length})'),
                    children:
                        adoptionController.approvedAdoptions.map((adoption) {
                      return Card(
                        child: ListTile(
                          leading: CircleAvatar(
                            radius: 30,
                            backgroundImage: adoption["pets"]["pictures"]
                                    .isNotEmpty
                                ? NetworkImage(adoption["pets"]["pictures"][0])
                                : NetworkImage(
                                    'https://via.placeholder.com/150'), // Varsayılan resim
                          ),
                          title: Text('${adoption['pets']["name"]}'),
                          subtitle: Text('${adoption['pets']["type"]["name"]}'),
                          trailing: _buildAdoptionStatus("${adoption["status"]}"),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                
                // Reddedilen Sahiplenmeler
                Card(
                  child: ExpansionTile(
                    title: Text(
                        'Reddedilen Sahiplenmeler (${adoptionController.rejectedAdoptions.length})'),
                    children:
                        adoptionController.rejectedAdoptions.map((adoption) {
                      return ListTile(
                        title: Text('Hayvan ID: ${adoption['id']}'),
                        subtitle: Text('Durum: Reddedildi'),
                        trailing: _buildAdoptionStatus("${adoption["status"]}"),
                      );
                    }).toList(),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}

// Sahiplenme Durumu Chip'leri
Widget _buildAdoptionStatus(String status) {
  Color statusColor;

  switch (status) {
    case "approved":
      status = "Onaylandı";
      statusColor = Colors.green;
      break;
    case "started":
      status = "Bekleniyor";
      statusColor = Colors.orange;
      break;
    case "rejected":
      status = "Reddedildi";
      statusColor = Colors.red;
      break;
    default:
      statusColor = Colors.grey;
  }

  return Chip(
    label: Text(
      status,
      style: TextStyle(color: Colors.white),
    ),
    backgroundColor: statusColor,
  );
}
