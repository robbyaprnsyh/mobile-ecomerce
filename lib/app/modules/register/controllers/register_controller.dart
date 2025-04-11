import 'package:ecommerce/app/routes/app_pages.dart';
import 'package:ecommerce/app/utils/api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class RegisterController extends GetxController {
  final _getConnect = GetConnect();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordConfirmationController = TextEditingController();

  final authToken = GetStorage();

  void registerNow() async {
    final response = await _getConnect.post(
      BaseUrl.register,
      {
        'name': nameController.text,
        'email': emailController.text,
        'password': passwordController.text,
        'password_confirmation': passwordConfirmationController.text,
      },
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      authToken.write('token', response.body['token']);

      Get.snackbar(
        'Success',
        'Registrasi berhasil, silakan login.',
        backgroundColor: Colors.green,
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
        margin: const EdgeInsets.only(top: 10, left: 5, right: 5),
      );

      Future.delayed(const Duration(seconds: 2), () {
        if (Get.isRegistered<RegisterController>()) {
          Get.delete<RegisterController>();
        }
        Get.toNamed(Routes.LOGIN);
      });
    } else {
      Get.snackbar(
        'Error',
        response.body['error']?.toString() ?? 'Registrasi gagal',
        icon: const Icon(Icons.error),
        backgroundColor: Colors.red,
        colorText: Colors.white,
        margin: const EdgeInsets.only(top: 10, left: 5, right: 5),
      );
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    passwordConfirmationController.dispose();
    super.onClose();
  }
}
