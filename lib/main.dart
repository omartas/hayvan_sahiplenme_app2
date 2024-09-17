import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hayvan_sahiplenme_app2/theme.dart';
import 'package:hayvan_sahiplenme_app2/widgets/navigation_menu.dart';
import 'controllers/favourite_animal_controller.dart';
import 'oldPages/animal_controller.dart';
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
  Get.put(FavoritesController());
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
}

class InitialScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
      Center(child: CircularProgressIndicator());

    return Obx(() {
      return Get.find<AuthController>().isLoggedIn.value ? NavigationMenu() : LoginScreen();
    });
  }
}
