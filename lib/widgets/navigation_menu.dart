import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/nav_controller.dart';
import '../screens/animals_screen.dart';
import '../screens/donate_screen.dart';
import '../screens/favorites_screen.dart';
import '../screens/home_screen.dart';
import '../screens/profile_screen.dart';


class NavigationMenu extends StatelessWidget {
  
  final NavController navController = Get.put(NavController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavBar(navController: navController),
      body: Obx(() {
        return _pages[navController.selectedIndex.value];
      }),
    );
  }
}







class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    super.key,
    required this.navController,
  });

  final NavController navController;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(  //OBX ile sarmala ya da setstate yap 
      currentIndex: navController.selectedIndex.value,
      onTap: (index) {
        navController.changeIndex(index);
      },
      items: ItemList,);
  }
}
final List<Widget> _pages = [
    DonateScreen(),
    AnimalsScreen(),
    HomeScreen(),
    //Center(child: Text("Home"),),
    FavoritesScreen(),
    ProfileScreen(),
  ];

  List<BottomNavigationBarItem> ItemList =[
          BottomNavigationBarItem(icon: Icon(Icons.card_giftcard,color: Colors.grey,), label: 'Donate',),
          BottomNavigationBarItem(icon: Icon(Icons.pets,color: Colors.grey), label: 'Animals'),
          BottomNavigationBarItem(icon: Icon(Icons.home,color: Colors.grey), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite,color: Colors.grey), label: 'Favorites'),
          BottomNavigationBarItem(icon: Icon(Icons.person,color: Colors.grey), label: 'Profile'),
        ];