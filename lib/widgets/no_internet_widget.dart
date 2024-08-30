import 'package:flutter/material.dart';

Widget buildNoInternetScreen(dynamic _checkConnectivity) {
    return Center(
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
            onPressed: _checkConnectivity,
            child: Text("Yeniden Dene"),
          ),
        ],
      ),
    );
  }
  