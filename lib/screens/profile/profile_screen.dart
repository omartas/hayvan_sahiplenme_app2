
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hayvan_sahiplenme_app2/screens/my_adopted_animals_screen.dart';
import 'package:hayvan_sahiplenme_app2/screens/my_donations_page_screen.dart';
import 'package:hayvan_sahiplenme_app2/screens/profile/profile_menu_widget.dart';
import 'package:hayvan_sahiplenme_app2/screens/profile/settings/locataion_selection_page.dart';
import 'package:hayvan_sahiplenme_app2/theme.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import '../../../controllers/auth_controller.dart';
import '../login_screen.dart';
import 'package:hayvan_sahiplenme_app2/constans.dart';



class ProfileScreen extends StatelessWidget {
  static const double tDefaultSize = 5;
  static const String profileImage ="https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png";
  static const String profileHeading = "Ad";
  static const String profileSubHeading = "Mail";
  static const String editProfile = "Profili Düzenle";



  @override
  Widget build(BuildContext context) {
    //final UserController userController = Get.put(UserController());
    final AuthController authController = Get.find<AuthController>();
    var userEmail = authController.user?.email;

    return Scaffold(
      appBar: AppBar(title: Text('Profil'),centerTitle: true,),
      body: Obx(() {
        if (authController.user == null) {
          return Center(
            child: ElevatedButton(
                onPressed: () => Get.offAll(() => LoginScreen()),
                child: Text(" Lütfen Giris yap")),
          );
        }
        return SingleChildScrollView(
            child: Container(
          padding: normalPadding32,
          child: Column(
            children: [
              /// -- IMAGE
              Stack(
                children: [
                  SizedBox(
                    width: 120,
                    height: 120,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: const Image(image: NetworkImage(profileImage))),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: appTheme(context).primaryColor),
                      child: Icon(
                        LineAwesomeIcons.pencil_alt_solid,
                        color: whiteColor,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(profileHeading,
                  style: Theme.of(context).textTheme.headlineMedium),
              Text(userEmail??"",
                  style: Theme.of(context).textTheme.bodyMedium),
              const SizedBox(height: 20),

              /// -- BUTTON
              SizedBox(
                width: 200,
                child: ElevatedButton(
                  onPressed:
                      () {}, //=> Get.to(() => const UpdateProfileScreen()),
                  style: ElevatedButton.styleFrom(
                      
                      side: BorderSide.none,
                      shape: const StadiumBorder()),
                  child: Text(editProfile,
                      style: TextStyle(color: whiteColor)),
                ),
              ),
              const SizedBox(height: 30),
              const Divider(),
              const SizedBox(height: 10),

              /// -- MENU
              ProfileMenuWidget(
                  title: "Ayarlar",
                  icon: LineAwesomeIcons.cog_solid,
                  onPress: () {Get.to(LocationSelectionPage());}),
              ProfileMenuWidget(
                  title: "Sahiplendiklerim",
                  icon: LineAwesomeIcons.wallet_solid,
                  onPress: () {Get.to(AdoptedAnimalsPage());}),
              ProfileMenuWidget(
                  title: "Bağışlarım",
                  icon: LineAwesomeIcons.donate_solid,
                  onPress: () {Get.to(DonationsPage());}),
              const Divider(),
              const SizedBox(height: 10),
              ProfileMenuWidget(
                  title: "Bilgi",
                  icon: LineAwesomeIcons.info_solid,
                  onPress: () {}),
              ProfileMenuWidget(
                  title: "Çıkış Yap",
                  icon: LineAwesomeIcons.sign_out_alt_solid,
                  textColor: Colors.red,
                  endIcon: false,
                  onPress: () {
                    Get.defaultDialog(
                      title: "LOGOUT",
                      titleStyle: const TextStyle(fontSize: 20),
                      content: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 15.0),
                        child: Text("Are you sure, you want to Logout?"),
                      ),
                      confirm: Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            // Kullanıcı çıkışı
                            authController.logout();
                            Get.offAll(() =>LoginScreen()); // Kullanıcıyı giriş ekranına yönlendir
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.redAccent,
                              side: BorderSide.none),
                          child: const Text("Yes"),
                        ),
                      ),
                      cancel: OutlinedButton(
                          onPressed: () => Get.back(), child: const Text("No")),
                    );
                  }),
            ],
          ),
        ));
      }),
    );
  }
}
