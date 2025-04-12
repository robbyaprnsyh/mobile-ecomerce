import 'package:ecommerce/app/modules/kategori/controllers/kategori_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class KategoriView extends GetView<KategoriController> {
  const KategoriView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(KategoriController());
    return Scaffold(
      backgroundColor: const Color(0xFFF0F6FF),
      appBar: AppBar(
        title: const Text('Daftar Kategori'),
        centerTitle: true,
        backgroundColor: const Color(0xFF007EB8),
        foregroundColor: Colors.white,
        elevation: 3,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (controller.kategoriList.isEmpty) {
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
            itemCount: controller.kategoriList.length,
            itemBuilder: (context, index) {
              final kategori = controller.kategoriList[index];
              final createdAt = kategori.createdAt != null
                  ? DateFormat('dd MMM yyyy').format(DateTime.parse(kategori.createdAt!))
                  : '-';

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
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  leading: CircleAvatar(
                    backgroundColor: Colors.teal.withOpacity(0.1),
                    child: const Icon(Icons.category, color: Colors.teal),
                  ),
                  title: Text(
                    kategori.name ?? '-',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  subtitle: Text(
                    'Dibuat: $createdAt',
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
      }),
    );
  }
}
