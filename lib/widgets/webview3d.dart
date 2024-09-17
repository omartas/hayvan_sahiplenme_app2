import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../models/payment_controller.dart';

class ThreeDSecurePage extends StatelessWidget {
  final String htmlContent;
  final PaymentController controller = Get.put(PaymentController());

  ThreeDSecurePage({required this.htmlContent});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('3D Secure Doğrulama')),
      body: Stack(
        children: [
          WebViewWidget(
            controller: WebViewController()
              ..setJavaScriptMode(JavaScriptMode.unrestricted)
              ..setNavigationDelegate(NavigationDelegate(
                onPageFinished: (String url) {
                  controller.onPageFinished(url);
                },
              ))
              ..loadHtmlString(htmlContent),
          ),
          Obx(() => controller.isLoading.value
              ? Center(child: CircularProgressIndicator())
              : SizedBox.shrink()),
        ],
      ),
    );
  }
}
