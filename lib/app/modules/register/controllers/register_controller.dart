import 'package:ecommerce/app/routes/app_pages.dart';
import 'package:ecommerce/app/utils/api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class RegisterController extends GetxController {
  final _getConnect = GetConnect();

  final isPasswordHidden = true.obs;
  final isPasswordConfirmationHidden = true.obs;

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordConfirmationController = TextEditingController();

  final authToken = GetStorage();

  void registerNow() async {
    final name = nameController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text;
    final confirmPassword = passwordConfirmationController.text;

    // Validasi field kosong
    if (name.isEmpty || email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      Get.snackbar(
        'Error',
        'Semua field harus diisi.',
        icon: const Icon(Icons.warning, color: Colors.white),
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.orange.shade600,
        colorText: Colors.white,
        borderRadius: 12,
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        padding: const EdgeInsets.all(16),
        duration: const Duration(seconds: 3),
        isDismissible: true,
        forwardAnimationCurve: Curves.easeOutBack,
      );
      return;
    }

    // Validasi format email
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(email)) {
      Get.snackbar(
        'Error',
        'Format email tidak valid.',
        icon: const Icon(Icons.warning, color: Colors.white),
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.orange.shade600,
        colorText: Colors.white,
        borderRadius: 12,
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        padding: const EdgeInsets.all(16),
        duration: const Duration(seconds: 3),
        isDismissible: true,
        forwardAnimationCurve: Curves.easeOutBack,
      );
      return;
    }

    // Validasi konfirmasi password
    if (password != confirmPassword) {
      Get.snackbar(
        'Error',
        'Konfirmasi password tidak sesuai.',
        icon: const Icon(Icons.warning, color: Colors.white),
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.orange.shade600,
        colorText: Colors.white,
        borderRadius: 12,
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        padding: const EdgeInsets.all(16),
        duration: const Duration(seconds: 3),
        isDismissible: true,
        forwardAnimationCurve: Curves.easeOutBack,
      );
      return;
    }

    try {
      final response = await _getConnect.post(
        BaseUrl.register,
        {
          'name': name,
          'email': email,
          'password': password,
          'password_confirmation': confirmPassword,
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        authToken.write('token', response.body['token']);

        showSnackbar('Success', 'Registrasi berhasil, silakan login.');

        Future.delayed(const Duration(seconds: 2), () {
          if (Get.isRegistered<RegisterController>()) {
            Get.delete<RegisterController>();
          }
          Get.toNamed(Routes.LOGIN);
        });
      } else {
        showSnackbar(
          'Error',
          response.body['error']?.toString() ?? 'Registrasi gagal',
          isError: true,
        );
      }
    } catch (e) {
      showSnackbar('Error', 'Terjadi kesalahan server.', isError: true);
    }
  }

  void showSnackbar(String title, String message, {bool isError = false}) {
    Get.snackbar(
      title,
      message,
      icon: Icon(
        isError ? Icons.error : Icons.check_circle,
        color: Colors.white,
      ),
      snackPosition: SnackPosition.TOP,
      backgroundColor: isError ? Colors.red.shade600 : Colors.green.shade600,
      colorText: Colors.white,
      borderRadius: 12,
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      padding: const EdgeInsets.all(16),
      duration: const Duration(seconds: 3),
      isDismissible: true,
      forwardAnimationCurve: Curves.easeOutBack,
      boxShadows: [
        BoxShadow(
          color: Colors.black.withOpacity(0.2),
          blurRadius: 10,
          offset: const Offset(0, 4),
        )
      ],
    );
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
