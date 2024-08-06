import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../models/user_model.dart';

class UserController extends GetxController {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var user = UserModel(uid: '', email: '', name: '').obs;

  @override
  void onInit() {
    super.onInit();
    fetchUser();
  }

  void fetchUser() async {
    try {
      // Firebase Authentication'dan mevcut kullanıcıyı al
      var currentUser = FirebaseAuth.instance.currentUser;

      if (currentUser != null) {
        // Firestore'dan kullanıcı bilgilerini al
        var userData = await _firestore.collection('users').doc(currentUser.uid).get();
        user.value = UserModel.fromMap(userData.data()!);
      }
    } catch (e) {
      print("Error fetching user: $e");
    }
  }
}
