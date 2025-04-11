import 'package:ecommerce/app/modules/dashboard/bindings/dashboard_binding.dart';
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

  var obscureText = true.obs;

  void togglePasswordVisibility() {
    obscureText.value = !obscureText.value;
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  void loginNow() async {
    final email = emailController.text.trim();
    final password = passwordController.text;

    // Validasi field kosong
    if (email.isEmpty || password.isEmpty) {
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

    // Kirim request jika lolos validasi
    final response = await _getConnect.post(
      BaseUrl.login,
      {
        'email': email,
        'password': password,
      },
    );

    if (response.statusCode == 200) {
      authToken.write('auth_token', response.body['access_token']);
      authToken.write('user_id', response.body['user']['id']);
      Get.offAll(() => const DashboardView(), binding: DashboardBinding());

      Get.snackbar(
        'Success',
        'Login berhasil.',
        icon: const Icon(Icons.check_circle, color: Colors.white),
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green.shade600,
        colorText: Colors.white,
        borderRadius: 12,
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        padding: const EdgeInsets.all(16),
        duration: const Duration(seconds: 3),
        isDismissible: true,
        forwardAnimationCurve: Curves.easeOutBack,
      );
    } else {
      Get.snackbar(
        'Error',
        response.body['error']?.toString() ?? 'Login gagal',
        icon: const Icon(Icons.error, color: Colors.white),
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red.shade600,
        colorText: Colors.white,
        borderRadius: 12,
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        padding: const EdgeInsets.all(16),
        duration: const Duration(seconds: 4),
        isDismissible: true,
        forwardAnimationCurve: Curves.easeOutBack,
      );
    }
  }
}
