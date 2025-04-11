import 'package:ecommerce/app/modules/profile/controllers/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final storage = GetStorage();
    final userId = int.tryParse(storage.read('user_id').toString());

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text(
          'Profile',
          style:
              TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 0, 126, 184),
        iconTheme: const IconThemeData(
            color: Colors.white), 
        actionsIconTheme:
            const IconThemeData(color: Colors.white),         actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Get.defaultDialog(
                title: "Konfirmasi",
                middleText: "Apakah kamu yakin ingin logout?",
                textCancel: "Batal",
                textConfirm: "Logout",
                confirmTextColor: Colors.white,
                onConfirm: () {
                  Get.back();
                  controller.logout();
                },
              );
            },
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (userId == null) {
          return const Center(child: Text("ID user tidak valid."));
        }

        final user = controller.getUserById(userId);

        if (user == null) {
          return const Center(child: Text("Data user tidak ditemukan."));
        }

        return SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  ClipPath(
                    clipper: ProfileClipper(),
                    child: Container(
                      height: 220,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color.fromARGB(255, 40, 147, 197),
                            Color.fromARGB(255, 75, 153, 190)
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 120,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 55,
                            backgroundColor: Colors.white,
                            child: CircleAvatar(
                              radius: 50,
                              backgroundImage: NetworkImage(
                                'http://192.168.80.83:8000/public/images/users/${user.profile}',
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            user.name ?? "-",
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 100),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  children: [
                    buildInfoCard(
                        "Email", user.email ?? "-", Icons.email_outlined),
                    buildInfoCard(
                        "No Telepon", user.noTelepon ?? "-", Icons.phone),
                    buildInfoCard(
                        "Jenis Kelamin", user.jenisKelamin ?? "-", Icons.wc),
                    buildInfoCard(
                        "Tanggal Lahir", user.tanggalLahir ?? "-", Icons.cake),
                    buildInfoCard("Role", user.role ?? "-", Icons.person),
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      }),
    );
  }

  Widget buildInfoCard(String title, String value, IconData icon) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        title: Text(
          title,
          style: const TextStyle(fontSize: 14, color: Colors.grey),
        ),
        subtitle: Text(
          value,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        leading: Icon(icon, color: Colors.indigo),
      ),
    );
  }
}

class ProfileClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 50);
    path.quadraticBezierTo(
        size.width / 2, size.height + 40, size.width, size.height - 50);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
