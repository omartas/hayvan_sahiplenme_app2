import 'package:get/get.dart';

class NavController extends GetxController {
  var selectedIndex = 2.obs; // Default to Home screen
  void changeIndex(int index) {
    selectedIndex.value = index;
  }
}
