import 'package:ecommerce/app/modules/dashboard/views/dashboard_view.dart';
import 'package:ecommerce/app/utils/api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LoginController extends GetxController {
  final _getConnect = GetConnect();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final authToken = GetStorage();

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  void loginNow() async {
    final response = await _getConnect.post(
      BaseUrl.login,
      {
        'email': emailController.text,
        'password': passwordController.text,
      },
    );

    if (response.statusCode == 200) {
      authToken.write('auth_token', response.body['access_token']);
      authToken.write('user_id', response.body['user']['id']);
      Get.offAll(() => const DashboardView());
    } else {
      Get.snackbar(
        'Error',
        response.body['error'].toString(),
        icon: const Icon(Icons.error),
        backgroundColor: Colors.red,
        colorText: Colors.white,
        forwardAnimationCurve: Curves.bounceIn,
        margin: const EdgeInsets.only(top: 10, left: 5, right: 5),
      );
    }
  }
}
