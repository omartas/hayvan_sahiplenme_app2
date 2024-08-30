import 'package:flutter/material.dart';

class PaymentTexts extends StatelessWidget {
  const PaymentTexts({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Ödeme Bilgilerini Girin",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8.0),
        TextFormField(
          decoration: InputDecoration(labelText: "Kart Numarası"),
          keyboardType: TextInputType.number,
          maxLength: 16,
        ),
        TextFormField(
          decoration: InputDecoration(labelText: "Son Kullanma Tarihi"),
          keyboardType: TextInputType.datetime,
        ),
        SizedBox(height: 8.0),
        TextFormField(
          decoration: InputDecoration(labelText: "CVV"),
          keyboardType: TextInputType.number,
          obscureText: true,
        ),
      ],
    );
  }
}