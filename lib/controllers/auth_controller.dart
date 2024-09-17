
import 'package:get/get.dart';
import 'package:hayvan_sahiplenme_app2/widgets/navigation_menu.dart';
import '../screens/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/api_service.dart';


class AuthController extends GetxController {
  final ApiService _apiService = ApiService();
  RxBool isLoggedIn = false.obs;
  RxString token = ''.obs;
  RxInt userId =0.obs;
  @override
  void onReady() {
    super.onReady();
    _checkLoginStatus();
  }

  void _checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token.value = prefs.getString('token') ?? '';
    if (token.isNotEmpty) {
      isLoggedIn.value = true;
      Get.offAll(() => NavigationMenu());
    } else {
      Get.offAll(() => const LoginScreen());
    }
  }

  void register( String name, String surname, String email, String password, String phoneNumber, String city, String district) async {
    final response = await _apiService.register(name, surname, email, password, phoneNumber, city, district);
    if (response != null) {
      login(email, password); // Kayıt başarılı ise otomatik olarak giriş yap
    } else {
      Get.snackbar('Error', 'Registration failed');
    }
  }
void login(String email, String password) async {
  print('Login function called');
  final apiService = ApiService();
  try {
    final response = await apiService.login(email, password);

    if (response != null && response.containsKey('data')) {
      final data = response['data'];

      if (data.containsKey('token')) {
        final String accessToken = data['token']['accessToken'];
        final String refreshToken = data['token']['refreshToken'];
        final int userId = data['user']['id'];
        
        // Token'ı SharedPreferences kullanarak saklayın
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', accessToken);
        await prefs.setString('refreshToken', refreshToken);
        await prefs.setInt('userId', userId);
        // AuthController içindeki token ve isLoggedIn değişkenlerini güncelleyin
        token.value = accessToken;
        isLoggedIn.value = true;

        // Başarılı giriş sonrası yönlendirme
        Get.offAll(() => NavigationMenu());

        print('Login successful! Token: $accessToken');
      } else {
        // Token bulunamadığında hata mesajı gösterin
        print('Failed to login: No access token found in response');
        Get.snackbar('Error', 'Failed to login: No access token found in response');
      }
    } else {
      // Response'ta data bulunamadığında hata mesajı gösterin
      print('Failed to login: No data found in response');
      Get.snackbar('Error', 'Failed to login: No data found in response');
    }
  } catch (e) {
    // Hata oluştuğunda hata mesajı gösterin
    print('Failed to login: ${e.toString()}');
    Get.snackbar('Error', 'Failed to login: ${e.toString()}');
  }
}


  void logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    token.value = '';
    isLoggedIn.value = false;
    Get.offAll(() => const LoginScreen());
  }
}


































// firebase işlemleri
/*
class AuthController extends GetxController {
  FirebaseAuth _auth = FirebaseAuth.instance;
  //late Rx<User?> _user;
  Rx<User?> _user = Rx<User?>(null);  
  User? get user => _user.value;

  @override
  void onReady() {
    super.onReady();
    _user.value = _auth.currentUser;
    //_user = Rx<User?>(_auth.currentUser);
    _user.bindStream(_auth.authStateChanges());
    ever(_user, _initialScreen);
  }

  _initialScreen(User? user) {
    if (user == null) {
      Get.offAll(() => LoginScreen());
    } else {
      Get.offAll(() => NavigationMenu());
    }
  }

  void register(String email, String password, String name) async {
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
      await _auth.currentUser!.updateDisplayName(name);
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  void login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  void logout() async {
    await _auth.signOut();
  }
}
*/