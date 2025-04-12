import 'package:ecommerce/app/modules/subKategori/controllers/sub_kategori_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SubKategoriView extends GetView<SubKategoriController> {
  const SubKategoriView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SubKategoriController());
    return Scaffold(
      backgroundColor: const Color(0xFFF0F6FF),
      appBar: AppBar(
        title: const Text('Sub Kategori'),
        centerTitle: true,
        backgroundColor: const Color(0xFF007EB8),
        foregroundColor: Colors.white,
        elevation: 2,
      ),
      body: Obx(
        () {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }
          if (controller.subKategoriList.isEmpty) {
            return const Center(
              child: Text(
                'Tidak ada data',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            );
          }
          return Padding(
            padding: const EdgeInsets.all(12.0),
            child: ListView.builder(
              itemCount: controller.subKategoriList.length,
              itemBuilder: (context, index) {
                final subKategori = controller.subKategoriList[index];
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blue.shade100,
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    leading: CircleAvatar(
                      backgroundColor: Colors.green.withOpacity(0.1),
                      child: const Icon(Icons.inventory, color: Colors.green),
                    ),
                    title: Text(
                      subKategori.name ?? '-',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    subtitle: Text(
                      'Kategori: ${subKategori.kategori?.name ?? '-'}',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.blueGrey.shade600,
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
