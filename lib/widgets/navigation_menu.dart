import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hayvan_sahiplenme_app2/screens/adoption_posts_screen.dart';
import 'package:hayvan_sahiplenme_app2/screens/favorites_screen.dart';
import 'package:hayvan_sahiplenme_app2/screens/my_adoptions_page.dart';
import 'package:hayvan_sahiplenme_app2/screens/my_feedings.dart';
import '../controllers/nav_controller.dart';
import '../screens/favorites_screen.dart';
import '../screens/profile/profile_screen.dart';


class NavigationMenu extends StatefulWidget {
  
  @override
  State<NavigationMenu> createState() => _NavigationMenuState();
}

class _NavigationMenuState extends State<NavigationMenu> {
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


class BottomNavBar extends StatefulWidget {
  const BottomNavBar({
    super.key,
    required this.navController,
  });

  final NavController navController;

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(  //OBX ile sarmala ya da setstate yap 
      currentIndex: widget.navController.selectedIndex.value,
      type: BottomNavigationBarType.fixed,

      onTap: (index) {
        setState(() {
        widget.navController.changeIndex(index);
          
        });
      },
      items: ItemList,);
  }
}
final List<Widget> _pages = [
  AdoptionPostsPage(),
    //AnimalsScreen(),
    FeedingsPage(),
    //FavoritesScreen(),
    FavoritesTestScreen(),
    MyAdoptionsPage(),
    //LoginPage(),
    ProfileScreen(),
  ];

  List<BottomNavigationBarItem> ItemList =[
          BottomNavigationBarItem(icon: Icon(Icons.home,), label: 'Ana Sayfa'),
          BottomNavigationBarItem(icon: Icon(Icons.payment_rounded),label: "Bağışlarım"),
          BottomNavigationBarItem(icon: Icon(Icons.favorite,), label: 'Favoriler'),
          BottomNavigationBarItem(icon: Icon(Icons.home_work),label: "Sahiplenme"),
          BottomNavigationBarItem(icon: Icon(Icons.person,), label: 'Profil'),
        ];