import 'package:flutter/material.dart';

// Renk Paleti Tanımları
class AppColors1 {
 static const Color primaryColor = Color(0xFF0D1A58); // Ana Renk (Koyu Mavi)
  static const Color secondaryColor = Color(0xFF1D3075); // İkincil Renk (Daha Açık Koyu Mavi)
  static const Color accentColor = Color(0xFF6A85B1); // Vurgu Rengi (Açık Mavi tonları)
  static const Color backgroundColor = Color(0xFFE6EBF5 ); // Açık Gri (Arka Plan Rengi)
  static const Color scaffoldBackgroundColor = Color(0xFFE6EBF5); // Beyaz (Genel Arka Plan)
  static const Color cardColor = Color(0xFFFFFFFF); // Kart Rengi
  static const Color errorColor = Color(0xFFB00020); // Hata Rengi (Kırmızı)
  static const Color textColor = Color(0xFF0D1A58); // Koyu Mavi (Metin Rengi)
  static const Color hintTextColor = Color(0xFF757575); // İpucu Metni (Gri)
}

// Uygulama Teması
ThemeData appTheme(BuildContext context) {
  return ThemeData(
    primaryColor: AppColors1.primaryColor,

    // ColorScheme Teması
    colorScheme: ColorScheme.light(
      primary: AppColors1.primaryColor,
      secondary: AppColors1.secondaryColor,
      background: AppColors1.backgroundColor,
      surface: AppColors1.cardColor,
      error: AppColors1.errorColor,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onBackground: AppColors1.textColor,
      onSurface: AppColors1.textColor,
      onError: Colors.white,
    ),
    scaffoldBackgroundColor: AppColors1.scaffoldBackgroundColor,
    //backgroundColor: AppColors.backgroundColor,
    cardColor: AppColors1.cardColor,

bottomNavigationBarTheme: BottomNavigationBarThemeData(
  selectedLabelStyle: TextStyle(fontSize: 12),
  unselectedLabelStyle: TextStyle(fontSize: 11),
  backgroundColor: AppColors1.primaryColor,
  unselectedItemColor:  AppColors1.accentColor,
  selectedItemColor: AppColors1.backgroundColor,
  ),
    // AppBar Teması
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors1.primaryColor,
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      iconTheme: IconThemeData(color: Colors.white),
      actionsIconTheme: IconThemeData(color: Colors.white),
      elevation: 4.0, // Gölgeleme yüksekliği
    ),

    // Metin Teması
    textTheme: TextTheme(
      displayLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: AppColors1.textColor),
      displayMedium: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: AppColors1.textColor),
      displaySmall: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors1.textColor),
      headlineMedium: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors1.textColor),
      headlineSmall: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors1.textColor),
      titleLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors1.textColor),
      bodyLarge: TextStyle(fontSize: 14, color: AppColors1.textColor),
      bodyMedium: TextStyle(fontSize: 12, color: AppColors1.textColor),
      labelLarge: TextStyle(fontSize: 12, color: AppColors1.hintTextColor),
      labelSmall: TextStyle(fontSize: 10, color: AppColors1.hintTextColor),
      titleMedium: TextStyle(fontSize: 14, color: AppColors1.textColor, fontWeight: FontWeight.bold),
    ),

    // Buton Temaları
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors1.secondaryColor,
        foregroundColor: Colors.white,
        textStyle: TextStyle(fontWeight: FontWeight.bold),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      ),
    ),

    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        backgroundColor: AppColors1.primaryColor,
        textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,color: AppColors1.cardColor),
      ),
    ),
    snackBarTheme: SnackBarThemeData(backgroundColor: AppColors1.accentColor),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        backgroundColor: AppColors1.primaryColor,
        side: BorderSide(color: AppColors1.primaryColor),
        textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    ),

    // Floating Action Button Teması
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColors1.primaryColor,
      foregroundColor: Colors.white,
      elevation: 4.0,
    ),

    // Kart Teması
    cardTheme: CardTheme(
      color: AppColors1.cardColor,
      shadowColor: Colors.black.withOpacity(0.2),
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
    ),

    // Giriş Teması
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      hintStyle: TextStyle(color: AppColors1.hintTextColor),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(color: AppColors1.primaryColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(color: AppColors1.primaryColor, width: 2.0),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(color: AppColors1.hintTextColor),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(color: AppColors1.errorColor),
      ),
      labelStyle: TextStyle(color: AppColors1.textColor),
      contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
    ),
    
    // Checkbox Teması
    checkboxTheme: CheckboxThemeData(
      fillColor: MaterialStateProperty.all(AppColors1.primaryColor),
      checkColor: MaterialStateProperty.all(Colors.white),
    ),

    // Radio Teması
    radioTheme: RadioThemeData(
      fillColor: MaterialStateProperty.all(AppColors1.primaryColor),
    ),

    // Slider Teması
    sliderTheme: SliderThemeData(
      activeTrackColor: AppColors1.primaryColor,
      inactiveTrackColor: AppColors1.accentColor,
      thumbColor: AppColors1.primaryColor,
      overlayColor: AppColors1.primaryColor.withOpacity(0.1),
    ),

    // Switch Teması
    switchTheme: SwitchThemeData(
      trackColor: MaterialStateProperty.all(AppColors1.accentColor),
      thumbColor: MaterialStateProperty.all(AppColors1.primaryColor),
    ),
    // Tooltip Teması
    tooltipTheme: TooltipThemeData(
      decoration: BoxDecoration(
        color: AppColors1.primaryColor.withOpacity(0.9),
        borderRadius: BorderRadius.circular(8.0),
      ),
      textStyle: TextStyle(color: Colors.white),
    ),

    // Progress Indicator Teması
    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: AppColors1.primaryColor,
      linearTrackColor: AppColors1.accentColor,
    ),

    // Divider Teması
    dividerTheme: DividerThemeData(
      color: AppColors1.hintTextColor,
      thickness: 1.0,
      space: 32.0,
    ),
  );
}
