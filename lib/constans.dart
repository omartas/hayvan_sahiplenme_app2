import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Kullanacağımız api adresi
const String baseUrl = 'http://192.168.1.40:5000/api/';



  Color backgroundColor = const Color(0xfff2f0d5);
  //Color buttonColor = const Color(0xff3f403b);
  Color pinkColor = const Color(0xfff24162);
  Color whiteColor = Colors.white;
  Color blackColor = Colors.black;
  Color lilaColor = const Color(0xffa195a9);
  Color textColor = const Color(0xff5c5d55);
  Color darkBlueColor = const Color(0xff061E47);
  var normalPadding32 = EdgeInsets.all(32);
  var mediumPadding16 = EdgeInsets.all(16);
  var smallPadding8 = EdgeInsets.all(8);
  var ustveYan8 = EdgeInsets.only(left: 8,right: 8,top: 8);
    var defaultImageUrl =
        "https://mir-s3-cdn-cf.behance.net/project_modules/max_1200/65761296352685.5eac4787a4720.jpg";
    var defaultAppBarImage ="assets/images/atakumbel.png";




IconData twitter = IconData(0xe900, fontFamily: "CustomIcons");
IconData facebook = IconData(0xe901, fontFamily: "CustomIcons");
IconData googlePlus =
IconData(0xe902, fontFamily: "CustomIcons");
IconData linkedin = IconData(0xe903, fontFamily: "CustomIcons");

const kSpacingUnit = 10;

final kTitleTextStyle = TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.w600,
);

BoxDecoration avatarDecoration = BoxDecoration(
    shape: BoxShape.circle,
    color: backgroundColor,
    boxShadow: [
      BoxShadow(
        color: whiteColor,
        offset: Offset(10, 10),
        blurRadius: 10,
      ),
      BoxShadow(
        color: whiteColor,
        offset: Offset(-10, -10),
        blurRadius: 10,
      ),
    ]
);

class BlueButton extends StatelessWidget {
  const BlueButton({
    super.key,
    required this.function,
    required this.text, required this.enabled,
  });
  final VoidCallback function;
  final String text;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: function,
      child: Text(
        text,
        style: TextStyle(color: whiteColor),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: enabled ? Theme.of(context).primaryColor : Colors.grey,
          shape: StadiumBorder(),),
    );
  }
}

class AppColors {
  static const Color primaryColor = Color(0xFF2196F3); // Mavi (Primary)
  static const Color secondaryColor = Color(0xFF64B5F6); // Açık Mavi (Secondary)
  static const Color accentColor = Color(0xFFBBDEFB); // Pastel Mavi (Accent)
  static const Color backgroundColor = Color(0xFFE3F2FD); // Açık Mavi (Background)
  static const Color textColor = Color(0xFF0D47A1); // Koyu Mavi (Text)
}
bool validateCardNumber(String input) {
    if (input.length != 16) return false;
    return _luhnCheck(input); // Luhn algoritması ile kart numarasını doğrula
  }

  bool _luhnCheck(String cardNumber) {
    int sum = 0;
    bool alternate = false;
    for (int i = cardNumber.length - 1; i >= 0; i--) {
      int n = int.parse(cardNumber[i]);
      if (alternate) {
        n *= 2;
        if (n > 9) n -= 9;
      }
      sum += n;
      alternate = !alternate;
    }
    return (sum % 10 == 0);
  }

  bool validateExpiryDate(String input) {
    if (input.length != 5) return false;
    if (input[2] != '/') return false;

    final currentYear = DateTime.now().year % 100;
    final currentMonth = DateTime.now().month;

    final expiryMonth = int.tryParse(input.substring(0, 2));
    final expiryYear = int.tryParse(input.substring(3));

    if (expiryMonth == null || expiryYear == null) return false;

    if (expiryMonth < 1 || expiryMonth > 12) return false;

    if (expiryYear < currentYear ||
        (expiryYear == currentYear && expiryMonth < currentMonth)) {
      return false;
    }

    return true;
  }