import 'package:get/get.dart';

class PaymentController extends GetxController {
  var isLoading = true.obs;

  // WebView tamamlandığında çağrılır
  void onPageFinished(String url) {
    isLoading(false);

    // Başarılı ödeme için 'success' içeren URL kontrol edilir
    if (url.contains('success')) {
      Get.snackbar("Başarılı", "Ödeme başarıyla gerçekleşti");
      Get.back();  // Önceki sayfaya geri dön
    } else if (url.contains('failure')) {
      Get.snackbar("Başarısız", "Ödeme başarısız oldu");
      Get.back();  // Önceki sayfaya geri dön
    }
  }
}
