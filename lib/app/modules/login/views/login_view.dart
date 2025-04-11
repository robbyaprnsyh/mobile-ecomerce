import 'package:ecommerce/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                ClipPath(
                  clipper: _WaveClipper(),
                  child: Container(
                    height: 300, 
                    color: Colors.blue,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(height: 40),
                          Lottie.asset(
                            'assets/lottie/2.json',
                            height: 120,
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            'Selamat Datang!',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            'Silakan login untuk melanjutkan',
                            style: TextStyle(color: Colors.white70),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 280), 
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Card(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(25),
                      child: Column(
                        children: [
                          TextField(
                            controller: controller.emailController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Email',
                              prefixIcon: Icon(Icons.email),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Obx(() => TextField(
                                controller: controller.passwordController,
                                obscureText: controller.obscureText.value,
                                decoration: InputDecoration(
                                  border: const OutlineInputBorder(),
                                  labelText: 'Password',
                                  prefixIcon: const Icon(Icons.lock),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      controller.obscureText.value
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                    ),
                                    onPressed: controller.togglePasswordVisibility,
                                  ),
                                ),
                              )),
                          const SizedBox(height: 30),
                          SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue.shade600,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              icon: const Icon(Icons.login, color: Colors.white),
                              onPressed: controller.loginNow,
                              label: const Text(
                                'Login',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white, 
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Belum punya akun?"),
                              TextButton(
                                onPressed: () {
                                  Get.toNamed(Routes.REGISTER);
                                },
                                child: const Text(
                                  'Daftar',
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 80); 
    path.quadraticBezierTo(
      size.width / 2, size.height + 40, 
      size.width, size.height - 80,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
