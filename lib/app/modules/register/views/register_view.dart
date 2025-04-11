import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({super.key});

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
                    height: 280,
                    color: Colors.blue,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(height: 30),
                          Lottie.asset(
                            'assets/lottie/2.json',
                            height: 120,
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            'Buat Akun Baru',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            'Isi data untuk mendaftar',
                            style: TextStyle(color: Colors.white70),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 260),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      Card(
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(25),
                          child: Column(
                            children: [
                              TextField(
                                controller: controller.nameController,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Full Name',
                                  prefixIcon: Icon(Icons.person),
                                ),
                              ),
                              const SizedBox(height: 15),
                              TextField(
                                controller: controller.emailController,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Email',
                                  prefixIcon: Icon(Icons.email),
                                ),
                              ),
                              const SizedBox(height: 15),
                              Obx(() => TextField(
                                    controller: controller.passwordController,
                                    obscureText:
                                        controller.isPasswordHidden.value,
                                    decoration: InputDecoration(
                                      border: const OutlineInputBorder(),
                                      labelText: 'Password',
                                      prefixIcon: const Icon(Icons.lock),
                                      suffixIcon: IconButton(
                                        icon: Icon(
                                          controller.isPasswordHidden.value
                                              ? Icons.visibility_off
                                              : Icons.visibility,
                                        ),
                                        onPressed: () {
                                          controller.isPasswordHidden.toggle();
                                        },
                                      ),
                                    ),
                                  )),
                              const SizedBox(height: 15),
                              Obx(() => TextField(
                                    controller: controller
                                        .passwordConfirmationController,
                                    obscureText: controller
                                        .isPasswordConfirmationHidden.value,
                                    decoration: InputDecoration(
                                      border: const OutlineInputBorder(),
                                      labelText: 'Konfirmasi Password',
                                      prefixIcon:
                                          const Icon(Icons.lock_outline),
                                      suffixIcon: IconButton(
                                        icon: Icon(
                                          controller
                                                  .isPasswordConfirmationHidden
                                                  .value
                                              ? Icons.visibility_off
                                              : Icons.visibility,
                                        ),
                                        onPressed: () {
                                          controller
                                              .isPasswordConfirmationHidden
                                              .toggle();
                                        },
                                      ),
                                    ),
                                  )),
                              const SizedBox(height: 25),
                              SizedBox(
                                width: double.infinity,
                                height: 50,
                                child: ElevatedButton.icon(
                                  icon: const Icon(Icons.person_add,
                                      color: Colors.white),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blue.shade600,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                  ),
                                  onPressed: () => controller.registerNow(),
                                  label: const Text(
                                    'Register Now',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 15),
                              TextButton(
                                onPressed: () {
                                  Get.toNamed('/login');
                                },
                                child: const Text(
                                  'Sudah punya akun? Login',
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
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
    path.lineTo(0, size.height - 60);
    path.quadraticBezierTo(
      size.width / 2,
      size.height + 20,
      size.width,
      size.height - 60,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
