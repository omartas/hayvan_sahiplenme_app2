import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hayvan_sahiplenme_app2/controllers/user_controller.dart';
import 'package:hayvan_sahiplenme_app2/payment/3dsecure_payment_screen.dart';
import 'package:hayvan_sahiplenme_app2/oldPages/my_donations_page_screen.dart';
import 'package:hayvan_sahiplenme_app2/screens/Municipality/municipality_screen.dart';
import 'package:hayvan_sahiplenme_app2/screens/profile/profile_menu_widget.dart';
import 'package:hayvan_sahiplenme_app2/screens/profile/settings/locataion_selection_page.dart';
import 'package:hayvan_sahiplenme_app2/services/get_cities.dart';
import 'package:hayvan_sahiplenme_app2/theme.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import '../../../controllers/auth_controller.dart';
import '../../oldPages/my_adopted_animals_screen.dart';
import '../../services/api_service.dart';
import '../../oldPages/animals_screen.dart';
import '../login_screen.dart';
import 'package:hayvan_sahiplenme_app2/constans.dart';

class ProfileScreen extends StatelessWidget {
  static const double tDefaultSize = 5;
  static const String profileImage =
      "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png";
  static const String profileHeading = "Ad";
  static const String profileSubHeading = "Mail";
  static const String editProfile = "Profili Düzenle";

  final ApiService apiService = ApiService();
  final AuthController authController = Get.find<AuthController>();
  final UserController userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    var user = userController.user.value;
    return Scaffold(
      appBar: AppBar(
        title: Text('Profil'),
        centerTitle: true,
      ),
      body: Obx(() {
        
        if (userController.isLoading.value) {
          return Center(child: CircularProgressIndicator()); // Yükleniyor durumu
        } else if (userController.errorMessage.isNotEmpty) {
          return Center(child: Column(
            children: [
              Text(userController.errorMessage.value),
              _logout(),
            ],
          )); // Hata durumu
        } else if (userController.user.value != null) {
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
                            child: Image.network(profileImage),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            width: 35,
                            height: 35,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: appTheme(context).primaryColor,
                            ),
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
                    Text(
                      '${user.name} ${user.surname}',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    Text(user.email, style: Theme.of(context).textTheme.bodyMedium),
                    Text(user.district.name, style: Theme.of(context).textTheme.bodyMedium),

                    const SizedBox(height: 30),
                    const Divider(),
                    const SizedBox(height: 10),

                    /// -- MENU
                    ProfileMenuWidget(
                      title: "Ayarlar",
                      icon: LineAwesomeIcons.cog_solid,
                      onPress: () {
                        Get.to(LocationSelectionPage());
                      },
                    ),
                    ProfileMenuWidget(
                      title: "Sahiplendiklerim",
                      icon: LineAwesomeIcons.wallet_solid,
                      onPress: () {
                        Get.to(AdoptedAnimalsPage());
                      },
                    ),
                    ProfileMenuWidget(
                      title: "Bağışlarım",
                      icon: LineAwesomeIcons.donate_solid,
                      onPress: () {
                        Get.to(DonationsPage());
                      },
                    ),
                    ProfileMenuWidget(
                      title: "Gönderiler",
                      icon: LineAwesomeIcons.stream_solid,
                      onPress: () {
                        Get.to(AnimalsScreen());
                      },
                    ),
                    const Divider(),
                    const SizedBox(height: 10),
                    ProfileMenuWidget(
                      title: "Bilgi",
                      icon: LineAwesomeIcons.info_solid,
                      onPress: () {
                        //Get.to(() => CitiesScreen());
                      },
                    ),
                    ProfileMenuWidget(
                      title: "Belediye",
                      icon: LineAwesomeIcons.info_solid,
                      onPress: () {
                        Get.to(() => MunicipalityScreen());
                      },
                    ),
                    ProfileMenuWidget(
                      title: "Ödeme Yap",
                      icon: LineAwesomeIcons.paypal,
                      onPress: () {
                        Get.to(() => PaymentPage());
                      },
                    ),
                    _logout(),
                  ],
                ),
              ),
            );
        } else {
          return Text('Kullanıcı bilgisi bulunamadı'); // Boş veri durumu
        }
      }),
      
      
      
    );
  }

  ProfileMenuWidget _logout() {
    return ProfileMenuWidget(
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
            child: Text("Çıkış yapmak istediğinize emin misiniz?"),
          ),
          confirm: Expanded(
            child: ElevatedButton(
              onPressed: () {
                authController.logout();
                Get.offAll(() => LoginScreen());
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                side: BorderSide.none,
              ),
              child: const Text("Evet"),
            ),
          ),
          cancel: OutlinedButton(
            onPressed: () => Get.back(),
            child: const Text("Hayır"),
          ),
        );
      },
    );
  }
}
