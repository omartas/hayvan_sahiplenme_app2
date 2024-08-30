import 'package:get/get.dart';

class NavController extends GetxController {
  var selectedIndex = 0.obs; // Default to Home screen
  void changeIndex(int index) {
    selectedIndex.value = index;
  }
}
