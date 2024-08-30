import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hayvan_sahiplenme_app2/constans.dart';
import 'package:hayvan_sahiplenme_app2/theme.dart';
import 'package:hayvan_sahiplenme_app2/widgets/navigation_menu.dart';
import 'controllers/animal_controller.dart';
import 'controllers/auth_controller.dart';
import 'screens/login_screen.dart';
import 'screens/no_internet_screen.dart';
import 'utils/connectivity_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  //Get.put(NavController());
  Get.put(AnimalController());
  Get.put(AuthController());
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final ConnectivityService _connectivityService = ConnectivityService();
  ConnectivityResult? _connectivityResult;

  @override
  void initState() {
    super.initState();
    _connectivityService.connectivityStream.listen((ConnectivityResult result) {
      setState(() {
        _connectivityResult = result;
      });
    });
    _checkInitialConnectivity();
  }

  Future<void> _checkInitialConnectivity() async {
    bool isConnected = await _connectivityService.checkConnectivity();
    setState(() {
      _connectivityResult = isConnected ? ConnectivityResult.wifi : ConnectivityResult.none;
    });
  }
  @override
  Widget build(BuildContext context) {
   
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pet Adoption App',
      theme: appTheme(context),
      home: _connectivityResult == ConnectivityResult.none
          ? NoInternetScreen()
          : InitialScreen(),
    );
  }

  ThemeData newMethodThemeData() {
    return ThemeData(
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: AppColors.primaryColor,

      ),
      // Ana renk
      primaryColor: AppColors.primaryColor, // Yeşil
      primaryColorLight: AppColors.accentColor,
      
      scaffoldBackgroundColor: AppColors.backgroundColor,

      // Vurgu rengi (Artık accentColor yerine colorScheme kullanılıyor)
      colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Color(0xFF1F4591)), // Turuncu

      // Arka plan renkleri (Scaffold background color doğru parametre adı)
      
      // Metin temaları
      textTheme: TextTheme(

        bodyLarge: TextStyle(color: Color(0xFF212121), fontSize: 18), // bodyText1 yerine bodyLarge
        bodyMedium: TextStyle(color: Color(0xFF212121), fontSize: 16), // bodyText2 yerine bodyMedium
        titleLarge: TextStyle(color: pinkColor, fontWeight: FontWeight.bold), // headline6 yerine titleLarge
      ),

      // Buton temaları
      buttonTheme: ButtonThemeData(
        
        buttonColor: const Color(0xff1F4591), 
        textTheme: ButtonTextTheme.primary,
      ),
      iconTheme: IconThemeData(color: Color(0xFF68A4F1)),



      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.secondaryColor,
          //overlayColor: AppColors.secondaryColor,
          //onPrimary: Colors.white,
          textStyle: TextStyle(fontWeight: FontWeight.bold),
        ),),
      // AppBar teması
      appBarTheme: AppBarTheme(
        color: AppColors.primaryColor, // Ana renk
        iconTheme: IconThemeData(color: Colors.white),
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
      ),
      primarySwatch: Colors.blue,
    );
  }
}

class InitialScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
      Center(child: CircularProgressIndicator());

    return Obx(() {
      return Get.find<AuthController>().user != null ? NavigationMenu() : LoginScreen();
    });
  }
}
