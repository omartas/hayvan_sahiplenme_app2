// lib/screens/no_internet_screen.dart
import 'package:flutter/material.dart';

class NoInternetScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Bağlantı Hatası")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.wifi_off, size: 100, color: Colors.red),
            SizedBox(height: 16),
            Text(
              "İnternet bağlantısı yok!",
              style: TextStyle(fontSize: 24, color: Colors.red),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Uygulamayı yeniden başlatabilir veya bağlantıyı tekrar kontrol edebilirsiniz.
              },
              child: Text("Yeniden Dene"),
            ),
          ],
        ),
      ),
    );
  }
}
