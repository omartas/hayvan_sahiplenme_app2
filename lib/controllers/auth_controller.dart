import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:hayvan_sahiplenme_app2/widgets/navigation_menu.dart';

import '../screens/login_screen.dart';

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
