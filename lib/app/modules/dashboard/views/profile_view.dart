import 'package:ecommerce/app/modules/profile/controllers/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final storage = GetStorage();
    final userId = int.tryParse(storage.read('user_id').toString());

    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      appBar: AppBar(
        title: const Text(
          'Profile',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF007EB8),
        iconTheme: const IconThemeData(color: Colors.white),
        actionsIconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Get.dialog(
                Dialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.logout,
                            size: 50, color: Color(0xFF007EB8)),
                        const SizedBox(height: 16),
                        const Text(
                          "Keluar dari akun?",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF007EB8),
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          "Apakah kamu yakin ingin logout dari aplikasi?",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.black87),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            Expanded(
                              child: OutlinedButton(
                                onPressed: () => Get.back(),
                                style: OutlinedButton.styleFrom(
                                  side: const BorderSide(
                                      color: Color(0xFF007EB8)),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: const Text(
                                  "Batal",
                                  style: TextStyle(color: Color(0xFF007EB8)),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  Get.back();
                                  controller.logout();
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF007EB8),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: const Text(
                                  "Logout",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
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

        final tanggalLahir = user.tanggalLahir != null
            ? DateFormat('dd MMMM yyyy', 'id_ID')
                .format(DateTime.parse(user.tanggalLahir!))
            : '-';

        final dibuat = user.createdAt != null
            ? DateFormat('dd MMMM yyyy', 'id_ID')
                .format(DateTime.parse(user.createdAt!))
            : '-';

        return SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  ClipPath(
                    clipper: ProfileClipper(),
                    child: Container(
                      height: 200,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color(0xFF2893C5),
                            Color(0xFF4B99BE),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 110,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 8,
                                  offset: Offset(0, 4),
                                )
                              ],
                            ),
                            child: CircleAvatar(
                              radius: 55,
                              backgroundColor: Colors.blue.shade600,
                              child: (user.profile != null &&
                                      user.profile!.isNotEmpty)
                                  ? ClipOval(
                                      child: Image.network(
                                        'http://192.168.80.83:8000/${user.profile}',
                                        width: 110,
                                        height: 110,
                                        fit: BoxFit.cover,
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return Center(
                                            child: Text(
                                              _getInitial(user.name),
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 28,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    )
                                  : Text(
                                      _getInitial(user.name),
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 28,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            user.name ?? "-",
                            style: const TextStyle(
                              fontSize: 22,
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
              const SizedBox(height: 110),
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
                        "Tanggal Lahir", tanggalLahir, Icons.calendar_today),
                    buildInfoCard("Dibuat", dibuat, Icons.access_time),
                  ],
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        );
      }),
    );
  }

  String _getInitial(String? name) {
    if (name == null || name.isEmpty) return "?";
    return name.trim().substring(0, 1).toUpperCase();
  }

  Widget buildInfoCard(String title, String value, IconData icon) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: ListTile(
        title: Text(
          title,
          style: const TextStyle(fontSize: 14, color: Colors.grey),
        ),
        subtitle: Text(
          value,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        leading: Container(
          decoration: BoxDecoration(
            color: Colors.blue.shade100,
            shape: BoxShape.circle,
          ),
          padding: const EdgeInsets.all(10),
          child: Icon(icon, color: Colors.blue.shade700),
        ),
      ),
    );
  }
}

class ProfileClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 30);
    path.quadraticBezierTo(
      size.width / 2,
      size.height + 20,
      size.width,
      size.height - 30,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
