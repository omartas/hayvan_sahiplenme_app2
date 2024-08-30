import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/auth_controller.dart';
import '../models/donation_model.dart';
import 'login_screen.dart';

class DonationsPage extends StatelessWidget {
  final List<Donation> donations = [
    Donation(
      amount: 50,
      date: DateTime.now().subtract(Duration(days: 2)),
    ),
    Donation(
      amount: 100,
      date: DateTime.now().subtract(Duration(days: 10)),
    ),
    Donation(
      amount: 200,
      date: DateTime.now().subtract(Duration(days: 15)),
    ),
    Donation(
      amount: 50,
      date: DateTime.now().subtract(Duration(days: 2)),
    ),
    Donation(
      amount: 100,
      date: DateTime.now().subtract(Duration(days: 10)),
    ),
    Donation(
      amount: 200,
      date: DateTime.now().subtract(Duration(days: 15)),
    ),Donation(
      amount: 50,
      date: DateTime.now().subtract(Duration(days: 2)),
    ),
    Donation(
      amount: 100,
      date: DateTime.now().subtract(Duration(days: 10)),
    ),
    Donation(
      amount: 200,
      date: DateTime.now().subtract(Duration(days: 15)),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find<AuthController>();
    int totalDonationAmount = donations.fold(0, (sum, item) => sum + item.amount);
if (authController.user == null) {
          return Center(
            child: ElevatedButton(
                onPressed: () => Get.offAll(() => LoginScreen()),
                child: Text(" Lütfen Giris yap")),
          );
        }
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Yaptığım Bağışlar"),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: donations.length,
              itemBuilder: (context, index) {
                final donation = donations[index];
                return Card(
                  margin: EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: Icon(Icons.pets, size: 40), // Bağış ikonu
                    title: Text("Bağış: ${donation.amount} TL"),
                    subtitle: Text("Tarih: ${donation.date.toLocal().toString().replaceRange(19, null, "")}"),
                  ),
                );
              },
            ),
          ),
          Text("Toplam Yaptığınız Bağış: $totalDonationAmount TL", style: TextStyle(fontSize: 18)),

        ],
      ),
    );
  }
}
